mod config;
mod state;
mod ui;
mod plotter;

use egui_wgpu::renderer::ScreenDescriptor;
use winit::{
    window::{WindowBuilder},
    event::*,
    event_loop::{EventLoopBuilder, ControlFlow}, 
    dpi::LogicalSize,
};

#[cfg(target_arch="wasm32")]
use wasm_bindgen::prelude::*;

use crate::{
    config::*,
    ui::UI,
    plotter::Plotter,
};

#[cfg_attr(target_arch="wasm32", wasm_bindgen(start))]
pub async fn run() {
    cfg_if::cfg_if! {
        if #[cfg(target_arch = "wasm32")] {
            std::panic::set_hook(Box::new(console_error_panic_hook::hook));
            console_log::init_with_level(log::Level::Warn).expect("Couldn't initialize logger");
        } else {
            env_logger::init();
        }
    }
    
    let event_loop = EventLoopBuilder::<winit::event::WindowEvent>::with_user_event().build();
    let proxy = event_loop.create_proxy();
    let window = WindowBuilder::new()
        .with_title(WINDOW_TITLE)
        .with_inner_size(LogicalSize::new(DEFAULT_WIDTH, DEFAULT_HEIGHT))
        .build(&event_loop)
        .unwrap();

    #[cfg(target_arch = "wasm32")]
    {
        use winit::platform::web::WindowExtWebSys;
        web_sys::window()
            .and_then(|win| win.document())
            .and_then(|doc| {
                let dst = doc.get_element_by_id("main-box")?;
                let canvas = web_sys::Element::from(window.canvas());
                dst.append_child(&canvas).ok()?;
                Some(())
            })
            .expect("Couldn't append canvas to document body.");
    }

    let mut winit_state = egui_winit::State::new(&event_loop);
    winit_state.set_pixels_per_point(window.scale_factor() as f32);

    let instance = wgpu::Instance::new(wgpu::Backends::all());
    let surface = unsafe { instance.create_surface(&window) };
    let adapter = instance.request_adapter(&wgpu::RequestAdapterOptions {
        power_preference: wgpu::PowerPreference::HighPerformance,
        compatible_surface: Some(&surface),
        force_fallback_adapter: false,
    }).await.unwrap();
    let (device, queue) = adapter.request_device(&wgpu::DeviceDescriptor {
        features: wgpu::Features::empty(),
        limits: wgpu::Limits::default(),
        label: Some("Device"),
    }, None).await.unwrap();
    let texture_format = surface.get_supported_formats(&adapter)[0];
    let mut config = wgpu::SurfaceConfiguration {
        usage: wgpu::TextureUsages::RENDER_ATTACHMENT,
        format: texture_format,
        width: window.inner_size().width,
        height: window.inner_size().height,
        present_mode: wgpu::PresentMode::Fifo,
        alpha_mode: wgpu::CompositeAlphaMode::Auto,
    };
    surface.configure(&device, &config);

    let ctx = egui::Context::default();

    let mut renderer = egui_wgpu::renderer::Renderer::new(&device, texture_format, None, 1);

    let mut plotter = Plotter::new(&device, texture_format, DEFAULT_STATE);
    let plot_id = renderer.register_native_texture(&device, &plotter.texture_view, wgpu::FilterMode::Linear);

    let mut ui = UI::new(plot_id.clone(), DEFAULT_STATE);

    ui.state.dpi = window.scale_factor() as f32;

    let mut cur_z_state = ElementState::Released;

    event_loop.run(move |event, _, control_flow| {
        match event {
            Event::UserEvent(event) => {
                if winit_state.on_event(&ctx, &event).repaint {
                    window.request_redraw();
                }
            },
            Event::WindowEvent {
                ref event,
                window_id,
            } if window_id == window.id() => {
                match event {
                    WindowEvent::CloseRequested => {
                       *control_flow = ControlFlow::Exit;
                    },
                    WindowEvent::Resized(new_siz) => {
                        config.width = new_siz.width;
                        config.height = new_siz.height;
                        surface.configure(&device, &config);
                    },
                    WindowEvent::ScaleFactorChanged {
                        scale_factor, 
                        new_inner_size,
                    } => {
                        ui.state.dpi = *scale_factor as f32;

                        config.width = new_inner_size.width;
                        config.height = new_inner_size.height;
                        surface.configure(&device, &config);
                    },
                    WindowEvent::KeyboardInput { device_id, input, is_synthetic } => {
                        match input.virtual_keycode.unwrap() {
                            VirtualKeyCode::Z => {
                                if input.state != cur_z_state {
                                    match input.state {
                                        ElementState::Pressed => {
                                            proxy.send_event(WindowEvent::ModifiersChanged(ModifiersState::CTRL)).unwrap();
                                        },
                                        ElementState::Released => {
                                            proxy.send_event(WindowEvent::ModifiersChanged(ModifiersState::empty())).unwrap();
                                        }
                                    }
                                    cur_z_state = input.state;
                                }
                            },
                            _ => {}
                        }
                    },
                    _ => {},
                }
                if winit_state.on_event(&ctx, &event).repaint {
                    window.request_redraw();
                }
            },
            Event::RedrawRequested(window_id) if window_id == window.id() => {
                ctx.begin_frame(winit_state.take_egui_input(&window));
                ui.ui(&ctx);
                let egui_output = ctx.end_frame();
                winit_state.handle_platform_output(&window, &ctx, egui_output.platform_output);

                plotter.state = ui.state.clone();
                plotter.update_texture(&surface, &device, &queue);

                renderer.update_egui_texture_from_wgpu_texture(&device, &plotter.texture_view, wgpu::FilterMode::Linear, plot_id);

                let clipped_primitives = ctx.tessellate(egui_output.shapes);
                let screen_descriptor = ScreenDescriptor {
                    size_in_pixels: [config.width, config.height],
                    pixels_per_point: window.scale_factor() as f32,
                };

                let output_frame = surface.get_current_texture().unwrap();
                let output_view = output_frame.texture.create_view(&wgpu::TextureViewDescriptor::default());
                let mut encoder = device.create_command_encoder(&wgpu::CommandEncoderDescriptor {
                    label: Some("Egui Encoder"),
                });

                for idx in 0..egui_output.textures_delta.set.len() {
                    renderer.update_texture(&device, &queue, egui_output.textures_delta.set[idx].0, &egui_output.textures_delta.set[idx].1);
                }
                for idx in 0..egui_output.textures_delta.free.len() {
                    renderer.free_texture(&egui_output.textures_delta.free[idx]);
                }
                renderer.update_buffers(&device, &queue, &mut encoder, &clipped_primitives, &screen_descriptor);
                
                {
                    let mut render_pass = encoder.begin_render_pass(&wgpu::RenderPassDescriptor {
                        label: Some("Egui Render Pass"),
                        color_attachments: &[Some(wgpu::RenderPassColorAttachment {
                            view: &output_view,
                            resolve_target: None,
                            ops: wgpu::Operations {
                                load: wgpu::LoadOp::Clear(wgpu::Color::TRANSPARENT),
                                store: true,
                            },
                        })],
                        depth_stencil_attachment: None,
                    });
                    renderer.render(&mut render_pass, &clipped_primitives, &screen_descriptor);
                }

                queue.submit(std::iter::once(encoder.finish()));
                output_frame.present();
            },
            _ => {},
        }
    });
}

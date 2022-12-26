mod config;
mod state;
mod ui;
mod plotter;

use egui_wgpu::renderer::ScreenDescriptor;
use winit::{
    window::{WindowBuilder},
    event::*,
    event_loop::{EventLoop, ControlFlow}, 
    dpi::LogicalSize,
};

use crate::{
    config::*,
    state::State,
    ui::UI,
    plotter::Plotter,
};

fn main() {
    env_logger::init();
    
    let event_loop = EventLoop::new();
    let window = WindowBuilder::new()
        .with_title(WINDOW_TITLE)
        .with_inner_size(LogicalSize::new(DEFAULT_WIDTH, DEFAULT_HEIGHT))
        .build(&event_loop)
        .unwrap();
    let mut winit_state = egui_winit::State::new(&event_loop);
    winit_state.set_pixels_per_point(window.scale_factor() as f32);

    let instance = wgpu::Instance::new(wgpu::Backends::all());
    let surface = unsafe { instance.create_surface(&window) };
    let adaptor = pollster::block_on(instance.request_adapter(&wgpu::RequestAdapterOptions {
        power_preference: wgpu::PowerPreference::HighPerformance,
        compatible_surface: Some(&surface),
        force_fallback_adapter: false,
    })).unwrap();
    let (device, queue) = pollster::block_on(adaptor.request_device(&wgpu::DeviceDescriptor {
        features: wgpu::Features::empty(),
        limits: wgpu::Limits::default(),
        label: None,
    }, None)).unwrap();
    let mut config = wgpu::SurfaceConfiguration {
        usage: wgpu::TextureUsages::RENDER_ATTACHMENT,
        format: FORMAT,
        width: window.inner_size().width,
        height: window.inner_size().height,
        present_mode: wgpu::PresentMode::Fifo,
        alpha_mode: wgpu::CompositeAlphaMode::Auto,
    };
    surface.configure(&device, &config);

    let state = State::new();
    let ui = UI::new();
    let plotter = Plotter::new();
    let mut renderer = egui_wgpu::renderer::Renderer::new(&device, FORMAT, None, 1);

    let mut ctx = egui::Context::default();

    event_loop.run(move |event, _, control_flow| {
        match event {
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
                    _ => {},
                }
                winit_state.on_event(&ctx, &event);
            },
            Event::RedrawRequested(window_id) if window_id == window.id() => {
                let egui_output = ctx.run(winit_state.take_egui_input(&window), |ctx| {
                    egui::CentralPanel::default().show(&ctx, |ui| {
                        ui.label("This is a label");
                        ui.hyperlink("https://github.com/emilk/egui");
                        if ui.button("Click me").clicked() { }
                    });
                });

                winit_state.handle_platform_output(&window, &ctx, egui_output.platform_output);
                let clipped_primitives = ctx.tessellate(egui_output.shapes);
                let screen_descriptor = ScreenDescriptor {
                    size_in_pixels: [config.width, config.height],
                    pixels_per_point: window.scale_factor() as f32,
                };

                let output_frame = surface.get_current_texture().unwrap();
                let output_view = output_frame.texture.create_view(&wgpu::TextureViewDescriptor::default());
                let mut encoder = device.create_command_encoder(&wgpu::CommandEncoderDescriptor {
                    label: Some("Main Encoder"),
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
                        label: Some("Render Pass"),
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
            }
            Event::MainEventsCleared => {
                window.request_redraw();
            },
            _ => {},
        }
    });
}

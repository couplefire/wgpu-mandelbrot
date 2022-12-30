use crate::{
    config::*,
    state::State,
};

pub struct UI {
    pub state: State,
    plot_id: egui::TextureId,
}

impl UI {
    pub fn new(plot_id: egui::TextureId, state: State) -> Self {
        Self {
            state,
            plot_id,
        }
    }

    pub fn ui(&mut self, ctx: &egui::Context) {
        egui::CentralPanel::default()
            .frame(egui::containers::Frame {
                ..Default::default()
            })
            .show(&ctx, |ui| {
                self.state.width = ui.available_width() as u32;
                self.state.height = ui.available_height() as u32;

                egui::plot::Plot::new("mandelbrot")
                    .data_aspect(1.0)
                    .include_x(-2.0)
                    .include_x(2.0)
                    .include_y(-2.0)
                    .include_y(2.0)
                    .show_background(false)
                    .show_axes([false, false])
                    .show_x(false)
                    .show_y(false)
                    .show(ui, |plot_ui| {
                        self.state.min_bd_x = plot_ui.plot_bounds().min()[0] as f32;
                        self.state.min_bd_y = plot_ui.plot_bounds().min()[1] as f32;
                        self.state.max_bd_x = plot_ui.plot_bounds().max()[0] as f32;
                        self.state.max_bd_y = plot_ui.plot_bounds().max()[1] as f32;

                        if plot_ui.pointer_coordinate().is_some() {
                            self.state.cursor_x = plot_ui.pointer_coordinate().unwrap().x as f32;
                            self.state.cursor_y = plot_ui.pointer_coordinate().unwrap().y as f32;
                        }
                    });
            });
        
        let frame_style = egui::containers::Frame {
            shadow: egui::epaint::Shadow {
                extrusion: 0.0,
                color: egui::Color32::TRANSPARENT,
            },
            fill: egui::Color32::BLACK,
            inner_margin: egui::style::Margin {
                left: 10.0,
                right: 10.0,
                top: 10.0,
                bottom: 10.0,
            },
            outer_margin: egui::style::Margin {
                left: 10.0,
                right: 10.0,
                top: 10.0,
                bottom: 10.0,
            },
            rounding: egui::Rounding {
                nw: 10.0,
                ne: 10.0,
                sw: 10.0,
                se: 10.0,
            },
            stroke: egui::Stroke {
                width: 1.0,
                color: egui::Color32::GRAY,
            },
        };
        
        egui::Window::new("Settings")
            .resizable(false)
            .constrain(true)
            .default_pos([0.0, 0.0])
            .frame(frame_style)
            .show(&ctx, |ui| {
                ui.label("Max Iteration:");
                ui.add(egui::Slider::new(&mut self.state.max_iter, 1..=MAX_ITER_LIMIT).logarithmic(true));
                ui.separator();
                ui.label("Cursor Coordinates:");
                ui.colored_label(egui::Color32::RED, String::new() + "(" + &self.state.cursor_x.to_string() + ", " + &self.state.cursor_y.to_string() + ")");
            });

        egui::Window::new("HSLuv Color Settings")
            .resizable(false)
            .constrain(true)
            .default_pos([MAX_TEX_WIDTH as f32, 0.0])
            .frame(frame_style)
            .show(&ctx, |ui| {
                ui.label("Hue Period:");
                ui.add(egui::Slider::new(&mut self.state.hue_prd, 100.0..=10000.0).logarithmic(true));
                ui.label("Saturation Period:");
                ui.add(egui::Slider::new(&mut self.state.sat_prd, 100.0..=10000.0).logarithmic(true));
                ui.label("Lightness Period:");
                ui.add(egui::Slider::new(&mut self.state.lgt_prd, 100.0..=10000.0).logarithmic(true));
                ui.separator();
                ui.label("Hue Offset:");
                ui.add(egui::Slider::new(&mut self.state.hue_offset, 0.0..=1.0));
                ui.label("Saturation Offset:");
                ui.add(egui::Slider::new(&mut self.state.sat_offset, 0.0..=1.0));
                ui.label("Lightness Offset:");
                ui.add(egui::Slider::new(&mut self.state.lgt_offset, 0.0..=1.0));
            });
        
        egui::Area::new("mandelbrot")
            .movable(false)
            .fixed_pos([0.0, 0.0])
            .interactable(false)
            .order(egui::Order::Background)
            .show(&ctx, |ui| {
                ui.add(egui::widgets::Image::new(
                    self.plot_id, 
                    ui.available_size()
                ).uv(egui::Rect::from_min_max(
                    egui::pos2(
                        0.0,
                        self.state.height as f32 * self.state.dpi / MAX_TEX_HEIGHT as f32
                    ), 
                    egui::pos2(
                        self.state.width as f32 * self.state.dpi / MAX_TEX_WIDTH as f32, 
                        0.0
                    )
                )));
            });
    }
}
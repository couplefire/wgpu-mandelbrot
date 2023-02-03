use crate::{
    state::State,
};

pub const NAME: &str = "wgpu-mandelbrot";

pub const WINDOW_TITLE: &str = "Mandelbrot Set";

pub const DEFAULT_WIDTH: u32 = 1200;
pub const DEFAULT_HEIGHT: u32 = 800;

pub const MAX_TEX_WIDTH: u32 = 8192;
pub const MAX_TEX_HEIGHT: u32 = 8192;

pub const STORAGE_FORMAT: wgpu::TextureFormat = wgpu::TextureFormat::Rgba16Float;

pub const DEFAULT_STATE: State = State::new(
    1.0,

    DEFAULT_WIDTH,
    DEFAULT_HEIGHT,

    -2.0,
    -2.0,
    2.0,
    2.0,

    100.0,
    100.0,
    100.0,

    0.75,
    0.27,
    0.00,

    0.0,
    0.0,

    300,
);

pub const MAX_ITER_LIMIT: u32 = 10000;

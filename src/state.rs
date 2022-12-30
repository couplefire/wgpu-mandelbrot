#[repr(C)]
#[derive(Debug, Clone, Copy, bytemuck::Pod, bytemuck::Zeroable)]
pub struct State {
    pub dpi: f32,

    pub width: u32,
    pub height: u32,

    pub min_bd_x: f32,
    pub min_bd_y: f32,
    pub max_bd_x: f32,
    pub max_bd_y: f32,

    pub hue_prd: f32,
    pub sat_prd: f32,
    pub lgt_prd: f32,

    pub hue_offset: f32,
    pub sat_offset: f32,
    pub lgt_offset: f32,

    pub cursor_x: f32,
    pub cursor_y: f32,

    pub max_iter: u32,
}

impl State {
    pub const fn new(
        dpi: f32, 

        width: u32, 
        height: u32, 

        min_bd_x: f32,
        min_bd_y: f32,
        max_bd_x: f32,
        max_bd_y: f32,

        hue_prd: f32,
        sat_prd: f32,
        val_prd: f32,

        hue_offset: f32,
        sat_offset: f32,
        val_offset: f32,

        cursor_x: f32,
        cursor_y: f32,

        max_iter: u32
    ) -> Self {
        Self {
            dpi,

            width,
            height,

            min_bd_x,
            min_bd_y,
            max_bd_x,
            max_bd_y,

            hue_prd,
            sat_prd,
            lgt_prd: val_prd,

            hue_offset,
            sat_offset,
            lgt_offset: val_offset,

            cursor_x,
            cursor_y,

            max_iter,
        }
    }
}
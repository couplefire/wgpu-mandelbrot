fn main() {
    pollster::block_on(wgpu_mandelbrot::run());
}
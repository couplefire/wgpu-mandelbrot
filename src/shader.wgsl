fn hsluv_lengthOfRayUntilIntersect(theta: f32, x: vec3<f32>, y: vec3<f32>) -> vec3<f32> {
    var len: vec3<f32> = y / (sin(theta) - x*cos(theta));
    if (len.r < 0.0) {
        len.r = 1000.0;
    }
    if (len.g < 0.0) {
        len.g = 1000.0;
    }
    if (len.b < 0.0) {
        len.b = 1000.0;
    }
    return len;
}

fn hsluv_maxChromaForLH(L: f32, H: f32) -> f32 {
    let hrad: f32 = radians(H);
    let m2 = mat3x3<f32> (
        3.2409699419045214, -0.96924363628087983, 0.055630079696993609,
        -1.5373831775700935, 1.8759675015077207, -0.20397695888897657,
        -0.49861076029300328, 0.041555057407175613, 1.0569715142428786  
    );
    let sub1: f32 = pow(L + 16.0, 3.0) / 1560896.0;
    var sub2: f32 = 0.0;

    if (sub1 > 0.0088564516790356308) {
        sub2 = sub1;
    } else {
        sub2 = L/903.2962962962963;
    }

    let top1: vec3<f32>   = (284517.0 * m2[0] - 94839.0  * m2[2]) * sub2;
    let bottom: vec3<f32> = (632260.0 * m2[2] - 126452.0 * m2[1]) * sub2;
    let top2: vec3<f32>   = (838422.0 * m2[2] + 769860.0 * m2[1] + 731718.0 * m2[0]) * L * sub2;

    let bound0x: vec3<f32> = top1 / bottom;
    let bound0y: vec3<f32> = top2 / bottom;

    let bound1x: vec3<f32> =              top1 / (bottom + 126452.0);
    let bound1y: vec3<f32> = (top2 - 769860.0*L) / (bottom + 126452.0);

    let lengths0: vec3<f32> = hsluv_lengthOfRayUntilIntersect(hrad, bound0x, bound0y );
    let lengths1: vec3<f32> = hsluv_lengthOfRayUntilIntersect(hrad, bound1x, bound1y );

    return  min(lengths0.r,
            min(lengths1.r,
            min(lengths0.g,
            min(lengths1.g,
            min(lengths0.b,
                lengths1.b)))));
}

fn hsluv_fromLinear(c: f32) -> f32 {
    if (c <= 0.0031308) {
        return 12.92*c;
    } else {
        return 1.055 * pow(c, 1.0 / 2.4) - 0.055;
    }
}

fn hsluv_fromLinear_1(c: vec3<f32>) -> vec3<f32> {
    return vec3<f32>(hsluv_fromLinear(c.r), hsluv_fromLinear(c.g), hsluv_fromLinear(c.b));
}

fn hsluv_toLinear(c: f32) -> f32 {
    if (c > 0.04045) {
        return pow((c + 0.055) / (1.0 + 0.055), 2.4);
    } else {
        return c / 12.92;
    }
}

fn hsluv_toLinear_1(c: vec3<f32>) -> vec3<f32> {
    return vec3<f32>(hsluv_toLinear(c.r), hsluv_toLinear(c.g), hsluv_toLinear(c.b));
}

fn hsluv_lToY(L: f32) -> f32 {
    if (L <= 8.0) {
        return L / 903.2962962962963;
    } else {
        return pow((L + 16.0) / 116.0, 3.0);
    }
}

fn xyzToRgb(tuple: vec3<f32>) -> vec3<f32> {
    let m: mat3x3<f32> = mat3x3<f32>( 
        3.2409699419045214  ,-1.5373831775700935 ,-0.49861076029300328 ,
       -0.96924363628087983 , 1.8759675015077207 , 0.041555057407175613,
        0.055630079696993609,-0.20397695888897657, 1.0569715142428786  
    );
    return hsluv_fromLinear_1(tuple*m);
}

fn luvToXyz(tuple: vec3<f32>) -> vec3<f32> {
    let L: f32 = tuple.x;

    let U: f32 = tuple.y / (13.0 * L) + 0.19783000664283681;
    let V: f32 = tuple.z / (13.0 * L) + 0.468319994938791;

    let Y: f32 = hsluv_lToY(L);
    let X: f32 = 2.25 * U * Y / V;
    let Z: f32 = (3./V - 5.)*Y - (X/3.);

    return vec3<f32>(X, Y, Z);
}

fn lchToLuv(tuple: vec3<f32>) -> vec3<f32> {
    let hrad: f32 = radians(tuple.b);
    return vec3<f32>(
        tuple.r,
        cos(hrad) * tuple.g,
        sin(hrad) * tuple.g
    );
}

fn hsluvToLch(tuple: vec3<f32>) -> vec3<f32> {
    var tmp = tuple;
    tmp.g *= hsluv_maxChromaForLH(tuple.b, tuple.r) * .01;
    return tmp.bgr;
}

fn lchToRgb(tuple: vec3<f32>) -> vec3<f32> {
    return xyzToRgb(luvToXyz(lchToLuv(tuple)));
}

fn hsluvToRgb(tuple: vec3<f32>) -> vec3<f32> {
    return lchToRgb(hsluvToLch(tuple));
}

struct State {
    dpi: f32,

    width: u32,
    height: u32,

    min_bd_x: f32,
    min_bd_y: f32,
    max_bd_x: f32,
    max_bd_y: f32,

    hue_prd: f32,
    sat_prd: f32,
    lgt_prd: f32,

    hue_offset: f32,
    sat_offset: f32,
    lgt_offset: f32,

    cursor_x: f32,
    cursor_y: f32,

    max_iter: u32,
}

@vertex
fn vs_main(@location(0) model: vec2<f32>) -> @builtin(position) vec4<f32> {
    return vec4<f32>(model[0], model[1], 0.0, 1.0);
}

@group(0) @binding(0)
var mandelbrot_tex: texture_storage_2d<rgba16float, write>;
@group(1) @binding(0)
var<uniform> state: State;

fn blend(x: f32) -> f32 {
    return clamp(1.0 - log2(log(x)), 0.0, 1.0);
}

fn make_zig_zag(x: f32) -> f32 {
    if (x >= 1.0) {
        return 2.0 - x;
    } else {
        return x;
    }
}

fn get_hue(x: f32) -> f32 {
    return fract(x/(state.hue_prd) + state.hue_offset);
}

fn get_sat(x: f32) -> f32 {
    return make_zig_zag(2.0*fract(x/(2.0*(state.sat_prd)) + state.sat_offset));
}

fn get_lgt(x: f32) -> f32 {
    return make_zig_zag(2.0*fract(x/(2.0*(state.lgt_prd)) + state.lgt_offset));
}

fn get_color(x0: f32, y0: f32) -> vec4<f32> {
    var x: f32 = 0.0;
    var y: f32 = 0.0;

    var iter: u32 = u32(0);
    let max_iter = state.max_iter;

    while (x*x + y*y <= 4.0 && iter < max_iter) {
        let x_tmp: f32 = x*x - y*y + x0;
        y = 2.0*x*y + y0;
        x = x_tmp;
        iter = iter + u32(1);
    }

    var color: vec3<f32>;

    if (iter == max_iter) {
        color = vec3<f32>(0.0, 0.0, 0.0);
    } else {
        let val = f32(iter) - 1.0 + blend(sqrt(x*x + y*y));
        color = vec3<f32>(get_hue(val)*360.0, get_sat(val)*100.0, get_lgt(val)*100.0);
    }
    return vec4<f32>(hsluv_toLinear_1(hsluvToRgb(color)), 0.0);
}

@fragment
fn fs_main(@builtin(position) in: vec4<f32>) -> @location(0) vec4<f32> {
    if (in[0] < state.dpi * f32(state.width) && in[1] < state.dpi * f32(state.height)) {
        textureStore(
            mandelbrot_tex, 
            vec2<i32>(
                i32(in[0]), 
                i32(in[1])
            ),
            get_color(
                state.min_bd_x + (state.max_bd_x - state.min_bd_x) * ((in[0] + 0.5) / (state.dpi * f32(state.width))),
                state.min_bd_y + (state.max_bd_y - state.min_bd_y) * ((in[1] + 0.5) / (state.dpi * f32(state.height)))
            )
        );
    }
    return vec4<f32>(0.0, 0.0, 0.0, 0.0);
}
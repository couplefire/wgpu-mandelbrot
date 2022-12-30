fn hsluv_intersectLineLine(line1x: vec3<f32>, line1y: vec3<f32>, line2x: vec3<f32>, line2y: vec3<f32>) -> vec3<f32> {
    var line1x_1: vec3<f32>;
    var line1y_1: vec3<f32>;
    var line2x_1: vec3<f32>;
    var line2y_1: vec3<f32>;

    line1x_1 = line1x;
    line1y_1 = line1y;
    line2x_1 = line2x;
    line2y_1 = line2y;
    let _e9 = line1y_1;
    let _e10 = line2y_1;
    let _e12 = line2x_1;
    let _e13 = line1x_1;
    return ((_e9 - _e10) / (_e12 - _e13));
}

fn hsluv_distanceFromPole(pointx: vec3<f32>, pointy: vec3<f32>) -> vec3<f32> {
    var pointx_1: vec3<f32>;
    var pointy_1: vec3<f32>;

    pointx_1 = pointx;
    pointy_1 = pointy;
    let _e5 = pointx_1;
    let _e6 = pointx_1;
    let _e8 = pointy_1;
    let _e9 = pointy_1;
    _ = ((_e5 * _e6) + (_e8 * _e9));
    let _e12 = pointx_1;
    let _e13 = pointx_1;
    let _e15 = pointy_1;
    let _e16 = pointy_1;
    return sqrt(((_e12 * _e13) + (_e15 * _e16)));
}

fn hsluv_lengthOfRayUntilIntersect(theta: f32, x: vec3<f32>, y: vec3<f32>) -> vec3<f32> {
    var theta_1: f32;
    var x_1: vec3<f32>;
    var y_1: vec3<f32>;
    var len: vec3<f32>;

    theta_1 = theta;
    x_1 = x;
    y_1 = y;
    let _e7 = y_1;
    _ = theta_1;
    let _e9 = theta_1;
    let _e11 = x_1;
    _ = theta_1;
    let _e13 = theta_1;
    len = (_e7 / (vec3<f32>(sin(_e9)) - (_e11 * cos(_e13))));
    let _e20 = len;
    if (_e20.x < 0.0) {
        {
            len.x = 1000.0;
        }
    }
    let _e26 = len;
    if (_e26.y < 0.0) {
        {
            len.y = 1000.0;
        }
    }
    let _e32 = len;
    if (_e32.z < 0.0) {
        {
            len.z = 1000.0;
        }
    }
    let _e38 = len;
    return _e38;
}

fn hsluv_maxSafeChromaForL(L: f32) -> f32 {
    var L_1: f32;
    var m2_: mat3x3<f32>;
    var sub0_: f32;
    var sub1_: f32;
    var local: f32;
    var sub2_: f32;
    var top1_: vec3<f32>;
    var bottom: vec3<f32>;
    var top2_: vec3<f32>;
    var bounds0x: vec3<f32>;
    var bounds0y: vec3<f32>;
    var bounds1x: vec3<f32>;
    var bounds1y: vec3<f32>;
    var xs0_: vec3<f32>;
    var xs1_: vec3<f32>;
    var lengths0_: vec3<f32>;
    var lengths1_: vec3<f32>;

    L_1 = L;
    m2_ = mat3x3<f32>(vec3<f32>(3.2409698963165283, -(0.9692436456680298), 0.05563008040189743), vec3<f32>(-(1.5373831987380981), 1.8759675025939941, -(0.20397695899009705)), vec3<f32>(-(0.4986107647418976), 0.04155505821108818, 1.056971549987793));
    let _e21 = L_1;
    sub0_ = (_e21 + 16.0);
    let _e25 = sub0_;
    let _e26 = sub0_;
    let _e28 = sub0_;
    sub1_ = (((_e25 * _e26) * _e28) * 6.409999855350179e-7);
    let _e33 = sub1_;
    if (_e33 > 0.008856452070176601) {
        let _e36 = sub1_;
        local = _e36;
    } else {
        let _e37 = L_1;
        local = (_e37 / 903.2963256835938);
    }
    let _e41 = local;
    sub2_ = _e41;
    let _e46 = m2_[0];
    let _e51 = m2_[2];
    let _e54 = sub2_;
    top1_ = (((284517.0 * _e46) - (94839.0 * _e51)) * _e54);
    let _e60 = m2_[2];
    let _e65 = m2_[1];
    let _e68 = sub2_;
    bottom = (((632260.0 * _e60) - (126452.0 * _e65)) * _e68);
    let _e74 = m2_[2];
    let _e79 = m2_[1];
    let _e85 = m2_[0];
    let _e88 = L_1;
    let _e90 = sub2_;
    top2_ = (((((838422.0 * _e74) + (769860.0 * _e79)) + (731718.0 * _e85)) * _e88) * _e90);
    let _e93 = top1_;
    let _e94 = bottom;
    bounds0x = (_e93 / _e94);
    let _e97 = top2_;
    let _e98 = bottom;
    bounds0y = (_e97 / _e98);
    let _e101 = top1_;
    let _e102 = bottom;
    bounds1x = (_e101 / (_e102 + vec3<f32>(126452.0)));
    let _e108 = top2_;
    let _e110 = L_1;
    let _e114 = bottom;
    bounds1y = ((_e108 - vec3<f32>((769860.0 * _e110))) / (_e114 + vec3<f32>(126452.0)));
    _ = bounds0x;
    _ = bounds0y;
    let _e124 = bounds0x;
    _ = (vec3<f32>(-(1.0)) / _e124);
    _ = vec3<f32>(0.0);
    let _e129 = bounds0x;
    let _e130 = bounds0y;
    let _e133 = bounds0x;
    let _e138 = hsluv_intersectLineLine(_e129, _e130, (vec3<f32>(-(1.0)) / _e133), vec3<f32>(0.0));
    xs0_ = _e138;
    _ = bounds1x;
    _ = bounds1y;
    let _e144 = bounds1x;
    _ = (vec3<f32>(-(1.0)) / _e144);
    _ = vec3<f32>(0.0);
    let _e149 = bounds1x;
    let _e150 = bounds1y;
    let _e153 = bounds1x;
    let _e158 = hsluv_intersectLineLine(_e149, _e150, (vec3<f32>(-(1.0)) / _e153), vec3<f32>(0.0));
    xs1_ = _e158;
    _ = xs0_;
    let _e161 = bounds0y;
    let _e162 = xs0_;
    let _e163 = bounds0x;
    _ = (_e161 + (_e162 * _e163));
    let _e166 = xs0_;
    let _e167 = bounds0y;
    let _e168 = xs0_;
    let _e169 = bounds0x;
    let _e172 = hsluv_distanceFromPole(_e166, (_e167 + (_e168 * _e169)));
    lengths0_ = _e172;
    _ = xs1_;
    let _e175 = bounds1y;
    let _e176 = xs1_;
    let _e177 = bounds1x;
    _ = (_e175 + (_e176 * _e177));
    let _e180 = xs1_;
    let _e181 = bounds1y;
    let _e182 = xs1_;
    let _e183 = bounds1x;
    let _e186 = hsluv_distanceFromPole(_e180, (_e181 + (_e182 * _e183)));
    lengths1_ = _e186;
    let _e188 = lengths0_;
    _ = _e188.x;
    let _e190 = lengths1_;
    _ = _e190.x;
    let _e192 = lengths0_;
    _ = _e192.y;
    let _e194 = lengths1_;
    _ = _e194.y;
    let _e196 = lengths0_;
    _ = _e196.z;
    let _e198 = lengths1_;
    _ = _e198.z;
    let _e200 = lengths0_;
    let _e202 = lengths1_;
    _ = min(_e200.z, _e202.z);
    let _e205 = lengths1_;
    let _e207 = lengths0_;
    _ = _e207.z;
    let _e209 = lengths1_;
    _ = _e209.z;
    let _e211 = lengths0_;
    let _e213 = lengths1_;
    _ = min(_e205.y, min(_e211.z, _e213.z));
    let _e217 = lengths0_;
    let _e219 = lengths1_;
    _ = _e219.y;
    let _e221 = lengths0_;
    _ = _e221.z;
    let _e223 = lengths1_;
    _ = _e223.z;
    let _e225 = lengths0_;
    let _e227 = lengths1_;
    _ = min(_e225.z, _e227.z);
    let _e230 = lengths1_;
    let _e232 = lengths0_;
    _ = _e232.z;
    let _e234 = lengths1_;
    _ = _e234.z;
    let _e236 = lengths0_;
    let _e238 = lengths1_;
    _ = min(_e217.y, min(_e230.y, min(_e236.z, _e238.z)));
    let _e243 = lengths1_;
    let _e245 = lengths0_;
    _ = _e245.y;
    let _e247 = lengths1_;
    _ = _e247.y;
    let _e249 = lengths0_;
    _ = _e249.z;
    let _e251 = lengths1_;
    _ = _e251.z;
    let _e253 = lengths0_;
    let _e255 = lengths1_;
    _ = min(_e253.z, _e255.z);
    let _e258 = lengths1_;
    let _e260 = lengths0_;
    _ = _e260.z;
    let _e262 = lengths1_;
    _ = _e262.z;
    let _e264 = lengths0_;
    let _e266 = lengths1_;
    _ = min(_e258.y, min(_e264.z, _e266.z));
    let _e270 = lengths0_;
    let _e272 = lengths1_;
    _ = _e272.y;
    let _e274 = lengths0_;
    _ = _e274.z;
    let _e276 = lengths1_;
    _ = _e276.z;
    let _e278 = lengths0_;
    let _e280 = lengths1_;
    _ = min(_e278.z, _e280.z);
    let _e283 = lengths1_;
    let _e285 = lengths0_;
    _ = _e285.z;
    let _e287 = lengths1_;
    _ = _e287.z;
    let _e289 = lengths0_;
    let _e291 = lengths1_;
    _ = min(_e243.x, min(_e270.y, min(_e283.y, min(_e289.z, _e291.z))));
    let _e297 = lengths0_;
    let _e299 = lengths1_;
    _ = _e299.x;
    let _e301 = lengths0_;
    _ = _e301.y;
    let _e303 = lengths1_;
    _ = _e303.y;
    let _e305 = lengths0_;
    _ = _e305.z;
    let _e307 = lengths1_;
    _ = _e307.z;
    let _e309 = lengths0_;
    let _e311 = lengths1_;
    _ = min(_e309.z, _e311.z);
    let _e314 = lengths1_;
    let _e316 = lengths0_;
    _ = _e316.z;
    let _e318 = lengths1_;
    _ = _e318.z;
    let _e320 = lengths0_;
    let _e322 = lengths1_;
    _ = min(_e314.y, min(_e320.z, _e322.z));
    let _e326 = lengths0_;
    let _e328 = lengths1_;
    _ = _e328.y;
    let _e330 = lengths0_;
    _ = _e330.z;
    let _e332 = lengths1_;
    _ = _e332.z;
    let _e334 = lengths0_;
    let _e336 = lengths1_;
    _ = min(_e334.z, _e336.z);
    let _e339 = lengths1_;
    let _e341 = lengths0_;
    _ = _e341.z;
    let _e343 = lengths1_;
    _ = _e343.z;
    let _e345 = lengths0_;
    let _e347 = lengths1_;
    _ = min(_e326.y, min(_e339.y, min(_e345.z, _e347.z)));
    let _e352 = lengths1_;
    let _e354 = lengths0_;
    _ = _e354.y;
    let _e356 = lengths1_;
    _ = _e356.y;
    let _e358 = lengths0_;
    _ = _e358.z;
    let _e360 = lengths1_;
    _ = _e360.z;
    let _e362 = lengths0_;
    let _e364 = lengths1_;
    _ = min(_e362.z, _e364.z);
    let _e367 = lengths1_;
    let _e369 = lengths0_;
    _ = _e369.z;
    let _e371 = lengths1_;
    _ = _e371.z;
    let _e373 = lengths0_;
    let _e375 = lengths1_;
    _ = min(_e367.y, min(_e373.z, _e375.z));
    let _e379 = lengths0_;
    let _e381 = lengths1_;
    _ = _e381.y;
    let _e383 = lengths0_;
    _ = _e383.z;
    let _e385 = lengths1_;
    _ = _e385.z;
    let _e387 = lengths0_;
    let _e389 = lengths1_;
    _ = min(_e387.z, _e389.z);
    let _e392 = lengths1_;
    let _e394 = lengths0_;
    _ = _e394.z;
    let _e396 = lengths1_;
    _ = _e396.z;
    let _e398 = lengths0_;
    let _e400 = lengths1_;
    return min(_e297.x, min(_e352.x, min(_e379.y, min(_e392.y, min(_e398.z, _e400.z)))));
}

fn hsluv_maxChromaForLH(L_2: f32, H: f32) -> f32 {
    var L_3: f32;
    var H_1: f32;
    var hrad: f32;
    var m2_1: mat3x3<f32>;
    var sub1_1: f32;
    var local_1: f32;
    var sub2_1: f32;
    var top1_1: vec3<f32>;
    var bottom_1: vec3<f32>;
    var top2_1: vec3<f32>;
    var bound0x: vec3<f32>;
    var bound0y: vec3<f32>;
    var bound1x: vec3<f32>;
    var bound1y: vec3<f32>;
    var lengths0_1: vec3<f32>;
    var lengths1_1: vec3<f32>;

    L_3 = L_2;
    H_1 = H;
    _ = H_1;
    let _e6 = H_1;
    hrad = radians(_e6);
    m2_1 = mat3x3<f32>(vec3<f32>(3.2409698963165283, -(0.9692436456680298), 0.05563008040189743), vec3<f32>(-(1.5373831987380981), 1.8759675025939941, -(0.20397695899009705)), vec3<f32>(-(0.4986107647418976), 0.04155505821108818, 1.056971549987793));
    let _e27 = L_3;
    _ = (_e27 + 16.0);
    let _e31 = L_3;
    sub1_1 = (pow((_e31 + 16.0), 3.0) / 1560896.0);
    let _e39 = sub1_1;
    if (_e39 > 0.008856452070176601) {
        let _e42 = sub1_1;
        local_1 = _e42;
    } else {
        let _e43 = L_3;
        local_1 = (_e43 / 903.2963256835938);
    }
    let _e47 = local_1;
    sub2_1 = _e47;
    let _e52 = m2_1[0];
    let _e57 = m2_1[2];
    let _e60 = sub2_1;
    top1_1 = (((284517.0 * _e52) - (94839.0 * _e57)) * _e60);
    let _e66 = m2_1[2];
    let _e71 = m2_1[1];
    let _e74 = sub2_1;
    bottom_1 = (((632260.0 * _e66) - (126452.0 * _e71)) * _e74);
    let _e80 = m2_1[2];
    let _e85 = m2_1[1];
    let _e91 = m2_1[0];
    let _e94 = L_3;
    let _e96 = sub2_1;
    top2_1 = (((((838422.0 * _e80) + (769860.0 * _e85)) + (731718.0 * _e91)) * _e94) * _e96);
    let _e99 = top1_1;
    let _e100 = bottom_1;
    bound0x = (_e99 / _e100);
    let _e103 = top2_1;
    let _e104 = bottom_1;
    bound0y = (_e103 / _e104);
    let _e107 = top1_1;
    let _e108 = bottom_1;
    bound1x = (_e107 / (_e108 + vec3<f32>(126452.0)));
    let _e114 = top2_1;
    let _e116 = L_3;
    let _e120 = bottom_1;
    bound1y = ((_e114 - vec3<f32>((769860.0 * _e116))) / (_e120 + vec3<f32>(126452.0)));
    _ = hrad;
    _ = bound0x;
    _ = bound0y;
    let _e129 = hrad;
    let _e130 = bound0x;
    let _e131 = bound0y;
    let _e132 = hsluv_lengthOfRayUntilIntersect(_e129, _e130, _e131);
    lengths0_1 = _e132;
    _ = hrad;
    _ = bound1x;
    _ = bound1y;
    let _e137 = hrad;
    let _e138 = bound1x;
    let _e139 = bound1y;
    let _e140 = hsluv_lengthOfRayUntilIntersect(_e137, _e138, _e139);
    lengths1_1 = _e140;
    let _e142 = lengths0_1;
    _ = _e142.x;
    let _e144 = lengths1_1;
    _ = _e144.x;
    let _e146 = lengths0_1;
    _ = _e146.y;
    let _e148 = lengths1_1;
    _ = _e148.y;
    let _e150 = lengths0_1;
    _ = _e150.z;
    let _e152 = lengths1_1;
    _ = _e152.z;
    let _e154 = lengths0_1;
    let _e156 = lengths1_1;
    _ = min(_e154.z, _e156.z);
    let _e159 = lengths1_1;
    let _e161 = lengths0_1;
    _ = _e161.z;
    let _e163 = lengths1_1;
    _ = _e163.z;
    let _e165 = lengths0_1;
    let _e167 = lengths1_1;
    _ = min(_e159.y, min(_e165.z, _e167.z));
    let _e171 = lengths0_1;
    let _e173 = lengths1_1;
    _ = _e173.y;
    let _e175 = lengths0_1;
    _ = _e175.z;
    let _e177 = lengths1_1;
    _ = _e177.z;
    let _e179 = lengths0_1;
    let _e181 = lengths1_1;
    _ = min(_e179.z, _e181.z);
    let _e184 = lengths1_1;
    let _e186 = lengths0_1;
    _ = _e186.z;
    let _e188 = lengths1_1;
    _ = _e188.z;
    let _e190 = lengths0_1;
    let _e192 = lengths1_1;
    _ = min(_e171.y, min(_e184.y, min(_e190.z, _e192.z)));
    let _e197 = lengths1_1;
    let _e199 = lengths0_1;
    _ = _e199.y;
    let _e201 = lengths1_1;
    _ = _e201.y;
    let _e203 = lengths0_1;
    _ = _e203.z;
    let _e205 = lengths1_1;
    _ = _e205.z;
    let _e207 = lengths0_1;
    let _e209 = lengths1_1;
    _ = min(_e207.z, _e209.z);
    let _e212 = lengths1_1;
    let _e214 = lengths0_1;
    _ = _e214.z;
    let _e216 = lengths1_1;
    _ = _e216.z;
    let _e218 = lengths0_1;
    let _e220 = lengths1_1;
    _ = min(_e212.y, min(_e218.z, _e220.z));
    let _e224 = lengths0_1;
    let _e226 = lengths1_1;
    _ = _e226.y;
    let _e228 = lengths0_1;
    _ = _e228.z;
    let _e230 = lengths1_1;
    _ = _e230.z;
    let _e232 = lengths0_1;
    let _e234 = lengths1_1;
    _ = min(_e232.z, _e234.z);
    let _e237 = lengths1_1;
    let _e239 = lengths0_1;
    _ = _e239.z;
    let _e241 = lengths1_1;
    _ = _e241.z;
    let _e243 = lengths0_1;
    let _e245 = lengths1_1;
    _ = min(_e197.x, min(_e224.y, min(_e237.y, min(_e243.z, _e245.z))));
    let _e251 = lengths0_1;
    let _e253 = lengths1_1;
    _ = _e253.x;
    let _e255 = lengths0_1;
    _ = _e255.y;
    let _e257 = lengths1_1;
    _ = _e257.y;
    let _e259 = lengths0_1;
    _ = _e259.z;
    let _e261 = lengths1_1;
    _ = _e261.z;
    let _e263 = lengths0_1;
    let _e265 = lengths1_1;
    _ = min(_e263.z, _e265.z);
    let _e268 = lengths1_1;
    let _e270 = lengths0_1;
    _ = _e270.z;
    let _e272 = lengths1_1;
    _ = _e272.z;
    let _e274 = lengths0_1;
    let _e276 = lengths1_1;
    _ = min(_e268.y, min(_e274.z, _e276.z));
    let _e280 = lengths0_1;
    let _e282 = lengths1_1;
    _ = _e282.y;
    let _e284 = lengths0_1;
    _ = _e284.z;
    let _e286 = lengths1_1;
    _ = _e286.z;
    let _e288 = lengths0_1;
    let _e290 = lengths1_1;
    _ = min(_e288.z, _e290.z);
    let _e293 = lengths1_1;
    let _e295 = lengths0_1;
    _ = _e295.z;
    let _e297 = lengths1_1;
    _ = _e297.z;
    let _e299 = lengths0_1;
    let _e301 = lengths1_1;
    _ = min(_e280.y, min(_e293.y, min(_e299.z, _e301.z)));
    let _e306 = lengths1_1;
    let _e308 = lengths0_1;
    _ = _e308.y;
    let _e310 = lengths1_1;
    _ = _e310.y;
    let _e312 = lengths0_1;
    _ = _e312.z;
    let _e314 = lengths1_1;
    _ = _e314.z;
    let _e316 = lengths0_1;
    let _e318 = lengths1_1;
    _ = min(_e316.z, _e318.z);
    let _e321 = lengths1_1;
    let _e323 = lengths0_1;
    _ = _e323.z;
    let _e325 = lengths1_1;
    _ = _e325.z;
    let _e327 = lengths0_1;
    let _e329 = lengths1_1;
    _ = min(_e321.y, min(_e327.z, _e329.z));
    let _e333 = lengths0_1;
    let _e335 = lengths1_1;
    _ = _e335.y;
    let _e337 = lengths0_1;
    _ = _e337.z;
    let _e339 = lengths1_1;
    _ = _e339.z;
    let _e341 = lengths0_1;
    let _e343 = lengths1_1;
    _ = min(_e341.z, _e343.z);
    let _e346 = lengths1_1;
    let _e348 = lengths0_1;
    _ = _e348.z;
    let _e350 = lengths1_1;
    _ = _e350.z;
    let _e352 = lengths0_1;
    let _e354 = lengths1_1;
    return min(_e251.x, min(_e306.x, min(_e333.y, min(_e346.y, min(_e352.z, _e354.z)))));
}

fn hsluv_fromLinear(c: f32) -> f32 {
    var c_1: f32;
    var local_2: f32;

    c_1 = c;
    let _e3 = c_1;
    if (_e3 <= 0.0031308000907301903) {
        let _e7 = c_1;
        local_2 = (12.920000076293945 * _e7);
    } else {
        _ = c_1;
        _ = (1.0 / 2.4000000953674316);
        let _e14 = c_1;
        local_2 = ((1.0549999475479126 * pow(_e14, (1.0 / 2.4000000953674316))) - 0.054999999701976776);
    }
    let _e23 = local_2;
    return _e23;
}

fn hsluv_fromLinear_1(c_2: vec3<f32>) -> vec3<f32> {
    var c_3: vec3<f32>;

    c_3 = c_2;
    let _e3 = c_3;
    _ = _e3.x;
    let _e5 = c_3;
    let _e7 = hsluv_fromLinear(_e5.x);
    let _e8 = c_3;
    _ = _e8.y;
    let _e10 = c_3;
    let _e12 = hsluv_fromLinear(_e10.y);
    let _e13 = c_3;
    _ = _e13.z;
    let _e15 = c_3;
    let _e17 = hsluv_fromLinear(_e15.z);
    return vec3<f32>(_e7, _e12, _e17);
}

fn hsluv_toLinear(c_4: f32) -> f32 {
    var c_5: f32;
    var local_3: f32;

    c_5 = c_4;
    let _e3 = c_5;
    if (_e3 > 0.040449999272823334) {
        let _e6 = c_5;
        _ = ((_e6 + 0.054999999701976776) / (1.0 + 0.054999999701976776));
        let _e14 = c_5;
        local_3 = pow(((_e14 + 0.054999999701976776) / (1.0 + 0.054999999701976776)), 2.4000000953674316);
    } else {
        let _e23 = c_5;
        local_3 = (_e23 / 12.920000076293945);
    }
    let _e27 = local_3;
    return _e27;
}

fn hsluv_toLinear_1(c_6: vec3<f32>) -> vec3<f32> {
    var c_7: vec3<f32>;

    c_7 = c_6;
    let _e3 = c_7;
    _ = _e3.x;
    let _e5 = c_7;
    let _e7 = hsluv_toLinear(_e5.x);
    let _e8 = c_7;
    _ = _e8.y;
    let _e10 = c_7;
    let _e12 = hsluv_toLinear(_e10.y);
    let _e13 = c_7;
    _ = _e13.z;
    let _e15 = c_7;
    let _e17 = hsluv_toLinear(_e15.z);
    return vec3<f32>(_e7, _e12, _e17);
}

fn hsluv_yToL(Y: f32) -> f32 {
    var Y_1: f32;
    var local_4: f32;

    Y_1 = Y;
    let _e3 = Y_1;
    if (_e3 <= 0.008856452070176601) {
        let _e6 = Y_1;
        local_4 = (_e6 * 903.2963256835938);
    } else {
        _ = Y_1;
        _ = (1.0 / 3.0);
        let _e14 = Y_1;
        local_4 = ((116.0 * pow(_e14, (1.0 / 3.0))) - 16.0);
    }
    let _e23 = local_4;
    return _e23;
}

fn hsluv_lToY(L_4: f32) -> f32 {
    var L_5: f32;
    var local_5: f32;

    L_5 = L_4;
    let _e3 = L_5;
    if (_e3 <= 8.0) {
        let _e6 = L_5;
        local_5 = (_e6 / 903.2963256835938);
    } else {
        let _e9 = L_5;
        _ = ((_e9 + 16.0) / 116.0);
        let _e15 = L_5;
        local_5 = pow(((_e15 + 16.0) / 116.0), 3.0);
    }
    let _e23 = local_5;
    return _e23;
}

fn xyzToRgb(tuple: vec3<f32>) -> vec3<f32> {
    var tuple_1: vec3<f32>;
    var m: mat3x3<f32>;

    tuple_1 = tuple;
    m = mat3x3<f32>(vec3<f32>(3.2409698963165283, -(1.5373831987380981), -(0.4986107647418976)), vec3<f32>(-(0.9692436456680298), 1.8759675025939941, 0.04155505821108818), vec3<f32>(0.05563008040189743, -(0.20397695899009705), 1.056971549987793));
    let _e21 = tuple_1;
    let _e22 = m;
    _ = (_e21 * _e22);
    let _e24 = tuple_1;
    let _e25 = m;
    let _e27 = hsluv_fromLinear_1((_e24 * _e25));
    return _e27;
}

fn rgbToXyz(tuple_2: vec3<f32>) -> vec3<f32> {
    var tuple_3: vec3<f32>;
    var m_1: mat3x3<f32>;

    tuple_3 = tuple_2;
    m_1 = mat3x3<f32>(vec3<f32>(0.412390798330307, 0.3575843274593353, 0.18048079311847687), vec3<f32>(0.2126390039920807, 0.7151686549186707, 0.07219231873750687), vec3<f32>(0.019330818206071854, 0.11919478327035904, 0.9505321383476257));
    _ = tuple_3;
    let _e18 = tuple_3;
    let _e19 = hsluv_toLinear_1(_e18);
    let _e20 = m_1;
    return (_e19 * _e20);
}

fn xyzToLuv(tuple_4: vec3<f32>) -> vec3<f32> {
    var tuple_5: vec3<f32>;
    var X: f32;
    var Y_2: f32;
    var Z: f32;
    var L_6: f32;
    var div: f32;

    tuple_5 = tuple_4;
    let _e3 = tuple_5;
    X = _e3.x;
    let _e6 = tuple_5;
    Y_2 = _e6.y;
    let _e9 = tuple_5;
    Z = _e9.z;
    _ = Y_2;
    let _e13 = Y_2;
    let _e14 = hsluv_yToL(_e13);
    L_6 = _e14;
    _ = tuple_5;
    _ = vec3<f32>(f32(1), f32(15), f32(3));
    let _e25 = tuple_5;
    div = (1.0 / dot(_e25, vec3<f32>(f32(1), f32(15), f32(3))));
    let _e38 = X;
    let _e39 = div;
    let _e45 = Y_2;
    let _e46 = div;
    let _e52 = L_6;
    return (vec3<f32>(1.0, ((52.0 * (_e38 * _e39)) - 2.5717899799346924), ((117.0 * (_e45 * _e46)) - 6.088160037994385)) * _e52);
}

fn luvToXyz(tuple_6: vec3<f32>) -> vec3<f32> {
    var tuple_7: vec3<f32>;
    var L_7: f32;
    var U: f32;
    var V: f32;
    var Y_3: f32;
    var X_1: f32;
    var Z_1: f32;

    tuple_7 = tuple_6;
    let _e3 = tuple_7;
    L_7 = _e3.x;
    let _e6 = tuple_7;
    let _e9 = L_7;
    U = ((_e6.y / (13.0 * _e9)) + 0.19783000648021698);
    let _e15 = tuple_7;
    let _e18 = L_7;
    V = ((_e15.z / (13.0 * _e18)) + 0.46831998229026794);
    _ = L_7;
    let _e25 = L_7;
    let _e26 = hsluv_lToY(_e25);
    Y_3 = _e26;
    let _e29 = U;
    let _e31 = Y_3;
    let _e33 = V;
    X_1 = (((2.25 * _e29) * _e31) / _e33);
    let _e37 = V;
    let _e41 = Y_3;
    let _e43 = X_1;
    Z_1 = ((((3.0 / _e37) - 5.0) * _e41) - (_e43 / 3.0));
    let _e48 = X_1;
    let _e49 = Y_3;
    let _e50 = Z_1;
    return vec3<f32>(_e48, _e49, _e50);
}

fn luvToLch(tuple_8: vec3<f32>) -> vec3<f32> {
    var tuple_9: vec3<f32>;
    var L_8: f32;
    var U_1: f32;
    var V_1: f32;
    var C: f32;
    var H_2: f32;

    tuple_9 = tuple_8;
    let _e3 = tuple_9;
    L_8 = _e3.x;
    let _e6 = tuple_9;
    U_1 = _e6.y;
    let _e9 = tuple_9;
    V_1 = _e9.z;
    let _e12 = tuple_9;
    _ = _e12.yz;
    let _e14 = tuple_9;
    C = length(_e14.yz);
    _ = V_1;
    _ = U_1;
    let _e20 = V_1;
    let _e21 = U_1;
    _ = atan2(_e20, _e21);
    _ = V_1;
    _ = U_1;
    let _e25 = V_1;
    let _e26 = U_1;
    H_2 = degrees(atan2(_e25, _e26));
    let _e30 = H_2;
    if (_e30 < 0.0) {
        {
            let _e34 = H_2;
            H_2 = (360.0 + _e34);
        }
    }
    let _e36 = L_8;
    let _e37 = C;
    let _e38 = H_2;
    return vec3<f32>(_e36, _e37, _e38);
}

fn lchToLuv(tuple_10: vec3<f32>) -> vec3<f32> {
    var tuple_11: vec3<f32>;
    var hrad_1: f32;

    tuple_11 = tuple_10;
    let _e3 = tuple_11;
    _ = _e3.z;
    let _e5 = tuple_11;
    hrad_1 = radians(_e5.z);
    let _e9 = tuple_11;
    _ = hrad_1;
    let _e12 = hrad_1;
    let _e14 = tuple_11;
    _ = hrad_1;
    let _e18 = hrad_1;
    let _e20 = tuple_11;
    return vec3<f32>(_e9.x, (cos(_e12) * _e14.y), (sin(_e18) * _e20.y));
}

fn hsluvToLch(tuple_12: vec3<f32>) -> vec3<f32> {
    var tuple_13: vec3<f32>;

    tuple_13 = tuple_12;
    let _e4 = tuple_13;
    let _e6 = tuple_13;
    _ = _e6.z;
    let _e8 = tuple_13;
    _ = _e8.x;
    let _e10 = tuple_13;
    let _e12 = tuple_13;
    let _e14 = hsluv_maxChromaForLH(_e10.z, _e12.x);
    tuple_13.y = (_e4.y * (_e14 * 0.009999999776482582));
    let _e18 = tuple_13;
    return _e18.zyx;
}

fn lchToHsluv(tuple_14: vec3<f32>) -> vec3<f32> {
    var tuple_15: vec3<f32>;

    tuple_15 = tuple_14;
    let _e4 = tuple_15;
    let _e6 = tuple_15;
    _ = _e6.x;
    let _e8 = tuple_15;
    _ = _e8.z;
    let _e10 = tuple_15;
    let _e12 = tuple_15;
    let _e14 = hsluv_maxChromaForLH(_e10.x, _e12.z);
    tuple_15.y = (_e4.y / (_e14 * 0.009999999776482582));
    let _e18 = tuple_15;
    return _e18.zyx;
}

fn hpluvToLch(tuple_16: vec3<f32>) -> vec3<f32> {
    var tuple_17: vec3<f32>;

    tuple_17 = tuple_16;
    let _e4 = tuple_17;
    let _e6 = tuple_17;
    _ = _e6.z;
    let _e8 = tuple_17;
    let _e10 = hsluv_maxSafeChromaForL(_e8.z);
    tuple_17.y = (_e4.y * (_e10 * 0.009999999776482582));
    let _e14 = tuple_17;
    return _e14.zyx;
}

fn lchToHpluv(tuple_18: vec3<f32>) -> vec3<f32> {
    var tuple_19: vec3<f32>;

    tuple_19 = tuple_18;
    let _e4 = tuple_19;
    let _e6 = tuple_19;
    _ = _e6.x;
    let _e8 = tuple_19;
    let _e10 = hsluv_maxSafeChromaForL(_e8.x);
    tuple_19.y = (_e4.y / (_e10 * 0.009999999776482582));
    let _e14 = tuple_19;
    return _e14.zyx;
}

fn lchToRgb(tuple_20: vec3<f32>) -> vec3<f32> {
    var tuple_21: vec3<f32>;

    tuple_21 = tuple_20;
    _ = tuple_21;
    let _e4 = tuple_21;
    let _e5 = lchToLuv(_e4);
    _ = tuple_21;
    let _e7 = tuple_21;
    let _e8 = lchToLuv(_e7);
    let _e9 = luvToXyz(_e8);
    _ = tuple_21;
    let _e11 = tuple_21;
    let _e12 = lchToLuv(_e11);
    _ = tuple_21;
    let _e14 = tuple_21;
    let _e15 = lchToLuv(_e14);
    let _e16 = luvToXyz(_e15);
    let _e17 = xyzToRgb(_e16);
    return _e17;
}

fn rgbToLch(tuple_22: vec3<f32>) -> vec3<f32> {
    var tuple_23: vec3<f32>;

    tuple_23 = tuple_22;
    _ = tuple_23;
    let _e4 = tuple_23;
    let _e5 = rgbToXyz(_e4);
    _ = tuple_23;
    let _e7 = tuple_23;
    let _e8 = rgbToXyz(_e7);
    let _e9 = xyzToLuv(_e8);
    _ = tuple_23;
    let _e11 = tuple_23;
    let _e12 = rgbToXyz(_e11);
    _ = tuple_23;
    let _e14 = tuple_23;
    let _e15 = rgbToXyz(_e14);
    let _e16 = xyzToLuv(_e15);
    let _e17 = luvToLch(_e16);
    return _e17;
}

fn hsluvToRgb(tuple_24: vec3<f32>) -> vec3<f32> {
    var tuple_25: vec3<f32>;

    tuple_25 = tuple_24;
    _ = tuple_25;
    let _e4 = tuple_25;
    let _e5 = hsluvToLch(_e4);
    _ = tuple_25;
    let _e7 = tuple_25;
    let _e8 = hsluvToLch(_e7);
    let _e9 = lchToRgb(_e8);
    return _e9;
}

fn rgbToHsluv(tuple_26: vec3<f32>) -> vec3<f32> {
    var tuple_27: vec3<f32>;

    tuple_27 = tuple_26;
    _ = tuple_27;
    let _e4 = tuple_27;
    let _e5 = rgbToLch(_e4);
    _ = tuple_27;
    let _e7 = tuple_27;
    let _e8 = rgbToLch(_e7);
    let _e9 = lchToHsluv(_e8);
    return _e9;
}

fn hpluvToRgb(tuple_28: vec3<f32>) -> vec3<f32> {
    var tuple_29: vec3<f32>;

    tuple_29 = tuple_28;
    _ = tuple_29;
    let _e4 = tuple_29;
    let _e5 = hpluvToLch(_e4);
    _ = tuple_29;
    let _e7 = tuple_29;
    let _e8 = hpluvToLch(_e7);
    let _e9 = lchToRgb(_e8);
    return _e9;
}

fn rgbToHpluv(tuple_30: vec3<f32>) -> vec3<f32> {
    var tuple_31: vec3<f32>;

    tuple_31 = tuple_30;
    _ = tuple_31;
    let _e4 = tuple_31;
    let _e5 = rgbToLch(_e4);
    _ = tuple_31;
    let _e7 = tuple_31;
    let _e8 = rgbToLch(_e7);
    let _e9 = lchToHpluv(_e8);
    return _e9;
}

fn luvToRgb(tuple_32: vec3<f32>) -> vec3<f32> {
    var tuple_33: vec3<f32>;

    tuple_33 = tuple_32;
    _ = tuple_33;
    let _e4 = tuple_33;
    let _e5 = luvToXyz(_e4);
    _ = tuple_33;
    let _e7 = tuple_33;
    let _e8 = luvToXyz(_e7);
    let _e9 = xyzToRgb(_e8);
    return _e9;
}

fn xyzToRgb_1(c_8: vec4<f32>) -> vec4<f32> {
    var c_9: vec4<f32>;

    c_9 = c_8;
    let _e3 = c_9;
    let _e5 = c_9;
    let _e7 = c_9;
    _ = vec3<f32>(_e3.x, _e5.y, _e7.z);
    let _e10 = c_9;
    let _e12 = c_9;
    let _e14 = c_9;
    let _e17 = xyzToRgb(vec3<f32>(_e10.x, _e12.y, _e14.z));
    let _e18 = c_9;
    return vec4<f32>(_e17.x, _e17.y, _e17.z, _e18.w);
}

fn rgbToXyz_1(c_10: vec4<f32>) -> vec4<f32> {
    var c_11: vec4<f32>;

    c_11 = c_10;
    let _e3 = c_11;
    let _e5 = c_11;
    let _e7 = c_11;
    _ = vec3<f32>(_e3.x, _e5.y, _e7.z);
    let _e10 = c_11;
    let _e12 = c_11;
    let _e14 = c_11;
    let _e17 = rgbToXyz(vec3<f32>(_e10.x, _e12.y, _e14.z));
    let _e18 = c_11;
    return vec4<f32>(_e17.x, _e17.y, _e17.z, _e18.w);
}

fn xyzToLuv_1(c_12: vec4<f32>) -> vec4<f32> {
    var c_13: vec4<f32>;

    c_13 = c_12;
    let _e3 = c_13;
    let _e5 = c_13;
    let _e7 = c_13;
    _ = vec3<f32>(_e3.x, _e5.y, _e7.z);
    let _e10 = c_13;
    let _e12 = c_13;
    let _e14 = c_13;
    let _e17 = xyzToLuv(vec3<f32>(_e10.x, _e12.y, _e14.z));
    let _e18 = c_13;
    return vec4<f32>(_e17.x, _e17.y, _e17.z, _e18.w);
}

fn luvToXyz_1(c_14: vec4<f32>) -> vec4<f32> {
    var c_15: vec4<f32>;

    c_15 = c_14;
    let _e3 = c_15;
    let _e5 = c_15;
    let _e7 = c_15;
    _ = vec3<f32>(_e3.x, _e5.y, _e7.z);
    let _e10 = c_15;
    let _e12 = c_15;
    let _e14 = c_15;
    let _e17 = luvToXyz(vec3<f32>(_e10.x, _e12.y, _e14.z));
    let _e18 = c_15;
    return vec4<f32>(_e17.x, _e17.y, _e17.z, _e18.w);
}

fn luvToLch_1(c_16: vec4<f32>) -> vec4<f32> {
    var c_17: vec4<f32>;

    c_17 = c_16;
    let _e3 = c_17;
    let _e5 = c_17;
    let _e7 = c_17;
    _ = vec3<f32>(_e3.x, _e5.y, _e7.z);
    let _e10 = c_17;
    let _e12 = c_17;
    let _e14 = c_17;
    let _e17 = luvToLch(vec3<f32>(_e10.x, _e12.y, _e14.z));
    let _e18 = c_17;
    return vec4<f32>(_e17.x, _e17.y, _e17.z, _e18.w);
}

fn lchToLuv_1(c_18: vec4<f32>) -> vec4<f32> {
    var c_19: vec4<f32>;

    c_19 = c_18;
    let _e3 = c_19;
    let _e5 = c_19;
    let _e7 = c_19;
    _ = vec3<f32>(_e3.x, _e5.y, _e7.z);
    let _e10 = c_19;
    let _e12 = c_19;
    let _e14 = c_19;
    let _e17 = lchToLuv(vec3<f32>(_e10.x, _e12.y, _e14.z));
    let _e18 = c_19;
    return vec4<f32>(_e17.x, _e17.y, _e17.z, _e18.w);
}

fn hsluvToLch_1(c_20: vec4<f32>) -> vec4<f32> {
    var c_21: vec4<f32>;

    c_21 = c_20;
    let _e3 = c_21;
    let _e5 = c_21;
    let _e7 = c_21;
    _ = vec3<f32>(_e3.x, _e5.y, _e7.z);
    let _e10 = c_21;
    let _e12 = c_21;
    let _e14 = c_21;
    let _e17 = hsluvToLch(vec3<f32>(_e10.x, _e12.y, _e14.z));
    let _e18 = c_21;
    return vec4<f32>(_e17.x, _e17.y, _e17.z, _e18.w);
}

fn lchToHsluv_1(c_22: vec4<f32>) -> vec4<f32> {
    var c_23: vec4<f32>;

    c_23 = c_22;
    let _e3 = c_23;
    let _e5 = c_23;
    let _e7 = c_23;
    _ = vec3<f32>(_e3.x, _e5.y, _e7.z);
    let _e10 = c_23;
    let _e12 = c_23;
    let _e14 = c_23;
    let _e17 = lchToHsluv(vec3<f32>(_e10.x, _e12.y, _e14.z));
    let _e18 = c_23;
    return vec4<f32>(_e17.x, _e17.y, _e17.z, _e18.w);
}

fn hpluvToLch_1(c_24: vec4<f32>) -> vec4<f32> {
    var c_25: vec4<f32>;

    c_25 = c_24;
    let _e3 = c_25;
    let _e5 = c_25;
    let _e7 = c_25;
    _ = vec3<f32>(_e3.x, _e5.y, _e7.z);
    let _e10 = c_25;
    let _e12 = c_25;
    let _e14 = c_25;
    let _e17 = hpluvToLch(vec3<f32>(_e10.x, _e12.y, _e14.z));
    let _e18 = c_25;
    return vec4<f32>(_e17.x, _e17.y, _e17.z, _e18.w);
}

fn lchToHpluv_1(c_26: vec4<f32>) -> vec4<f32> {
    var c_27: vec4<f32>;

    c_27 = c_26;
    let _e3 = c_27;
    let _e5 = c_27;
    let _e7 = c_27;
    _ = vec3<f32>(_e3.x, _e5.y, _e7.z);
    let _e10 = c_27;
    let _e12 = c_27;
    let _e14 = c_27;
    let _e17 = lchToHpluv(vec3<f32>(_e10.x, _e12.y, _e14.z));
    let _e18 = c_27;
    return vec4<f32>(_e17.x, _e17.y, _e17.z, _e18.w);
}

fn lchToRgb_1(c_28: vec4<f32>) -> vec4<f32> {
    var c_29: vec4<f32>;

    c_29 = c_28;
    let _e3 = c_29;
    let _e5 = c_29;
    let _e7 = c_29;
    _ = vec3<f32>(_e3.x, _e5.y, _e7.z);
    let _e10 = c_29;
    let _e12 = c_29;
    let _e14 = c_29;
    let _e17 = lchToRgb(vec3<f32>(_e10.x, _e12.y, _e14.z));
    let _e18 = c_29;
    return vec4<f32>(_e17.x, _e17.y, _e17.z, _e18.w);
}

fn rgbToLch_1(c_30: vec4<f32>) -> vec4<f32> {
    var c_31: vec4<f32>;

    c_31 = c_30;
    let _e3 = c_31;
    let _e5 = c_31;
    let _e7 = c_31;
    _ = vec3<f32>(_e3.x, _e5.y, _e7.z);
    let _e10 = c_31;
    let _e12 = c_31;
    let _e14 = c_31;
    let _e17 = rgbToLch(vec3<f32>(_e10.x, _e12.y, _e14.z));
    let _e18 = c_31;
    return vec4<f32>(_e17.x, _e17.y, _e17.z, _e18.w);
}

fn hsluvToRgb_1(c_32: vec4<f32>) -> vec4<f32> {
    var c_33: vec4<f32>;

    c_33 = c_32;
    let _e3 = c_33;
    let _e5 = c_33;
    let _e7 = c_33;
    _ = vec3<f32>(_e3.x, _e5.y, _e7.z);
    let _e10 = c_33;
    let _e12 = c_33;
    let _e14 = c_33;
    let _e17 = hsluvToRgb(vec3<f32>(_e10.x, _e12.y, _e14.z));
    let _e18 = c_33;
    return vec4<f32>(_e17.x, _e17.y, _e17.z, _e18.w);
}

fn rgbToHsluv_1(c_34: vec4<f32>) -> vec4<f32> {
    var c_35: vec4<f32>;

    c_35 = c_34;
    let _e3 = c_35;
    let _e5 = c_35;
    let _e7 = c_35;
    _ = vec3<f32>(_e3.x, _e5.y, _e7.z);
    let _e10 = c_35;
    let _e12 = c_35;
    let _e14 = c_35;
    let _e17 = rgbToHsluv(vec3<f32>(_e10.x, _e12.y, _e14.z));
    let _e18 = c_35;
    return vec4<f32>(_e17.x, _e17.y, _e17.z, _e18.w);
}

fn hpluvToRgb_1(c_36: vec4<f32>) -> vec4<f32> {
    var c_37: vec4<f32>;

    c_37 = c_36;
    let _e3 = c_37;
    let _e5 = c_37;
    let _e7 = c_37;
    _ = vec3<f32>(_e3.x, _e5.y, _e7.z);
    let _e10 = c_37;
    let _e12 = c_37;
    let _e14 = c_37;
    let _e17 = hpluvToRgb(vec3<f32>(_e10.x, _e12.y, _e14.z));
    let _e18 = c_37;
    return vec4<f32>(_e17.x, _e17.y, _e17.z, _e18.w);
}

fn rgbToHpluv_1(c_38: vec4<f32>) -> vec4<f32> {
    var c_39: vec4<f32>;

    c_39 = c_38;
    let _e3 = c_39;
    let _e5 = c_39;
    let _e7 = c_39;
    _ = vec3<f32>(_e3.x, _e5.y, _e7.z);
    let _e10 = c_39;
    let _e12 = c_39;
    let _e14 = c_39;
    let _e17 = rgbToHpluv(vec3<f32>(_e10.x, _e12.y, _e14.z));
    let _e18 = c_39;
    return vec4<f32>(_e17.x, _e17.y, _e17.z, _e18.w);
}

fn luvToRgb_1(c_40: vec4<f32>) -> vec4<f32> {
    var c_41: vec4<f32>;

    c_41 = c_40;
    let _e3 = c_41;
    let _e5 = c_41;
    let _e7 = c_41;
    _ = vec3<f32>(_e3.x, _e5.y, _e7.z);
    let _e10 = c_41;
    let _e12 = c_41;
    let _e14 = c_41;
    let _e17 = luvToRgb(vec3<f32>(_e10.x, _e12.y, _e14.z));
    let _e18 = c_41;
    return vec4<f32>(_e17.x, _e17.y, _e17.z, _e18.w);
}

fn xyzToRgb_2(x_2: f32, y_2: f32, z: f32) -> vec3<f32> {
    var x_3: f32;
    var y_3: f32;
    var z_1: f32;

    x_3 = x_2;
    y_3 = y_2;
    z_1 = z;
    let _e7 = x_3;
    let _e8 = y_3;
    let _e9 = z_1;
    _ = vec3<f32>(_e7, _e8, _e9);
    let _e11 = x_3;
    let _e12 = y_3;
    let _e13 = z_1;
    let _e15 = xyzToRgb(vec3<f32>(_e11, _e12, _e13));
    return _e15;
}

fn rgbToXyz_2(x_4: f32, y_4: f32, z_2: f32) -> vec3<f32> {
    var x_5: f32;
    var y_5: f32;
    var z_3: f32;

    x_5 = x_4;
    y_5 = y_4;
    z_3 = z_2;
    let _e7 = x_5;
    let _e8 = y_5;
    let _e9 = z_3;
    _ = vec3<f32>(_e7, _e8, _e9);
    let _e11 = x_5;
    let _e12 = y_5;
    let _e13 = z_3;
    let _e15 = rgbToXyz(vec3<f32>(_e11, _e12, _e13));
    return _e15;
}

fn xyzToLuv_2(x_6: f32, y_6: f32, z_4: f32) -> vec3<f32> {
    var x_7: f32;
    var y_7: f32;
    var z_5: f32;

    x_7 = x_6;
    y_7 = y_6;
    z_5 = z_4;
    let _e7 = x_7;
    let _e8 = y_7;
    let _e9 = z_5;
    _ = vec3<f32>(_e7, _e8, _e9);
    let _e11 = x_7;
    let _e12 = y_7;
    let _e13 = z_5;
    let _e15 = xyzToLuv(vec3<f32>(_e11, _e12, _e13));
    return _e15;
}

fn luvToXyz_2(x_8: f32, y_8: f32, z_6: f32) -> vec3<f32> {
    var x_9: f32;
    var y_9: f32;
    var z_7: f32;

    x_9 = x_8;
    y_9 = y_8;
    z_7 = z_6;
    let _e7 = x_9;
    let _e8 = y_9;
    let _e9 = z_7;
    _ = vec3<f32>(_e7, _e8, _e9);
    let _e11 = x_9;
    let _e12 = y_9;
    let _e13 = z_7;
    let _e15 = luvToXyz(vec3<f32>(_e11, _e12, _e13));
    return _e15;
}

fn luvToLch_2(x_10: f32, y_10: f32, z_8: f32) -> vec3<f32> {
    var x_11: f32;
    var y_11: f32;
    var z_9: f32;

    x_11 = x_10;
    y_11 = y_10;
    z_9 = z_8;
    let _e7 = x_11;
    let _e8 = y_11;
    let _e9 = z_9;
    _ = vec3<f32>(_e7, _e8, _e9);
    let _e11 = x_11;
    let _e12 = y_11;
    let _e13 = z_9;
    let _e15 = luvToLch(vec3<f32>(_e11, _e12, _e13));
    return _e15;
}

fn lchToLuv_2(x_12: f32, y_12: f32, z_10: f32) -> vec3<f32> {
    var x_13: f32;
    var y_13: f32;
    var z_11: f32;

    x_13 = x_12;
    y_13 = y_12;
    z_11 = z_10;
    let _e7 = x_13;
    let _e8 = y_13;
    let _e9 = z_11;
    _ = vec3<f32>(_e7, _e8, _e9);
    let _e11 = x_13;
    let _e12 = y_13;
    let _e13 = z_11;
    let _e15 = lchToLuv(vec3<f32>(_e11, _e12, _e13));
    return _e15;
}

fn hsluvToLch_2(x_14: f32, y_14: f32, z_12: f32) -> vec3<f32> {
    var x_15: f32;
    var y_15: f32;
    var z_13: f32;

    x_15 = x_14;
    y_15 = y_14;
    z_13 = z_12;
    let _e7 = x_15;
    let _e8 = y_15;
    let _e9 = z_13;
    _ = vec3<f32>(_e7, _e8, _e9);
    let _e11 = x_15;
    let _e12 = y_15;
    let _e13 = z_13;
    let _e15 = hsluvToLch(vec3<f32>(_e11, _e12, _e13));
    return _e15;
}

fn lchToHsluv_2(x_16: f32, y_16: f32, z_14: f32) -> vec3<f32> {
    var x_17: f32;
    var y_17: f32;
    var z_15: f32;

    x_17 = x_16;
    y_17 = y_16;
    z_15 = z_14;
    let _e7 = x_17;
    let _e8 = y_17;
    let _e9 = z_15;
    _ = vec3<f32>(_e7, _e8, _e9);
    let _e11 = x_17;
    let _e12 = y_17;
    let _e13 = z_15;
    let _e15 = lchToHsluv(vec3<f32>(_e11, _e12, _e13));
    return _e15;
}

fn hpluvToLch_2(x_18: f32, y_18: f32, z_16: f32) -> vec3<f32> {
    var x_19: f32;
    var y_19: f32;
    var z_17: f32;

    x_19 = x_18;
    y_19 = y_18;
    z_17 = z_16;
    let _e7 = x_19;
    let _e8 = y_19;
    let _e9 = z_17;
    _ = vec3<f32>(_e7, _e8, _e9);
    let _e11 = x_19;
    let _e12 = y_19;
    let _e13 = z_17;
    let _e15 = hpluvToLch(vec3<f32>(_e11, _e12, _e13));
    return _e15;
}

fn lchToHpluv_2(x_20: f32, y_20: f32, z_18: f32) -> vec3<f32> {
    var x_21: f32;
    var y_21: f32;
    var z_19: f32;

    x_21 = x_20;
    y_21 = y_20;
    z_19 = z_18;
    let _e7 = x_21;
    let _e8 = y_21;
    let _e9 = z_19;
    _ = vec3<f32>(_e7, _e8, _e9);
    let _e11 = x_21;
    let _e12 = y_21;
    let _e13 = z_19;
    let _e15 = lchToHpluv(vec3<f32>(_e11, _e12, _e13));
    return _e15;
}

fn lchToRgb_2(x_22: f32, y_22: f32, z_20: f32) -> vec3<f32> {
    var x_23: f32;
    var y_23: f32;
    var z_21: f32;

    x_23 = x_22;
    y_23 = y_22;
    z_21 = z_20;
    let _e7 = x_23;
    let _e8 = y_23;
    let _e9 = z_21;
    _ = vec3<f32>(_e7, _e8, _e9);
    let _e11 = x_23;
    let _e12 = y_23;
    let _e13 = z_21;
    let _e15 = lchToRgb(vec3<f32>(_e11, _e12, _e13));
    return _e15;
}

fn rgbToLch_2(x_24: f32, y_24: f32, z_22: f32) -> vec3<f32> {
    var x_25: f32;
    var y_25: f32;
    var z_23: f32;

    x_25 = x_24;
    y_25 = y_24;
    z_23 = z_22;
    let _e7 = x_25;
    let _e8 = y_25;
    let _e9 = z_23;
    _ = vec3<f32>(_e7, _e8, _e9);
    let _e11 = x_25;
    let _e12 = y_25;
    let _e13 = z_23;
    let _e15 = rgbToLch(vec3<f32>(_e11, _e12, _e13));
    return _e15;
}

fn hsluvToRgb_2(x_26: f32, y_26: f32, z_24: f32) -> vec3<f32> {
    var x_27: f32;
    var y_27: f32;
    var z_25: f32;

    x_27 = x_26;
    y_27 = y_26;
    z_25 = z_24;
    let _e7 = x_27;
    let _e8 = y_27;
    let _e9 = z_25;
    _ = vec3<f32>(_e7, _e8, _e9);
    let _e11 = x_27;
    let _e12 = y_27;
    let _e13 = z_25;
    let _e15 = hsluvToRgb(vec3<f32>(_e11, _e12, _e13));
    return _e15;
}

fn rgbToHsluv_2(x_28: f32, y_28: f32, z_26: f32) -> vec3<f32> {
    var x_29: f32;
    var y_29: f32;
    var z_27: f32;

    x_29 = x_28;
    y_29 = y_28;
    z_27 = z_26;
    let _e7 = x_29;
    let _e8 = y_29;
    let _e9 = z_27;
    _ = vec3<f32>(_e7, _e8, _e9);
    let _e11 = x_29;
    let _e12 = y_29;
    let _e13 = z_27;
    let _e15 = rgbToHsluv(vec3<f32>(_e11, _e12, _e13));
    return _e15;
}

fn hpluvToRgb_2(x_30: f32, y_30: f32, z_28: f32) -> vec3<f32> {
    var x_31: f32;
    var y_31: f32;
    var z_29: f32;

    x_31 = x_30;
    y_31 = y_30;
    z_29 = z_28;
    let _e7 = x_31;
    let _e8 = y_31;
    let _e9 = z_29;
    _ = vec3<f32>(_e7, _e8, _e9);
    let _e11 = x_31;
    let _e12 = y_31;
    let _e13 = z_29;
    let _e15 = hpluvToRgb(vec3<f32>(_e11, _e12, _e13));
    return _e15;
}

fn rgbToHpluv_2(x_32: f32, y_32: f32, z_30: f32) -> vec3<f32> {
    var x_33: f32;
    var y_33: f32;
    var z_31: f32;

    x_33 = x_32;
    y_33 = y_32;
    z_31 = z_30;
    let _e7 = x_33;
    let _e8 = y_33;
    let _e9 = z_31;
    _ = vec3<f32>(_e7, _e8, _e9);
    let _e11 = x_33;
    let _e12 = y_33;
    let _e13 = z_31;
    let _e15 = rgbToHpluv(vec3<f32>(_e11, _e12, _e13));
    return _e15;
}

fn luvToRgb_2(x_34: f32, y_34: f32, z_32: f32) -> vec3<f32> {
    var x_35: f32;
    var y_35: f32;
    var z_33: f32;

    x_35 = x_34;
    y_35 = y_34;
    z_33 = z_32;
    let _e7 = x_35;
    let _e8 = y_35;
    let _e9 = z_33;
    _ = vec3<f32>(_e7, _e8, _e9);
    let _e11 = x_35;
    let _e12 = y_35;
    let _e13 = z_33;
    let _e15 = luvToRgb(vec3<f32>(_e11, _e12, _e13));
    return _e15;
}

fn xyzToRgb_3(x_36: f32, y_36: f32, z_34: f32, a: f32) -> vec4<f32> {
    var x_37: f32;
    var y_37: f32;
    var z_35: f32;
    var a_1: f32;

    x_37 = x_36;
    y_37 = y_36;
    z_35 = z_34;
    a_1 = a;
    let _e9 = x_37;
    let _e10 = y_37;
    let _e11 = z_35;
    let _e12 = a_1;
    _ = vec4<f32>(_e9, _e10, _e11, _e12);
    let _e14 = x_37;
    let _e15 = y_37;
    let _e16 = z_35;
    let _e17 = a_1;
    let _e19 = xyzToRgb_1(vec4<f32>(_e14, _e15, _e16, _e17));
    return _e19;
}

fn rgbToXyz_3(x_38: f32, y_38: f32, z_36: f32, a_2: f32) -> vec4<f32> {
    var x_39: f32;
    var y_39: f32;
    var z_37: f32;
    var a_3: f32;

    x_39 = x_38;
    y_39 = y_38;
    z_37 = z_36;
    a_3 = a_2;
    let _e9 = x_39;
    let _e10 = y_39;
    let _e11 = z_37;
    let _e12 = a_3;
    _ = vec4<f32>(_e9, _e10, _e11, _e12);
    let _e14 = x_39;
    let _e15 = y_39;
    let _e16 = z_37;
    let _e17 = a_3;
    let _e19 = rgbToXyz_1(vec4<f32>(_e14, _e15, _e16, _e17));
    return _e19;
}

fn xyzToLuv_3(x_40: f32, y_40: f32, z_38: f32, a_4: f32) -> vec4<f32> {
    var x_41: f32;
    var y_41: f32;
    var z_39: f32;
    var a_5: f32;

    x_41 = x_40;
    y_41 = y_40;
    z_39 = z_38;
    a_5 = a_4;
    let _e9 = x_41;
    let _e10 = y_41;
    let _e11 = z_39;
    let _e12 = a_5;
    _ = vec4<f32>(_e9, _e10, _e11, _e12);
    let _e14 = x_41;
    let _e15 = y_41;
    let _e16 = z_39;
    let _e17 = a_5;
    let _e19 = xyzToLuv_1(vec4<f32>(_e14, _e15, _e16, _e17));
    return _e19;
}

fn luvToXyz_3(x_42: f32, y_42: f32, z_40: f32, a_6: f32) -> vec4<f32> {
    var x_43: f32;
    var y_43: f32;
    var z_41: f32;
    var a_7: f32;

    x_43 = x_42;
    y_43 = y_42;
    z_41 = z_40;
    a_7 = a_6;
    let _e9 = x_43;
    let _e10 = y_43;
    let _e11 = z_41;
    let _e12 = a_7;
    _ = vec4<f32>(_e9, _e10, _e11, _e12);
    let _e14 = x_43;
    let _e15 = y_43;
    let _e16 = z_41;
    let _e17 = a_7;
    let _e19 = luvToXyz_1(vec4<f32>(_e14, _e15, _e16, _e17));
    return _e19;
}

fn luvToLch_3(x_44: f32, y_44: f32, z_42: f32, a_8: f32) -> vec4<f32> {
    var x_45: f32;
    var y_45: f32;
    var z_43: f32;
    var a_9: f32;

    x_45 = x_44;
    y_45 = y_44;
    z_43 = z_42;
    a_9 = a_8;
    let _e9 = x_45;
    let _e10 = y_45;
    let _e11 = z_43;
    let _e12 = a_9;
    _ = vec4<f32>(_e9, _e10, _e11, _e12);
    let _e14 = x_45;
    let _e15 = y_45;
    let _e16 = z_43;
    let _e17 = a_9;
    let _e19 = luvToLch_1(vec4<f32>(_e14, _e15, _e16, _e17));
    return _e19;
}

fn lchToLuv_3(x_46: f32, y_46: f32, z_44: f32, a_10: f32) -> vec4<f32> {
    var x_47: f32;
    var y_47: f32;
    var z_45: f32;
    var a_11: f32;

    x_47 = x_46;
    y_47 = y_46;
    z_45 = z_44;
    a_11 = a_10;
    let _e9 = x_47;
    let _e10 = y_47;
    let _e11 = z_45;
    let _e12 = a_11;
    _ = vec4<f32>(_e9, _e10, _e11, _e12);
    let _e14 = x_47;
    let _e15 = y_47;
    let _e16 = z_45;
    let _e17 = a_11;
    let _e19 = lchToLuv_1(vec4<f32>(_e14, _e15, _e16, _e17));
    return _e19;
}

fn hsluvToLch_3(x_48: f32, y_48: f32, z_46: f32, a_12: f32) -> vec4<f32> {
    var x_49: f32;
    var y_49: f32;
    var z_47: f32;
    var a_13: f32;

    x_49 = x_48;
    y_49 = y_48;
    z_47 = z_46;
    a_13 = a_12;
    let _e9 = x_49;
    let _e10 = y_49;
    let _e11 = z_47;
    let _e12 = a_13;
    _ = vec4<f32>(_e9, _e10, _e11, _e12);
    let _e14 = x_49;
    let _e15 = y_49;
    let _e16 = z_47;
    let _e17 = a_13;
    let _e19 = hsluvToLch_1(vec4<f32>(_e14, _e15, _e16, _e17));
    return _e19;
}

fn lchToHsluv_3(x_50: f32, y_50: f32, z_48: f32, a_14: f32) -> vec4<f32> {
    var x_51: f32;
    var y_51: f32;
    var z_49: f32;
    var a_15: f32;

    x_51 = x_50;
    y_51 = y_50;
    z_49 = z_48;
    a_15 = a_14;
    let _e9 = x_51;
    let _e10 = y_51;
    let _e11 = z_49;
    let _e12 = a_15;
    _ = vec4<f32>(_e9, _e10, _e11, _e12);
    let _e14 = x_51;
    let _e15 = y_51;
    let _e16 = z_49;
    let _e17 = a_15;
    let _e19 = lchToHsluv_1(vec4<f32>(_e14, _e15, _e16, _e17));
    return _e19;
}

fn hpluvToLch_3(x_52: f32, y_52: f32, z_50: f32, a_16: f32) -> vec4<f32> {
    var x_53: f32;
    var y_53: f32;
    var z_51: f32;
    var a_17: f32;

    x_53 = x_52;
    y_53 = y_52;
    z_51 = z_50;
    a_17 = a_16;
    let _e9 = x_53;
    let _e10 = y_53;
    let _e11 = z_51;
    let _e12 = a_17;
    _ = vec4<f32>(_e9, _e10, _e11, _e12);
    let _e14 = x_53;
    let _e15 = y_53;
    let _e16 = z_51;
    let _e17 = a_17;
    let _e19 = hpluvToLch_1(vec4<f32>(_e14, _e15, _e16, _e17));
    return _e19;
}

fn lchToHpluv_3(x_54: f32, y_54: f32, z_52: f32, a_18: f32) -> vec4<f32> {
    var x_55: f32;
    var y_55: f32;
    var z_53: f32;
    var a_19: f32;

    x_55 = x_54;
    y_55 = y_54;
    z_53 = z_52;
    a_19 = a_18;
    let _e9 = x_55;
    let _e10 = y_55;
    let _e11 = z_53;
    let _e12 = a_19;
    _ = vec4<f32>(_e9, _e10, _e11, _e12);
    let _e14 = x_55;
    let _e15 = y_55;
    let _e16 = z_53;
    let _e17 = a_19;
    let _e19 = lchToHpluv_1(vec4<f32>(_e14, _e15, _e16, _e17));
    return _e19;
}

fn lchToRgb_3(x_56: f32, y_56: f32, z_54: f32, a_20: f32) -> vec4<f32> {
    var x_57: f32;
    var y_57: f32;
    var z_55: f32;
    var a_21: f32;

    x_57 = x_56;
    y_57 = y_56;
    z_55 = z_54;
    a_21 = a_20;
    let _e9 = x_57;
    let _e10 = y_57;
    let _e11 = z_55;
    let _e12 = a_21;
    _ = vec4<f32>(_e9, _e10, _e11, _e12);
    let _e14 = x_57;
    let _e15 = y_57;
    let _e16 = z_55;
    let _e17 = a_21;
    let _e19 = lchToRgb_1(vec4<f32>(_e14, _e15, _e16, _e17));
    return _e19;
}

fn rgbToLch_3(x_58: f32, y_58: f32, z_56: f32, a_22: f32) -> vec4<f32> {
    var x_59: f32;
    var y_59: f32;
    var z_57: f32;
    var a_23: f32;

    x_59 = x_58;
    y_59 = y_58;
    z_57 = z_56;
    a_23 = a_22;
    let _e9 = x_59;
    let _e10 = y_59;
    let _e11 = z_57;
    let _e12 = a_23;
    _ = vec4<f32>(_e9, _e10, _e11, _e12);
    let _e14 = x_59;
    let _e15 = y_59;
    let _e16 = z_57;
    let _e17 = a_23;
    let _e19 = rgbToLch_1(vec4<f32>(_e14, _e15, _e16, _e17));
    return _e19;
}

fn hsluvToRgb_3(x_60: f32, y_60: f32, z_58: f32, a_24: f32) -> vec4<f32> {
    var x_61: f32;
    var y_61: f32;
    var z_59: f32;
    var a_25: f32;

    x_61 = x_60;
    y_61 = y_60;
    z_59 = z_58;
    a_25 = a_24;
    let _e9 = x_61;
    let _e10 = y_61;
    let _e11 = z_59;
    let _e12 = a_25;
    _ = vec4<f32>(_e9, _e10, _e11, _e12);
    let _e14 = x_61;
    let _e15 = y_61;
    let _e16 = z_59;
    let _e17 = a_25;
    let _e19 = hsluvToRgb_1(vec4<f32>(_e14, _e15, _e16, _e17));
    return _e19;
}

fn rgbToHslul(x_62: f32, y_62: f32, z_60: f32, a_26: f32) -> vec4<f32> {
    var x_63: f32;
    var y_63: f32;
    var z_61: f32;
    var a_27: f32;

    x_63 = x_62;
    y_63 = y_62;
    z_61 = z_60;
    a_27 = a_26;
    let _e9 = x_63;
    let _e10 = y_63;
    let _e11 = z_61;
    let _e12 = a_27;
    _ = vec4<f32>(_e9, _e10, _e11, _e12);
    let _e14 = x_63;
    let _e15 = y_63;
    let _e16 = z_61;
    let _e17 = a_27;
    let _e19 = rgbToHsluv_1(vec4<f32>(_e14, _e15, _e16, _e17));
    return _e19;
}

fn hpluvToRgb_3(x_64: f32, y_64: f32, z_62: f32, a_28: f32) -> vec4<f32> {
    var x_65: f32;
    var y_65: f32;
    var z_63: f32;
    var a_29: f32;

    x_65 = x_64;
    y_65 = y_64;
    z_63 = z_62;
    a_29 = a_28;
    let _e9 = x_65;
    let _e10 = y_65;
    let _e11 = z_63;
    let _e12 = a_29;
    _ = vec4<f32>(_e9, _e10, _e11, _e12);
    let _e14 = x_65;
    let _e15 = y_65;
    let _e16 = z_63;
    let _e17 = a_29;
    let _e19 = hpluvToRgb_1(vec4<f32>(_e14, _e15, _e16, _e17));
    return _e19;
}

fn rgbToHpluv_3(x_66: f32, y_66: f32, z_64: f32, a_30: f32) -> vec4<f32> {
    var x_67: f32;
    var y_67: f32;
    var z_65: f32;
    var a_31: f32;

    x_67 = x_66;
    y_67 = y_66;
    z_65 = z_64;
    a_31 = a_30;
    let _e9 = x_67;
    let _e10 = y_67;
    let _e11 = z_65;
    let _e12 = a_31;
    _ = vec4<f32>(_e9, _e10, _e11, _e12);
    let _e14 = x_67;
    let _e15 = y_67;
    let _e16 = z_65;
    let _e17 = a_31;
    let _e19 = rgbToHpluv_1(vec4<f32>(_e14, _e15, _e16, _e17));
    return _e19;
}

fn luvToRgb_3(x_68: f32, y_68: f32, z_66: f32, a_32: f32) -> vec4<f32> {
    var x_69: f32;
    var y_69: f32;
    var z_67: f32;
    var a_33: f32;

    x_69 = x_68;
    y_69 = y_68;
    z_67 = z_66;
    a_33 = a_32;
    let _e9 = x_69;
    let _e10 = y_69;
    let _e11 = z_67;
    let _e12 = a_33;
    _ = vec4<f32>(_e9, _e10, _e11, _e12);
    let _e14 = x_69;
    let _e15 = y_69;
    let _e16 = z_67;
    let _e17 = a_33;
    let _e19 = luvToRgb_1(vec4<f32>(_e14, _e15, _e16, _e17));
    return _e19;
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

let epsilon = 0.00024;

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
    return fract(x/(state.hue_prd) + state.hue_offset + epsilon);
}

fn get_sat(x: f32) -> f32 {
    return make_zig_zag(2.0*fract(x/(2.0*(state.sat_prd)) + state.sat_offset + epsilon));
}

fn get_lgt(x: f32) -> f32 {
    return make_zig_zag(2.0*fract(x/(2.0*(state.lgt_prd)) + state.lgt_offset + epsilon));
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
        color = vec3<f32>(epsilon, epsilon, epsilon);
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
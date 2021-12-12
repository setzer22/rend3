struct Plane {
    inner: vec4<f32>;
};

struct Frustum {
    left: Plane;
    right: Plane;
    top: Plane;
    bottom: Plane;
    near: Plane;
};

struct UniformData {
    view: mat4x4<f32>;
    view_proj: mat4x4<f32>;
    inv_view: mat4x4<f32>;
    inv_origin_view_proj: mat4x4<f32>;
    frustum: Frustum;
    ambient: vec4<f32>;
};

[[block]]
struct UniformBuffer {
    uniforms: UniformData;
};

struct CPUMaterialData {
    uv_transform0_: mat3x3<f32>;
    uv_transform1_: mat3x3<f32>;
    albedo: vec4<f32>;
    emissive: vec3<f32>;
    roughness: f32;
    metallic: f32;
    reflectance: f32;
    clear_coat: f32;
    clear_coat_roughness: f32;
    anisotropy: f32;
    ambient_occlusion: f32;
    alpha_cutout: f32;
    material_flags: u32;
    texture_enable: u32;
};

[[block]]
struct TextureData {
    material: CPUMaterialData;
};

struct DirectionalLightBufferHeader {
    total_lights: u32;
};

struct DirectionalLight {
    view_proj: mat4x4<f32>;
    color: vec3<f32>;
    direction: vec3<f32>;
    offset: vec2<f32>;
    size: f32;
};

[[block]]
struct DirectionalLightBuffer {
    directional_light_header: DirectionalLightBufferHeader;
    directional_lights: [[stride(112)]] array<DirectionalLight>;
};

var<private> i_coords0_1: vec2<f32>;
[[group(2), binding(0)]]
var albedo_tex: texture_2d<f32>;
var<private> i_color_1: vec4<f32>;
var<private> i_normal_1: vec3<f32>;
[[group(2), binding(1)]]
var normal_tex: texture_2d<f32>;
var<private> i_tangent_1: vec3<f32>;
[[group(2), binding(2)]]
var roughness_tex: texture_2d<f32>;
[[group(2), binding(9)]]
var ambient_occlusion_tex: texture_2d<f32>;
[[group(2), binding(3)]]
var metallic_tex: texture_2d<f32>;
[[group(2), binding(4)]]
var reflectance_tex: texture_2d<f32>;
[[group(2), binding(5)]]
var clear_coat_tex: texture_2d<f32>;
[[group(2), binding(6)]]
var clear_coat_roughness_tex: texture_2d<f32>;
[[group(2), binding(7)]]
var emissive_tex: texture_2d<f32>;
[[group(0), binding(0)]]
var primary_sampler: sampler;
[[group(0), binding(3)]]
var<uniform> unnamed: UniformBuffer;
[[group(2), binding(10)]]
var<uniform> unnamed_1: TextureData;
var<private> o_color: vec4<f32>;
var<private> i_view_position_1: vec4<f32>;
[[group(0), binding(4)]]
var<storage> unnamed_2: DirectionalLightBuffer;
var<private> i_coords1_1: vec2<f32>;
var<private> i_material_1: u32;

fn main_1() {
    var phi_2294_: vec4<f32>;
    var phi_2292_: vec4<f32>;
    var phi_2296_: vec4<f32>;
    var phi_2295_: vec4<f32>;
    var phi_2297_: vec2<f32>;
    var phi_2298_: vec3<f32>;
    var phi_2299_: vec3<f32>;
    var phi_2426_: f32;
    var phi_2366_: f32;
    var phi_2318_: f32;
    var phi_1497_: bool;
    var phi_2300_: vec2<f32>;
    var phi_2369_: f32;
    var phi_2321_: f32;
    var phi_2428_: f32;
    var phi_2381_: f32;
    var phi_2333_: f32;
    var phi_2434_: f32;
    var phi_2429_: f32;
    var phi_2370_: f32;
    var phi_2322_: f32;
    var phi_2427_: f32;
    var phi_2367_: f32;
    var phi_2319_: f32;
    var phi_2425_: f32;
    var phi_2365_: f32;
    var phi_2317_: f32;
    var phi_2334_: f32;
    var phi_2389_: f32;
    var phi_2336_: f32;
    var phi_2339_: f32;
    var phi_2391_: f32;
    var phi_2361_: f32;
    var phi_2412_: f32;
    var phi_2392_: f32;
    var phi_2340_: f32;
    var phi_2390_: f32;
    var phi_2337_: f32;
    var phi_2388_: f32;
    var phi_2335_: f32;
    var phi_2413_: f32;
    var phi_2509_: vec3<f32>;
    var phi_2572_: vec3<f32>;
    var phi_2565_: f32;
    var phi_2541_: vec3<f32>;
    var phi_2513_: vec3<f32>;
    var phi_2502_: vec3<f32>;
    var phi_2414_: f32;
    var phi_2601_: vec3<f32>;
    var phi_2600_: u32;
    var local: vec3<f32>;
    var local_1: vec3<f32>;
    var local_2: vec3<f32>;

    let e86: mat3x3<f32> = unnamed_1.material.uv_transform0_;
    let e88: vec4<f32> = unnamed_1.material.albedo;
    let e90: vec3<f32> = unnamed_1.material.emissive;
    let e92: f32 = unnamed_1.material.roughness;
    let e94: f32 = unnamed_1.material.metallic;
    let e96: f32 = unnamed_1.material.reflectance;
    let e98: f32 = unnamed_1.material.clear_coat;
    let e100: f32 = unnamed_1.material.clear_coat_roughness;
    let e102: f32 = unnamed_1.material.ambient_occlusion;
    let e104: u32 = unnamed_1.material.material_flags;
    let e106: u32 = unnamed_1.material.texture_enable;
    let e107: vec2<f32> = i_coords0_1;
    let e111: vec3<f32> = (e86 * vec3<f32>(e107.x, e107.y, 1.0));
    let e114: vec2<f32> = vec2<f32>(e111.x, e111.y);
    let e115: vec2<f32> = dpdx(e114);
    let e116: vec2<f32> = dpdy(e114);
    if ((bitcast<i32>((e104 & 1u)) != bitcast<i32>(0u))) {
        if ((bitcast<i32>(((e106 >> bitcast<u32>(0)) & 1u)) != bitcast<i32>(0u))) {
            let e127: vec4<f32> = textureSampleGrad(albedo_tex, primary_sampler, e114, e115, e116);
            phi_2294_ = e127;
        } else {
            phi_2294_ = vec4<f32>(1.0, 1.0, 1.0, 1.0);
        }
        let e129: vec4<f32> = phi_2294_;
        phi_2296_ = e129;
        if ((bitcast<i32>((e104 & 2u)) != bitcast<i32>(0u))) {
            let e134: vec4<f32> = i_color_1;
            phi_2292_ = e134;
            if ((bitcast<i32>((e104 & 4u)) != bitcast<i32>(0u))) {
                let e139: vec3<f32> = e134.xyz;
                let e146: vec3<f32> = mix((e139 * vec3<f32>(0.07739938050508499, 0.07739938050508499, 0.07739938050508499)), pow(((e139 + vec3<f32>(0.054999999701976776, 0.054999999701976776, 0.054999999701976776)) * vec3<f32>(0.9478673338890076, 0.9478673338890076, 0.9478673338890076)), vec3<f32>(2.4000000953674316, 2.4000000953674316, 2.4000000953674316)), ceil((e139 - vec3<f32>(0.040449999272823334, 0.040449999272823334, 0.040449999272823334))));
                phi_2292_ = vec4<f32>(e146.x, e146.y, e146.z, e134.w);
            }
            let e153: vec4<f32> = phi_2292_;
            phi_2296_ = (e129 * e153);
        }
        let e156: vec4<f32> = phi_2296_;
        phi_2295_ = e156;
    } else {
        phi_2295_ = vec4<f32>(0.0, 0.0, 0.0, 1.0);
    }
    let e158: vec4<f32> = phi_2295_;
    let e159: vec4<f32> = (e158 * e88);
    if ((bitcast<i32>((e104 & 4096u)) != bitcast<i32>(0u))) {
        let e164: vec3<f32> = i_normal_1;
        phi_2572_ = vec3<f32>(0.0, 0.0, 0.0);
        phi_2565_ = 0.0;
        phi_2541_ = normalize(e164);
        phi_2513_ = vec3<f32>(0.0, 0.0, 0.0);
        phi_2502_ = vec3<f32>(0.0, 0.0, 0.0);
        phi_2414_ = 0.0;
    } else {
        if ((bitcast<i32>(((e106 >> bitcast<u32>(1)) & 1u)) != bitcast<i32>(0u))) {
            let e172: vec4<f32> = textureSampleGrad(normal_tex, primary_sampler, e114, e115, e116);
            if ((bitcast<i32>((e104 & 8u)) != bitcast<i32>(0u))) {
                if ((bitcast<i32>((e104 & 16u)) != bitcast<i32>(0u))) {
                    phi_2297_ = e172.wy;
                } else {
                    phi_2297_ = e172.xy;
                }
                let e184: vec2<f32> = phi_2297_;
                let e186: vec2<f32> = ((e184 * 2.0) - vec2<f32>(1.0, 1.0));
                phi_2298_ = vec3<f32>(e186.x, e186.y, sqrt(((1.0 - (e186.x * e186.x)) - (e186.y * e186.y))));
            } else {
                phi_2298_ = normalize(((e172.xyz * 2.0) - vec3<f32>(1.0, 1.0, 1.0)));
            }
            let e200: vec3<f32> = phi_2298_;
            let e201: vec3<f32> = i_normal_1;
            let e203: vec3<f32> = i_tangent_1;
            phi_2299_ = (mat3x3<f32>(e203, cross(normalize(e201), normalize(e203)), e201) * e200);
        } else {
            let e208: vec3<f32> = i_normal_1;
            phi_2299_ = e208;
        }
        let e210: vec3<f32> = phi_2299_;
        if ((bitcast<i32>((e104 & 32u)) != bitcast<i32>(0u))) {
            if ((bitcast<i32>(((e106 >> bitcast<u32>(2)) & 1u)) != bitcast<i32>(0u))) {
                let e222: vec4<f32> = textureSampleGrad(roughness_tex, primary_sampler, e114, e115, e116);
                phi_2426_ = (e102 * e222.x);
                phi_2366_ = (e92 * e222.z);
                phi_2318_ = (e94 * e222.y);
            } else {
                phi_2426_ = e102;
                phi_2366_ = e92;
                phi_2318_ = e94;
            }
            let e230: f32 = phi_2426_;
            let e232: f32 = phi_2366_;
            let e234: f32 = phi_2318_;
            phi_2425_ = e230;
            phi_2365_ = e232;
            phi_2317_ = e234;
        } else {
            let e238: bool = (bitcast<i32>((e104 & 64u)) != bitcast<i32>(0u));
            phi_1497_ = e238;
            if (!(e238)) {
                phi_1497_ = (bitcast<i32>((e104 & 128u)) != bitcast<i32>(0u));
            }
            let e245: bool = phi_1497_;
            if (e245) {
                if ((bitcast<i32>(((e106 >> bitcast<u32>(2)) & 1u)) != bitcast<i32>(0u))) {
                    let e252: vec4<f32> = textureSampleGrad(roughness_tex, primary_sampler, e114, e115, e116);
                    if (e238) {
                        phi_2300_ = e252.yz;
                    } else {
                        phi_2300_ = e252.xy;
                    }
                    let e256: vec2<f32> = phi_2300_;
                    phi_2369_ = (e92 * e256.y);
                    phi_2321_ = (e94 * e256.x);
                } else {
                    phi_2369_ = e102;
                    phi_2321_ = e94;
                }
                let e262: f32 = phi_2369_;
                let e264: f32 = phi_2321_;
                if ((bitcast<i32>(((e106 >> bitcast<u32>(9)) & 1u)) != bitcast<i32>(0u))) {
                    let e271: vec4<f32> = textureSampleGrad(ambient_occlusion_tex, primary_sampler, e114, e115, e116);
                    phi_2428_ = (e102 * e271.x);
                } else {
                    phi_2428_ = e102;
                }
                let e275: f32 = phi_2428_;
                phi_2427_ = e275;
                phi_2367_ = e262;
                phi_2319_ = e264;
            } else {
                phi_2429_ = 0.0;
                phi_2370_ = 0.0;
                phi_2322_ = 0.0;
                if ((bitcast<i32>((e104 & 256u)) != bitcast<i32>(0u))) {
                    if ((bitcast<i32>(((e106 >> bitcast<u32>(2)) & 1u)) != bitcast<i32>(0u))) {
                        let e286: vec4<f32> = textureSampleGrad(roughness_tex, primary_sampler, e114, e115, e116);
                        phi_2381_ = (e92 * e286.x);
                    } else {
                        phi_2381_ = e92;
                    }
                    let e290: f32 = phi_2381_;
                    if ((bitcast<i32>(((e106 >> bitcast<u32>(3)) & 1u)) != bitcast<i32>(0u))) {
                        let e297: vec4<f32> = textureSampleGrad(metallic_tex, primary_sampler, e114, e115, e116);
                        phi_2333_ = (e94 * e297.x);
                    } else {
                        phi_2333_ = e94;
                    }
                    let e301: f32 = phi_2333_;
                    if ((bitcast<i32>(((e106 >> bitcast<u32>(9)) & 1u)) != bitcast<i32>(0u))) {
                        let e308: vec4<f32> = textureSampleGrad(ambient_occlusion_tex, primary_sampler, e114, e115, e116);
                        phi_2434_ = (e102 * e308.x);
                    } else {
                        phi_2434_ = e102;
                    }
                    let e312: f32 = phi_2434_;
                    phi_2429_ = e312;
                    phi_2370_ = e290;
                    phi_2322_ = e301;
                }
                let e314: f32 = phi_2429_;
                let e316: f32 = phi_2370_;
                let e318: f32 = phi_2322_;
                phi_2427_ = e314;
                phi_2367_ = e316;
                phi_2319_ = e318;
            }
            let e320: f32 = phi_2427_;
            let e322: f32 = phi_2367_;
            let e324: f32 = phi_2319_;
            phi_2425_ = e320;
            phi_2365_ = e322;
            phi_2317_ = e324;
        }
        let e326: f32 = phi_2425_;
        let e328: f32 = phi_2365_;
        let e330: f32 = phi_2317_;
        if ((bitcast<i32>(((e106 >> bitcast<u32>(4)) & 1u)) != bitcast<i32>(0u))) {
            let e337: vec4<f32> = textureSampleGrad(reflectance_tex, primary_sampler, e114, e115, e116);
            phi_2334_ = (e96 * e337.x);
        } else {
            phi_2334_ = e96;
        }
        let e341: f32 = phi_2334_;
        let e342: vec3<f32> = e159.xyz;
        let e343: f32 = (1.0 - e330);
        if ((bitcast<i32>((e104 & 512u)) != bitcast<i32>(0u))) {
            if ((bitcast<i32>(((e106 >> bitcast<u32>(5)) & 1u)) != bitcast<i32>(0u))) {
                let e361: vec4<f32> = textureSampleGrad(clear_coat_tex, primary_sampler, e114, e115, e116);
                phi_2389_ = (e100 * e361.y);
                phi_2336_ = (e98 * e361.x);
            } else {
                phi_2389_ = e100;
                phi_2336_ = e98;
            }
            let e367: f32 = phi_2389_;
            let e369: f32 = phi_2336_;
            phi_2388_ = e367;
            phi_2335_ = e369;
        } else {
            if ((bitcast<i32>((e104 & 1024u)) != bitcast<i32>(0u))) {
                if ((bitcast<i32>(((e106 >> bitcast<u32>(5)) & 1u)) != bitcast<i32>(0u))) {
                    let e380: vec4<f32> = textureSampleGrad(clear_coat_tex, primary_sampler, e114, e115, e116);
                    phi_2339_ = (e98 * e380.x);
                } else {
                    phi_2339_ = e98;
                }
                let e384: f32 = phi_2339_;
                if ((bitcast<i32>(((e106 >> bitcast<u32>(6)) & 1u)) != bitcast<i32>(0u))) {
                    let e391: vec4<f32> = textureSampleGrad(clear_coat_roughness_tex, primary_sampler, e114, e115, e116);
                    phi_2391_ = (e100 * e391.y);
                } else {
                    phi_2391_ = e100;
                }
                let e395: f32 = phi_2391_;
                phi_2390_ = e395;
                phi_2337_ = e384;
            } else {
                phi_2392_ = 0.0;
                phi_2340_ = 0.0;
                if ((bitcast<i32>((e104 & 2048u)) != bitcast<i32>(0u))) {
                    if ((bitcast<i32>(((e106 >> bitcast<u32>(5)) & 1u)) != bitcast<i32>(0u))) {
                        let e406: vec4<f32> = textureSampleGrad(clear_coat_tex, primary_sampler, e114, e115, e116);
                        phi_2361_ = (e98 * e406.x);
                    } else {
                        phi_2361_ = e98;
                    }
                    let e410: f32 = phi_2361_;
                    if ((bitcast<i32>(((e106 >> bitcast<u32>(6)) & 1u)) != bitcast<i32>(0u))) {
                        let e417: vec4<f32> = textureSampleGrad(clear_coat_roughness_tex, primary_sampler, e114, e115, e116);
                        phi_2412_ = (e100 * e417.x);
                    } else {
                        phi_2412_ = e100;
                    }
                    let e421: f32 = phi_2412_;
                    phi_2392_ = e421;
                    phi_2340_ = e410;
                }
                let e423: f32 = phi_2392_;
                let e425: f32 = phi_2340_;
                phi_2390_ = e423;
                phi_2337_ = e425;
            }
            let e427: f32 = phi_2390_;
            let e429: f32 = phi_2337_;
            phi_2388_ = e427;
            phi_2335_ = e429;
        }
        let e431: f32 = phi_2388_;
        let e433: f32 = phi_2335_;
        phi_2413_ = e328;
        if ((e433 != 0.0)) {
            phi_2413_ = mix(e328, max(e328, e431), e433);
        }
        let e438: f32 = phi_2413_;
        if ((bitcast<i32>(((e106 >> bitcast<u32>(7)) & 1u)) != bitcast<i32>(0u))) {
            let e446: vec4<f32> = textureSampleGrad(emissive_tex, primary_sampler, e114, e115, e116);
            phi_2509_ = (e90 * e446.xyz);
        } else {
            phi_2509_ = e90;
        }
        let e450: vec3<f32> = phi_2509_;
        phi_2572_ = (e342 * e343);
        phi_2565_ = (e438 * e438);
        phi_2541_ = normalize(e210);
        phi_2513_ = ((e342 * e330) + vec3<f32>((((0.1599999964237213 * e341) * e341) * e343)));
        phi_2502_ = e450;
        phi_2414_ = e326;
    }
    let e452: vec3<f32> = phi_2572_;
    let e454: f32 = phi_2565_;
    let e456: vec3<f32> = phi_2541_;
    let e458: vec3<f32> = phi_2513_;
    let e460: vec3<f32> = phi_2502_;
    let e462: f32 = phi_2414_;
    let e465: u32 = unnamed_1.material.material_flags;
    if ((bitcast<i32>((e465 & 4096u)) != bitcast<i32>(0u))) {
        o_color = e159;
    } else {
        let e470: vec4<f32> = i_view_position_1;
        let e473: vec3<f32> = -(normalize(e470.xyz));
        phi_2601_ = e460;
        phi_2600_ = 0u;
        loop {
            let e475: vec3<f32> = phi_2601_;
            let e477: u32 = phi_2600_;
            let e480: u32 = unnamed_2.directional_light_header.total_lights;
            local = e475;
            local_1 = e475;
            local_2 = e475;
            if ((e477 < e480)) {
                continue;
            } else {
                break;
            }
            continuing {
                let e485: vec3<f32> = unnamed_2.directional_lights[e477].color;
                let e487: vec3<f32> = unnamed_2.directional_lights[e477].direction;
                let e490: mat4x4<f32> = unnamed.uniforms.view;
                let e500: vec3<f32> = normalize((mat3x3<f32>(e490[0].xyz, e490[1].xyz, e490[2].xyz) * -(e487)));
                let e502: vec3<f32> = normalize((e473 + e500));
                let e504: f32 = abs(dot(e456, e473));
                let e505: f32 = (e504 + 9.999999747378752e-6);
                let e507: f32 = clamp(dot(e456, e500), 0.0, 1.0);
                let e509: f32 = clamp(dot(e456, e502), 0.0, 1.0);
                let e514: f32 = (e454 * e454);
                let e518: f32 = ((((e509 * e514) - e509) * e509) + 1.0);
                phi_2601_ = (e475 + ((((e452 * 0.31830987334251404) + (((e458 + ((vec3<f32>(clamp(dot(e458, vec3<f32>(16.5, 16.5, 16.5)), 0.0, 1.0)) - e458) * pow((1.0 - clamp(dot(e500, e502), 0.0, 1.0)), 5.0))) * ((e514 / ((3.1415927410125732 * e518) * e518)) * (0.5 / ((e507 * sqrt((((((-9.999999747378752e-6 - e504) * e514) + e505) * e505) + e514))) + (e505 * sqrt(((((-(e507) * e514) + e507) * e507) + e514))))))) * 1.0)) * e485) * (e507 * e462)));
                phi_2600_ = (e477 + bitcast<u32>(1));
            }
        }
        let e557: vec3<f32> = local;
        let e560: vec3<f32> = local_1;
        let e563: vec3<f32> = local_2;
        let e568: vec4<f32> = unnamed.uniforms.ambient;
        o_color = max(vec4<f32>(e557.x, e560.y, e563.z, e159.w), (e568 * e159));
    }
    return;
}

[[stage(fragment)]]
fn main([[location(3)]] i_coords0_: vec2<f32>, [[location(5)]] i_color: vec4<f32>, [[location(1)]] i_normal: vec3<f32>, [[location(2)]] i_tangent: vec3<f32>, [[location(0)]] i_view_position: vec4<f32>, [[location(4)]] i_coords1_: vec2<f32>, [[location(6)]] i_material: u32) -> [[location(0)]] vec4<f32> {
    i_coords0_1 = i_coords0_;
    i_color_1 = i_color;
    i_normal_1 = i_normal;
    i_tangent_1 = i_tangent;
    i_view_position_1 = i_view_position;
    i_coords1_1 = i_coords1_;
    i_material_1 = i_material;
    main_1();
    let e15: vec4<f32> = o_color;
    return e15;
}

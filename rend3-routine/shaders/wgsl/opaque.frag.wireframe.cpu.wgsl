var<private> o_color: vec4<f32>;
var<private> i_view_position_1: vec4<f32>;
var<private> i_normal_1: vec3<f32>;
var<private> i_tangent_1: vec3<f32>;
var<private> i_coords0_1: vec2<f32>;
var<private> i_coords1_1: vec2<f32>;
var<private> i_color_1: vec4<f32>;
var<private> i_material_1: u32;

fn main_1() {
    o_color = vec4<f32>(1.0, 1.0, 1.0, 1.0);
    return;
}

[[stage(fragment)]]
fn main([[location(0)]] i_view_position: vec4<f32>, [[location(1)]] i_normal: vec3<f32>, [[location(2)]] i_tangent: vec3<f32>, [[location(3)]] i_coords0_: vec2<f32>, [[location(4)]] i_coords1_: vec2<f32>, [[location(5)]] i_color: vec4<f32>, [[location(6)]] i_material: u32) -> [[location(0)]] vec4<f32> {
    i_view_position_1 = i_view_position;
    i_normal_1 = i_normal;
    i_tangent_1 = i_tangent;
    i_coords0_1 = i_coords0_;
    i_coords1_1 = i_coords1_;
    i_color_1 = i_color;
    i_material_1 = i_material;
    main_1();
    let e15: vec4<f32> = o_color;
    return e15;
}

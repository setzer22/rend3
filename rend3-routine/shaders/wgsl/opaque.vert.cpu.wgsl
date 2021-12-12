struct ObjectOutputData {
    model_view: mat4x4<f32>;
    model_view_proj: mat4x4<f32>;
    material_idx: u32;
    inv_squared_scale: vec3<f32>;
};

[[block]]
struct ObjectOutputDataBuffer {
    object_output: [[stride(160)]] array<ObjectOutputData>;
};

[[block]]
struct gl_PerVertex {
    [[builtin(position)]] gl_Position: vec4<f32>;
};

struct VertexOutput {
    [[location(6)]] member: u32;
    [[location(0)]] member_1: vec4<f32>;
    [[location(1)]] member_2: vec3<f32>;
    [[location(2)]] member_3: vec3<f32>;
    [[location(5)]] member_4: vec4<f32>;
    [[location(3)]] member_5: vec2<f32>;
    [[location(4)]] member_6: vec2<f32>;
    [[builtin(position)]] gl_Position: vec4<f32>;
};

var<private> gl_InstanceIndex_1: i32;
[[group(1), binding(0)]]
var<storage> unnamed: ObjectOutputDataBuffer;
var<private> o_material: u32;
var<private> o_view_position: vec4<f32>;
var<private> i_position_1: vec3<f32>;
var<private> o_normal: vec3<f32>;
var<private> i_normal_1: vec3<f32>;
var<private> o_tangent: vec3<f32>;
var<private> i_tangent_1: vec3<f32>;
var<private> o_color: vec4<f32>;
var<private> i_color_1: vec4<f32>;
var<private> o_coords0_: vec2<f32>;
var<private> i_coords0_1: vec2<f32>;
var<private> o_coords1_: vec2<f32>;
var<private> i_coords1_1: vec2<f32>;
var<private> perVertexStruct: gl_PerVertex = gl_PerVertex(vec4<f32>(0.0, 0.0, 0.0, 1.0), );
var<private> i_material_1: u32;

fn main_1() {
    let e24: i32 = gl_InstanceIndex_1;
    let e28: ObjectOutputData = unnamed.object_output[bitcast<u32>(e24)];
    o_material = e28.material_idx;
    let e33: vec3<f32> = i_position_1;
    let e37: vec4<f32> = vec4<f32>(e33.x, e33.y, e33.z, 1.0);
    o_view_position = (e28.model_view * e37);
    let e45: mat3x3<f32> = mat3x3<f32>(e28.model_view[0].xyz, e28.model_view[1].xyz, e28.model_view[2].xyz);
    let e46: vec3<f32> = i_normal_1;
    o_normal = (e45 * (e28.inv_squared_scale * e46));
    let e49: vec3<f32> = i_tangent_1;
    o_tangent = (e45 * (e28.inv_squared_scale * e49));
    let e52: vec4<f32> = i_color_1;
    o_color = e52;
    let e53: vec2<f32> = i_coords0_1;
    o_coords0_ = e53;
    let e54: vec2<f32> = i_coords1_1;
    o_coords1_ = e54;
    perVertexStruct.gl_Position = (e28.model_view_proj * e37);
    return;
}

[[stage(vertex)]]
fn main([[builtin(instance_index)]] gl_InstanceIndex: u32, [[location(0)]] i_position: vec3<f32>, [[location(1)]] i_normal: vec3<f32>, [[location(2)]] i_tangent: vec3<f32>, [[location(5)]] i_color: vec4<f32>, [[location(3)]] i_coords0_: vec2<f32>, [[location(4)]] i_coords1_: vec2<f32>, [[location(6)]] i_material: u32) -> VertexOutput {
    gl_InstanceIndex_1 = i32(gl_InstanceIndex);
    i_position_1 = i_position;
    i_normal_1 = i_normal;
    i_tangent_1 = i_tangent;
    i_color_1 = i_color;
    i_coords0_1 = i_coords0_;
    i_coords1_1 = i_coords1_;
    i_material_1 = i_material;
    main_1();
    let e26: u32 = o_material;
    let e27: vec4<f32> = o_view_position;
    let e28: vec3<f32> = o_normal;
    let e29: vec3<f32> = o_tangent;
    let e30: vec4<f32> = o_color;
    let e31: vec2<f32> = o_coords0_;
    let e32: vec2<f32> = o_coords1_;
    let e33: vec4<f32> = perVertexStruct.gl_Position;
    return VertexOutput(e26, e27, e28, e29, e30, e31, e32, e33);
}

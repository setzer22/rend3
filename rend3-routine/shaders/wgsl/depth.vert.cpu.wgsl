[[block]]
struct gl_PerVertex {
    [[builtin(position)]] gl_Position: vec4<f32>;
};

struct VertexOutput {
    [[location(0)]] member: vec4<f32>;
    [[builtin(position)]] gl_Position: vec4<f32>;
    [[location(3)]] member1: u32;
    [[location(2)]] member2: vec4<f32>;
    [[location(1)]] member3: vec2<f32>;
};

var<private> gl_InstanceIndex1: i32;
var<private> o_position: vec4<f32>;
var<private> perVertexStruct: gl_PerVertex = gl_PerVertex(vec4<f32>(0.0, 0.0, 0.0, 1.0), );
var<private> o_material: u32;
var<private> o_color: vec4<f32>;
var<private> o_coords0: vec2<f32>;

fn main1() {
    o_position = vec4<f32>(1.0, 1.0, 1.0, 1.0);
    perVertexStruct.gl_Position = vec4<f32>(1.0, 1.0, 1.0, 1.0);
    o_material = 0u;
    o_color = vec4<f32>(1.0, 1.0, 1.0, 1.0);
    o_coords0 = vec2<f32>(1.0, 1.0);
    return;
}

[[stage(vertex)]]
fn main([[builtin(instance_index)]] gl_InstanceIndex: u32) -> VertexOutput {
    gl_InstanceIndex1 = i32(gl_InstanceIndex);
    main1();
    let e9: vec4<f32> = o_position;
    let e10: vec4<f32> = perVertexStruct.gl_Position;
    let e11: u32 = o_material;
    let e12: vec4<f32> = o_color;
    let e13: vec2<f32> = o_coords0;
    return VertexOutput(e9, e10, e11, e12, e13);
}

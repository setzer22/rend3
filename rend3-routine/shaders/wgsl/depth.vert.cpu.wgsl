[[block]]
struct gl_PerVertex {
    [[builtin(position)]] gl_Position: vec4<f32>;
};

var<private> perVertexStruct: gl_PerVertex = gl_PerVertex(vec4<f32>(0.0, 0.0, 0.0, 1.0), );

fn main1() {
    perVertexStruct.gl_Position = vec4<f32>(1.0, 1.0, 1.0, 1.0);
    return;
}

[[stage(vertex)]]
fn main() -> [[builtin(position)]] vec4<f32> {
    main1();
    let e2: vec4<f32> = perVertexStruct.gl_Position;
    return e2;
}

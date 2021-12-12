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

struct CullingUniforms {
    view: mat4x4<f32>;
    view_proj: mat4x4<f32>;
    frustum: Frustum;
    object_count: u32;
};

[[block]]
struct ObjectInputUniforms {
    uniforms: CullingUniforms;
};

[[block]]
struct PushConstants {
    stride: u32;
};

[[block]]
struct IntermediateBufferB {
    result_index_b: [[stride(4)]] array<u32>;
};

[[block]]
struct IntermediateBufferA {
    result_index_a: [[stride(4)]] array<u32>;
};

var<private> gl_GlobalInvocationID_1: vec3<u32>;
[[group(0), binding(1)]]
var<uniform> unnamed: ObjectInputUniforms;
var<push_constant> unnamed_1: PushConstants;
[[group(0), binding(3)]]
var<storage, read_write> unnamed_2: IntermediateBufferB;
[[group(0), binding(2)]]
var<storage, read_write> unnamed_3: IntermediateBufferA;

fn main_1() {
    switch(bitcast<i32>(0u)) {
        default: {
            let e18: u32 = gl_GlobalInvocationID_1[0u];
            let e21: u32 = unnamed.uniforms.object_count;
            if ((e18 >= e21)) {
                break;
            }
            let e24: u32 = unnamed_1.stride;
            if ((e18 < e24)) {
                let e28: u32 = unnamed_3.result_index_a[e18];
                unnamed_2.result_index_b[e18] = e28;
                break;
            }
            let e34: u32 = unnamed_3.result_index_a[e18];
            let e37: u32 = unnamed_3.result_index_a[(e18 - e24)];
            unnamed_2.result_index_b[e18] = insertBits(e34, (extractBits(e34, bitcast<u32>(0), bitcast<u32>(31)) + extractBits(e37, bitcast<u32>(0), bitcast<u32>(31))), bitcast<u32>(0), bitcast<u32>(31));
            break;
        }
    }
    return;
}

[[stage(compute), workgroup_size(256, 1, 1)]]
fn main([[builtin(global_invocation_id)]] gl_GlobalInvocationID: vec3<u32>) {
    gl_GlobalInvocationID_1 = gl_GlobalInvocationID;
    main_1();
}

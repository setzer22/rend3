#version 440

#include "structures.glsl"

// TODO: we don't need most of these
layout(location = 0) out vec4 o_position;
layout(location = 1) out vec2 o_coords0;
layout(location = 2) out vec4 o_color;
layout(location = 3) flat out uint o_material;

layout(set = 1, binding = 0, std430) readonly buffer ObjectOutputDataBuffer {
    ObjectOutputData object_output[];
};
#ifdef GPU_MODE
layout(set = 1, binding = 1, std430) readonly buffer MaterialBuffer {
    GPUMaterialData materials[];
};
#endif
#ifdef CPU_MODE
layout(set = 2, binding = 10) uniform TextureData {
    CPUMaterialData material;
};
#endif

void main() {
    uint object_idx = gl_InstanceIndex;

    o_position = vec4(1.0);
    gl_Position = vec4(1.0);

    o_material = 0;

    o_color = vec4(1.0);

    o_coords0 = vec2(1.0);
}

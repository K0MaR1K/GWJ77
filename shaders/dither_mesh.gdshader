shader_type canvas_item;
#include "dither.gdshaderinc"

void vertex() {
    g_q_size = getQuantizeSize(CANVAS_MATRIX);
    g_model_matrix = MODEL_MATRIX;
    g_texture_size = 1. / TEXTURE_PIXEL_SIZE;
    g_vertex = VERTEX;
    g_flat_vertex = VERTEX;
}

void fragment() {
    COLOR = ditherMesh(TEXTURE, UV);
}
//void light() {
	// Called for every pixel for every light affecting the CanvasItem.
	// Uncomment to replace the default light processing function with this one.
//}

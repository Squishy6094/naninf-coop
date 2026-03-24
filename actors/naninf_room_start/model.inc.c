Lights1 naninf_room_start_naninf_default_lights = gdSPDefLights1(
	0x58, 0x58, 0x58,
	0xB4, 0xB4, 0xB4, 0x28, 0x28, 0x28);

Vtx naninf_room_start_naninf_room_start_mesh_layer_1_vtx_cull[8] = {
	{{{-800, 0, 1000}, 0, {0, 0}, {0x00, 0x00, 0x00, 0x00}}},
	{{{-800, 1600, 1000}, 0, {0, 0}, {0x00, 0x00, 0x00, 0x00}}},
	{{{-800, 1600, -1000}, 0, {0, 0}, {0x00, 0x00, 0x00, 0x00}}},
	{{{-800, 0, -1000}, 0, {0, 0}, {0x00, 0x00, 0x00, 0x00}}},
	{{{800, 0, 1000}, 0, {0, 0}, {0x00, 0x00, 0x00, 0x00}}},
	{{{800, 1600, 1000}, 0, {0, 0}, {0x00, 0x00, 0x00, 0x00}}},
	{{{800, 1600, -1000}, 0, {0, 0}, {0x00, 0x00, 0x00, 0x00}}},
	{{{800, 0, -1000}, 0, {0, 0}, {0x00, 0x00, 0x00, 0x00}}},
};

Vtx naninf_room_start_naninf_room_start_mesh_layer_1_vtx_0[30] = {
	{{{-800, 0, 1000}, 0, {368, 1008}, {0x7F, 0x00, 0x00, 0xFF}}},
	{{{-800, 0, -1000}, 0, {368, 752}, {0x7F, 0x00, 0x00, 0xFF}}},
	{{{-800, 1600, -1000}, 0, {624, 752}, {0x7F, 0x00, 0x00, 0xFF}}},
	{{{-800, 1600, 1000}, 0, {624, 1008}, {0x7F, 0x00, 0x00, 0xFF}}},
	{{{-800, 0, -1000}, 0, {368, 752}, {0x00, 0x00, 0x7F, 0xFF}}},
	{{{800, 0, -1000}, 0, {368, 496}, {0x00, 0x00, 0x7F, 0xFF}}},
	{{{800, 1600, -1000}, 0, {624, 496}, {0x00, 0x00, 0x7F, 0xFF}}},
	{{{-800, 1600, -1000}, 0, {624, 752}, {0x00, 0x00, 0x7F, 0xFF}}},
	{{{800, 0, -1000}, 0, {368, 496}, {0x81, 0x00, 0x00, 0xFF}}},
	{{{800, 0, 1000}, 0, {368, 240}, {0x81, 0x00, 0x00, 0xFF}}},
	{{{800, 1600, 1000}, 0, {624, 240}, {0x81, 0x00, 0x00, 0xFF}}},
	{{{800, 1600, -1000}, 0, {624, 496}, {0x81, 0x00, 0x00, 0xFF}}},
	{{{800, 1600, 1000}, 0, {624, 240}, {0x00, 0x00, 0x81, 0xFF}}},
	{{{800, 0, 1000}, 0, {368, 240}, {0x00, 0x00, 0x81, 0xFF}}},
	{{{300, 0, 1000}, 0, {368, 160}, {0x00, 0x00, 0x81, 0xFF}}},
	{{{300, 600, 1000}, 0, {464, 160}, {0x00, 0x00, 0x81, 0xFF}}},
	{{{-300, 600, 1000}, 0, {464, 64}, {0x00, 0x00, 0x81, 0xFF}}},
	{{{-800, 1600, 1000}, 0, {624, -16}, {0x00, 0x00, 0x81, 0xFF}}},
	{{{-300, 0, 1000}, 0, {368, 64}, {0x00, 0x00, 0x81, 0xFF}}},
	{{{-800, 0, 1000}, 0, {368, -16}, {0x00, 0x00, 0x81, 0xFF}}},
	{{{300, 0, 1000}, 0, {288, 278}, {0x00, 0x7F, 0x00, 0xFF}}},
	{{{800, 0, 1000}, 0, {368, 240}, {0x00, 0x7F, 0x00, 0xFF}}},
	{{{800, 0, -1000}, 0, {368, 496}, {0x00, 0x7F, 0x00, 0xFF}}},
	{{{-300, 0, 1000}, 0, {192, 240}, {0x00, 0x7F, 0x00, 0xFF}}},
	{{{-800, 0, 1000}, 0, {112, 240}, {0x00, 0x7F, 0x00, 0xFF}}},
	{{{-800, 0, -1000}, 0, {112, 496}, {0x00, 0x7F, 0x00, 0xFF}}},
	{{{800, 1600, -1000}, 0, {624, 496}, {0x00, 0x81, 0x00, 0xFF}}},
	{{{800, 1600, 1000}, 0, {624, 240}, {0x00, 0x81, 0x00, 0xFF}}},
	{{{-800, 1600, 1000}, 0, {880, 240}, {0x00, 0x81, 0x00, 0xFF}}},
	{{{-800, 1600, -1000}, 0, {880, 496}, {0x00, 0x81, 0x00, 0xFF}}},
};

Gfx naninf_room_start_naninf_room_start_mesh_layer_1_tri_0[] = {
	gsSPVertex(naninf_room_start_naninf_room_start_mesh_layer_1_vtx_0 + 0, 30, 0),
	gsSP2Triangles(0, 1, 2, 0, 0, 2, 3, 0),
	gsSP2Triangles(4, 5, 6, 0, 4, 6, 7, 0),
	gsSP2Triangles(8, 9, 10, 0, 8, 10, 11, 0),
	gsSP2Triangles(12, 13, 14, 0, 12, 14, 15, 0),
	gsSP2Triangles(12, 15, 16, 0, 16, 17, 12, 0),
	gsSP2Triangles(16, 18, 17, 0, 18, 19, 17, 0),
	gsSP2Triangles(20, 21, 22, 0, 23, 20, 22, 0),
	gsSP2Triangles(23, 22, 24, 0, 22, 25, 24, 0),
	gsSP2Triangles(26, 27, 28, 0, 26, 28, 29, 0),
	gsSPEndDisplayList(),
};


Gfx mat_naninf_room_start_naninf_default[] = {
	gsSPSetLights1(naninf_room_start_naninf_default_lights),
	gsDPPipeSync(),
	gsDPSetCombineLERP(0, 0, 0, SHADE, 0, 0, 0, ENVIRONMENT, 0, 0, 0, SHADE, 0, 0, 0, ENVIRONMENT),
	gsDPSetAlphaDither(G_AD_NOISE),
	gsSPTexture(65535, 65535, 0, 0, 1),
	gsSPEndDisplayList(),
};

Gfx mat_revert_naninf_room_start_naninf_default[] = {
	gsDPPipeSync(),
	gsDPSetAlphaDither(G_AD_DISABLE),
	gsSPEndDisplayList(),
};

Gfx naninf_room_start_naninf_room_start_mesh_layer_1[] = {
	gsSPClearGeometryMode(G_LIGHTING),
	gsSPVertex(naninf_room_start_naninf_room_start_mesh_layer_1_vtx_cull + 0, 8, 0),
	gsSPSetGeometryMode(G_LIGHTING),
	gsSPCullDisplayList(0, 7),
	gsSPDisplayList(mat_naninf_room_start_naninf_default),
	gsSPDisplayList(naninf_room_start_naninf_room_start_mesh_layer_1_tri_0),
	gsSPDisplayList(mat_revert_naninf_room_start_naninf_default),
	gsDPPipeSync(),
	gsSPSetGeometryMode(G_LIGHTING),
	gsSPClearGeometryMode(G_TEXTURE_GEN),
	gsDPSetCombineLERP(0, 0, 0, SHADE, 0, 0, 0, ENVIRONMENT, 0, 0, 0, SHADE, 0, 0, 0, ENVIRONMENT),
	gsSPTexture(65535, 65535, 0, 0, 0),
	gsDPSetEnvColor(255, 255, 255, 255),
	gsDPSetAlphaCompare(G_AC_NONE),
	gsSPEndDisplayList(),
};


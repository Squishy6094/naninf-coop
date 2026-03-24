Lights1 empty_dl_empty_mat_lights = gdSPDefLights1(
	0x7F, 0x7F, 0x7F,
	0xFF, 0xFF, 0xFF, 0x28, 0x28, 0x28);

Vtx empty_dl_Plane_mesh_layer_1_vtx_cull[8] = {
	{{{-100, 0, 100}, 0, {0, 0}, {0x00, 0x00, 0x00, 0x00}}},
	{{{-100, 0, 100}, 0, {0, 0}, {0x00, 0x00, 0x00, 0x00}}},
	{{{-100, 0, -100}, 0, {0, 0}, {0x00, 0x00, 0x00, 0x00}}},
	{{{-100, 0, -100}, 0, {0, 0}, {0x00, 0x00, 0x00, 0x00}}},
	{{{100, 0, 100}, 0, {0, 0}, {0x00, 0x00, 0x00, 0x00}}},
	{{{100, 0, 100}, 0, {0, 0}, {0x00, 0x00, 0x00, 0x00}}},
	{{{100, 0, -100}, 0, {0, 0}, {0x00, 0x00, 0x00, 0x00}}},
	{{{100, 0, -100}, 0, {0, 0}, {0x00, 0x00, 0x00, 0x00}}},
};

Vtx empty_dl_Plane_mesh_layer_1_vtx_0[4] = {
	{{{-100, 0, 100}, 0, {-16, 1008}, {0x00, 0x7F, 0x00, 0xFF}}},
	{{{100, 0, 100}, 0, {1008, 1008}, {0x00, 0x7F, 0x00, 0xFF}}},
	{{{100, 0, -100}, 0, {1008, -16}, {0x00, 0x7F, 0x00, 0xFF}}},
	{{{-100, 0, -100}, 0, {-16, -16}, {0x00, 0x7F, 0x00, 0xFF}}},
};

Gfx empty_dl_Plane_mesh_layer_1_tri_0[] = {
	gsSPVertex(empty_dl_Plane_mesh_layer_1_vtx_0 + 0, 4, 0),
	gsSP2Triangles(0, 1, 2, 0, 0, 2, 3, 0),
	gsSPEndDisplayList(),
};

Gfx mat_empty_dl_empty_mat[] = {
	gsSPSetLights1(empty_dl_empty_mat_lights),
	gsDPPipeSync(),
	gsDPSetCombineLERP(0, 0, 0, SHADE, 0, 0, 0, ENVIRONMENT, 0, 0, 0, SHADE, 0, 0, 0, ENVIRONMENT),
	gsDPSetAlphaDither(G_AD_NOISE),
	gsSPTexture(65535, 65535, 0, 0, 1),
	gsSPEndDisplayList(),
};

Gfx mat_revert_empty_dl_empty_mat[] = {
	gsDPPipeSync(),
	gsDPSetAlphaDither(G_AD_DISABLE),
	gsSPEndDisplayList(),
};

Gfx empty_dl_Plane_mesh_layer_1[] = {
	gsSPClearGeometryMode(G_LIGHTING),
	gsSPVertex(empty_dl_Plane_mesh_layer_1_vtx_cull + 0, 8, 0),
	gsSPSetGeometryMode(G_LIGHTING),
	gsSPCullDisplayList(0, 7),
	gsSPDisplayList(mat_empty_dl_empty_mat),
	gsSPDisplayList(empty_dl_Plane_mesh_layer_1_tri_0),
	gsSPDisplayList(mat_revert_empty_dl_empty_mat),
	gsSPEndDisplayList(),
};

Gfx empty_dl_material_revert_render_settings[] = {
	gsDPPipeSync(),
	gsSPSetGeometryMode(G_LIGHTING),
	gsSPClearGeometryMode(G_TEXTURE_GEN),
	gsDPSetCombineLERP(0, 0, 0, SHADE, 0, 0, 0, ENVIRONMENT, 0, 0, 0, SHADE, 0, 0, 0, ENVIRONMENT),
	gsSPTexture(65535, 65535, 0, 0, 0),
	gsDPSetEnvColor(255, 255, 255, 255),
	gsDPSetAlphaCompare(G_AC_NONE),
	gsDPSetTextureImage(G_IM_FMT_RGBA, G_IM_SIZ_16b_LOAD_BLOCK, 1, 0),
	gsDPSetTile(G_IM_FMT_RGBA, G_IM_SIZ_16b_LOAD_BLOCK, 0, 0, 7, 0, G_TX_WRAP | G_TX_NOMIRROR, 0, 0, G_TX_WRAP  | G_TX_NOMIRROR, 0, 0),
	gsDPLoadBlock(7, 0, 0, 1023, 256),
	gsDPSetTile(G_IM_FMT_RGBA, G_IM_SIZ_16b, 8, 0, 0, 0, G_TX_CLAMP | G_TX_NOMIRROR, 5, 0, G_TX_CLAMP | G_TX_NOMIRROR, 5, 0),
	gsDPSetTileSize(0, 0, 0, 124, 124),
	gsDPSetTextureImage(G_IM_FMT_RGBA, G_IM_SIZ_16b_LOAD_BLOCK, 1, 0),
	gsDPSetTile(G_IM_FMT_RGBA, G_IM_SIZ_16b_LOAD_BLOCK, 0, 256, 6, 0, G_TX_WRAP | G_TX_NOMIRROR, 0, 0, G_TX_WRAP | G_TX_NOMIRROR, 0, 0),
	gsDPLoadBlock(6, 0, 0, 1023, 256),
	gsDPSetTile(G_IM_FMT_RGBA, G_IM_SIZ_16b, 8, 256, 1, 0, G_TX_CLAMP | G_TX_NOMIRROR, 5, 0, G_TX_CLAMP | G_TX_NOMIRROR, 5, 0),
	gsDPSetTileSize(1, 0, 0, 124, 124),
	gsSPEndDisplayList(),
};


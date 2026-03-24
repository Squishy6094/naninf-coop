-- name: NANINF
-- incompatible: romhack gamemode

gLevelValues.fixCollisionBugs = true
local EMPTY_VEC3F = {x = 0, y = 0, z = 0}

LEVEL_EMPTY = level_register('level_empty_entry', COURSE_NONE, "naninf", 'naninf', 28000, 0x28, 0x28, 0x28)

local roomObjects = {
    {name = "start",        exitPos = {x = 0,     y = 0,    z = 1000, yaw = 0}},
    {name = "splitter",     exitPos = {x = 0,     y = 0,    z = 100,  yaw = 0}},
    {name = "ascend_right", exitPos = {x = -1600, y = 800,  z = 2400, yaw = 0}},
    {name = "wallkick",     exitPos = {x = 0,     y = 2400, z = 4000, yaw = 0}},
    {name = "left_bend",    exitPos = {x = 2800,  y = 0,    z = 2800, yaw = 0x4000}},
    {name = "slide",        exitPos = {x = 0,     y = -2000,z = 5600, yaw = 0}},
    {name = "spiral_decent",exitPos = {x = -1600, y = -1800,z = 0,    yaw = 0x8000}},
}

for i = 1, #roomObjects do
    roomObjects[i].model = smlua_model_util_get_id("naninf_room_"..roomObjects[i].name.."_geo")
    roomObjects[i].col = smlua_collision_util_get("naninf_room_"..roomObjects[i].name.."_collision")
end

---@param o Object
local function bhv_room_init(o)
    -- Set Room Type
    o.oAction = o.oAction ~= 0 and o.oAction or 2
    local roomData = roomObjects[o.oAction]
    log_to_console("[" .. get_active_mod().name .. "] Initialized Room: " .. roomData.name)

    -- Set Room Model
    obj_set_model_extended(o, roomData.model)
    o.collisionData = roomData.col
    o.oCollisionDistance = 100000

    -- Make sure it's always rendered
    o.header.gfx.skipInViewCheck = true
end

---@param o Object
local function bhv_room_loop(o)
    load_object_collision_model()
end

local id_bhvRoom = hook_behavior(nil, OBJ_LIST_SURFACE, true, bhv_room_init, bhv_room_loop, "bhvRoom")

local offset = {x = 0, y = 0, z = 0, yaw = 0}
local function spawn_room(id, nonSync)
    local id = (id and id ~= 0) and id or math.random(3, #roomObjects)
    local roomData = roomObjects[id]

    local spawnX = offset.x
    local spawnY = offset.y
    local spawnZ = offset.z
    local spawnYaw = offset.yaw

    local spawn_func = nonSync and spawn_non_sync_object or spawn_sync_object
    spawn_func(id_bhvRoom, E_MODEL_NONE, spawnX, spawnY, spawnZ, function(o)
        o.oAction = id
        o.oFaceAngleYaw = spawnYaw
    end)

    local exit = roomData.exitPos

    local s = sins(spawnYaw)
    local c = coss(spawnYaw)

    local rx = (exit.x * c) + (exit.z * s)
    local rz = (-exit.x * s) + (exit.z * c)

    offset.x = spawnX + rx
    offset.y = spawnY + exit.y
    offset.z = spawnZ + rz
    offset.yaw = math.s16(spawnYaw + exit.yaw)
end

local function update()
    local np = gNetworkPlayers[0]
    if np.currLevelNum ~= LEVEL_EMPTY then
        warp_to_level(LEVEL_EMPTY, 1, 0) 
    end
end

local function level_init()
    prevRoomSpawn = nil
    offset.x = 0
    offset.y = 0
    offset.z = 0
    offset.yaw = 0
    spawn_room(1, true)
    --spawn_room(2, true)
end

local function level_sync()
    if network_is_server() then
        for i = 1, 30 do
            spawn_room(2)
            spawn_room()
        end
    end
end

hook_event(HOOK_UPDATE, update)
hook_event(HOOK_ON_LEVEL_INIT, level_init)
hook_event(HOOK_ON_SYNC_VALID, level_sync)
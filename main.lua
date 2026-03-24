-- name: NANINF
-- incompatible: romhack gamemode

gLevelValues.fixCollisionBugs = true
gLevelValues.fixCollisionBugsPickBestWall = true

LEVEL_EMPTY = level_register('level_empty_entry', COURSE_NONE, "naninf", 'naninf', 28000, 0x28, 0x28, 0x28)

local roomObjects = {
    {name = "start",        exitPos = {x = 0,     y = 0,    z = 1000, yaw = 0}},
    {name = "splitter",     exitPos = {x = 0,     y = 0,    z = 100,  yaw = 0}},
    {name = "ascend_right", exitPos = {x = -1600, y = 800,  z = 2400, yaw = 0}},
    {name = "wallkick",     exitPos = {x = 0,     y = 1600, z = 4000, yaw = 0}},
    {name = "left_bend",    exitPos = {x = 2800,  y = 0,    z = 2800, yaw = 0x4000}},
    {name = "slide",        exitPos = {x = 0,     y = -2000,z = 5600, yaw = 0}},
    {name = "spiral_decent",exitPos = {x = -1600, y = -1800,z = 0,    yaw = 0x8000}},
}

local worldColorTable = {
    { r = 255, g = 50,  b = 50  },
    { r = 255, g = 100, b = 50  },
    { r = 255, g = 255, b = 50  },
    { r = 50,  g = 255, b = 50  },
    { r = 50,  g = 50,  b = 255 },
    { r = 251, g = 148, b = 220 },
    { r = 130, g = 25,  b = 130 },
    { r = 255, g = 255, b = 255 },
    { r = 50,  g = 50,  b = 50  }
}
local worldColor = {r = 255, g = 255, b = 255}
local worldColorTarget = {r = 255, g = 255, b = 255}
local function set_world_color(r, g, b)
    set_lighting_color(0, r)
    set_lighting_color(1, g)
    set_lighting_color(2, b)
    set_lighting_color_ambient(0, r)
    set_lighting_color_ambient(1, g)
    set_lighting_color_ambient(2, b)
    set_skybox_color(0, r)
    set_skybox_color(1, g)
    set_skybox_color(2, b)
    set_fog_color(0, r)
    set_fog_color(1, g)
    set_fog_color(2, b)
    set_vertex_color(0, r)
    set_vertex_color(1, g)
    set_vertex_color(2, b)
end

local function coords_rotate(x, y, yaw)

    local s = sins(yaw)
    local c = coss(yaw)

    local rx = (x * c) + (y * s)
    local ry = (-x * s) + (y * c)
    return rx, ry
end

---@param func function?
local function get_room_id_with_condition(func)
    local id = math.random(3, #roomObjects)
    if func ~= nil then
        while not func(id, roomObjects[id]) do
            id = math.random(3, #roomObjects)
        end
    end
    return id
end

for i = 1, #roomObjects do
    roomObjects[i].model = smlua_model_util_get_id("naninf_room_"..roomObjects[i].name.."_geo")
    roomObjects[i].col = smlua_collision_util_get("naninf_room_"..roomObjects[i].name.."_collision")
end

---@param o Object
local function bhv_room_init(o)
    -- Set Room Type
    o.oFlags = OBJ_FLAG_UPDATE_GFX_POS_AND_ANGLE
    o.oAnimState = o.oAnimState ~= 0 and o.oAnimState or 2
    local roomData = roomObjects[o.oAnimState]
    log_to_console("[" .. get_active_mod().name .. "] Initialized Room: " .. roomData.name)

    -- Set Room Model
    obj_set_model_extended(o, roomData.model)
    o.collisionData = roomData.col
    o.oCollisionDistance = 100000

    -- Make sure it's always rendered
    o.header.gfx.skipInViewCheck = true

    worldColorTarget = worldColorTable[math.random(1, #worldColorTable)]

    if o.oSyncID ~= 0 then
        network_init_object(o, true, {
            "oAnimState",
            "oAction",
            "oTimer",
        })
    end
end

local spawnNewRoom = false
---@param o Object
local function bhv_room_loop(o)

    if o.oAction == 1 then
        if o.oTimer > 300 then
            o.oAction = 2
        end
    elseif o.oAction == 2 then
        obj_mark_for_deletion(o)
    end

    o.oFaceAnglePitch = 0
    o.oFaceAngleRoll = 0
    load_object_collision_model()
end

local id_bhvRoom = hook_behavior(nil, OBJ_LIST_SURFACE, true, bhv_room_init, bhv_room_loop, "bhvRoom")

local offset = {x = 0, y = 0, z = 0, yaw = 0}
local prevId = 0
local function spawn_room(id, nonSync)
    local spawnX = offset.x
    local spawnY = offset.y
    local spawnZ = offset.z
    local spawnYaw = offset.yaw

    local id = (id and id ~= 0) and id or get_room_id_with_condition(function (id, room)
        return id ~= prevId
    end)
    local roomData = roomObjects[id]

    -- Check for intersections
    ray_set_color(0, 255, 0)
    local rayX, rayZ = coords_rotate(roomData.exitPos.x*1.5, roomData.exitPos.z*1.5, spawnYaw)
    local ray = collision_find_surface_on_ray(spawnX, spawnY, spawnZ, rayX, roomData.exitPos.y*1.5, rayZ)
    ray_set_color(255, 255, 0)
    local ray2 = collision_find_surface_on_ray(spawnX + rayX, spawnY + roomData.exitPos.y*1.5, spawnZ + rayZ, -rayX, -roomData.exitPos.y*1.5, -rayZ)
    while ray.surface ~= nil and ray2.surface ~= nil do
        id = get_room_id_with_condition()
        roomData = roomObjects[id]
        ray_set_color(0, 0, 255)
        local rayX, rayZ = coords_rotate(roomData.exitPos.x*1.5, roomData.exitPos.z*1.5, spawnYaw)
        ray = collision_find_surface_on_ray(spawnX, spawnY, spawnZ, rayX, roomData.exitPos.y*1.5, rayZ)
        ray_set_color(0, 255, 255)
        ray2 = collision_find_surface_on_ray(spawnX + rayX, spawnY + roomData.exitPos.y*1.5, spawnZ + rayZ, -rayX, -roomData.exitPos.y*1.5, -rayZ)
    end


    local spawn_func = nonSync and spawn_non_sync_object or spawn_sync_object
    spawn_func(id_bhvRoom, E_MODEL_NONE, spawnX, spawnY, spawnZ, function(o)
        o.oAnimState = id
        o.oFaceAngleYaw = spawnYaw
    end)

    local exit = roomData.exitPos
    local rx, rz = coords_rotate(exit.x, exit.z, spawnYaw)

    offset.x = spawnX + rx
    offset.y = spawnY + exit.y
    offset.z = spawnZ + rz
    offset.yaw = math.s16(spawnYaw + exit.yaw)
    if id > 2 then
        prevId = id
    end
end

local function update()
    local np = gNetworkPlayers[0]
    if np.currLevelNum ~= LEVEL_EMPTY then
        warp_to_level(LEVEL_EMPTY, 1, 0) 
    end

    worldColor.r = math.lerp(worldColor.r, worldColorTarget.r, 0.05)
    worldColor.g = math.lerp(worldColor.g, worldColorTarget.g, 0.05)
    worldColor.b = math.lerp(worldColor.b, worldColorTarget.b, 0.05)
    set_world_color(worldColor.r, worldColor.g, worldColor.b)

    if network_is_server() and spawnNewRoom then
        spawnNewRoom = false
        spawn_room(2)
        local checkX = math.abs(offset.x + sins(offset.yaw)*10000) > 25000
        local checkZ = math.abs(offset.z + coss(offset.yaw)*10000) > 25000
        if math.abs(offset.y) > 8000 then
            -- Force raise/lower for safety
            spawn_room(get_room_id_with_condition(function (id, room)
                return offset.y > 0 and (room.exitPos.y < 0) or (room.exitPos.y > 0)
            end))
        elseif checkX or checkZ then
            -- Force turn for safety
            local minAngle = (checkX and checkZ) and 0x6000 or 0x4000
            if checkX and checkZ then
                djui_chat_message_create("bing")
            else
                djui_chat_message_create("fuck")
            end
            spawn_room(get_room_id_with_condition(function (id, room)
                return math.abs(room.exitPos.yaw) >= minAngle
            end))
        else
            -- Safe to spawn any room
            spawn_room()
        end
    end
end

local lastHitPos = nil 
local roomCount = 0
local function mario_update(m)
    if is_player_active(m) == 0 then return end

    o = obj_get_first_with_behavior_id(id_bhvRoom)
    while o ~= nil do
        local exit = roomObjects[o.oAnimState].exitPos
        local rx, rz = coords_rotate(exit.x, exit.z, o.oFaceAngleYaw)
        local endPos = {
            x = o.oPosX + rx,
            y = o.oPosY + exit.y,
            z = o.oPosZ + rz,
        }
        --spawn_non_sync_object(id_bhvSparkleSpawn, E_MODEL_NONE, endPos.x, endPos.y, endPos.z, function () end)
        if vec3f_dist(m.pos, endPos) < 600 then
            if network_is_server() and o.oAction == 0 then
                o.oAction = 1
                if o.oAnimState ~= 2 then
                    djui_chat_message_create(tostring(vec3f_dist(m.pos, endPos)))
                    spawnNewRoom = true
                end
            end

            if not lastHitPos or vec3f_dist(lastHitPos, endPos) > 300 then
                lastHitPos = endPos
                roomCount = roomCount + 1
                djui_chat_message_create(tostring(roomCount))
            end
        end

        o = obj_get_next_with_same_behavior_id(o)
    end
end

local function level_init()
    lastHitPos = nil
    roomCount = 0
    offset.x = 0
    offset.y = 0
    offset.z = 0
    offset.yaw = 0
    spawn_room(1, true)
    --spawn_room(2, true)
end

local function level_sync()
    if network_is_server() then
        --math.randomseed(0)
        for i = 1, 1 do
            spawn_room(2)
            spawn_room()
        end
    end
end

hook_event(HOOK_UPDATE, update)
hook_event(HOOK_MARIO_UPDATE, mario_update)
hook_event(HOOK_ON_LEVEL_INIT, level_init)
hook_event(HOOK_ON_SYNC_VALID, level_sync)
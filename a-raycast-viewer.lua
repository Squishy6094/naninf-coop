-- Localize funcs for optimization :nerd:
local og_find_ray = collision_find_surface_on_ray
local vec_copy    = vec3f_copy
local vec_dist    = vec3f_dist
local clamp       = math.clamp
local min         = math.min
local mario       = gMarioStates[0]

local hud_set_res   = djui_hud_set_resolution
local hud_set_color = djui_hud_set_color
local hud_world_to_screen = djui_hud_world_pos_to_screen_pos
local hud_render_line = djui_hud_render_line
local hud_print     = djui_hud_print_text

local rayList = {}
local rayCount = 0

function clear_ray_visuals()
    for i = 1, rayCount do
        rayList[i] = nil
    end
    rayCount = 0
end

function clear_last_ray_visual()
    if rayCount > 0 then
        rayList[rayCount] = nil
        rayCount = rayCount - 1
    end
end

function add_last_ray_lable(label)
    if rayCount > 0 then
        rayList[rayCount].label = label
    end
end

local rayR, rayG, rayB = 255, 255, 255
function ray_set_color(r, g, b)
    rayR, rayG, rayB = r, g, b
end

function collision_find_surface_on_ray(startX, startY, startZ, dirX, dirY, dirZ, precision)

    local ray = og_find_ray(startX, startY, startZ, dirX, dirY, dirZ, precision or 50)

    rayCount = rayCount + 1
    local entry = rayList[rayCount]
    if entry == nil then
        entry = {}
        rayList[rayCount] = entry
    end

    -- reuse sub tables
    entry.start = entry.start or {}
    entry.hit   = entry.hit   or {}
    entry.color = entry.color or {}

    entry.start.x = startX
    entry.start.y = startY
    entry.start.z = startZ

    entry.hit.x = startX + dirX
    entry.hit.y = startY + dirY
    entry.hit.z = startZ + dirZ

    if ray and ray.surface then
        vec_copy(entry.hit, ray.hitPos)
        entry.surface = ray.surface
    else
        entry.surface = nil
    end

    entry.color.r = rayR
    entry.color.g = rayG
    entry.color.b = rayB
    entry.label = nil

    return ray
end

local p1 = {x=0,y=0,z=0}
local p2 = {x=0,y=0,z=0}
local renderDist = 1000

local function hud_render()
    if true then return end

    hud_set_res(RESOLUTION_N64)

    local mPos = mario.pos

    for i = 1, rayCount do
        local ray = rayList[i]
        if ray then

            local d1 = vec_dist(mPos, ray.start)
            local d2 = vec_dist(mPos, ray.hit)
            local closest = min(d1, d2)

            if closest > 0 then
                local opacity = 255 * clamp((renderDist / closest) * 3 - 1, 0, 1)

                if opacity > 20 then
                    hud_set_color(ray.color.r, ray.color.g, ray.color.b, opacity)

                    p1.x = ray.start.x
                    p1.y = ray.start.y
                    p1.z = ray.start.z

                    p2.x = ray.hit.x
                    p2.y = ray.hit.y
                    p2.z = ray.hit.z

                    hud_world_to_screen(p1, p1)
                    hud_world_to_screen(p2, p2)

                    hud_render_line(p1.x, p1.y, p2.x, p2.y, 1)

                    if ray.label ~= nil then
                        hud_set_color(255,255,255,opacity)
                        hud_print(tostring(ray.label), p2.x, p2.y, 0.5)
                    end
                end
            end
        end
    end
end

hook_event(HOOK_ON_HUD_RENDER_BEHIND, hud_render)
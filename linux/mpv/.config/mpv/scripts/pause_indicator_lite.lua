--[[

   A simple script that shows a pause indicator, on pause
   https://github.com/Samillion/ModernZ/tree/main/extras/pause-indicator-lite

--]]

local options = {
    -- indicator icon type
    indicator_icon = "pause",        -- indicator icon type. "pause", "play"
    indicator_stay = true,           -- keep indicator visibile during pause
    indicator_timeout = 0.6,         -- timeout (seconds) if indicator doesn't stay

    -- keybind
    keybind_allow = true,            -- allow keybind to toggle pause
    keybind_set = "mbtn_left",       -- the used keybind to toggle pause
    keybind_mode = "onpause",        -- mode to activate keybind. "onpause", "always"

    -- icon colors & opacity
    icon_color = "#FFFFFF",          -- icon fill color
    icon_border_color = "#111111",   -- icon border color
    icon_opacity = 40,               -- icon opacity (0-100)

    -- pause icon
    rectangles_width = 30,           -- width of rectangles
    rectangles_height = 80,          -- height of rectangles
    rectangles_spacing = 20,         -- spacing between the two rectangles

    -- play icon
    triangle_width = 80,             -- width of triangle
    triangle_height = 80,            -- height of triangle

    -- best with pause icon
    flash_play_icon = true,          -- flash play icon on unpause
    flash_icon_timeout = 0.3,        -- timeout (seconds) for flash icon
}

local msg = require "mp.msg"

-- convert color from hex (credit to mpv/osc.lua)
local function convert_color(color)
    if color:find("^#%x%x%x%x%x%x$") == nil then
        msg.warn("'" .. color .. "' is not a valid color, using default '#FFFFFF'")
        return "FFFFFF"  -- color fallback
    end
    return color:sub(6,7) .. color:sub(4,5) .. color:sub(2,3)
end

-- convert percentage opacity (0-100) to ASS alpha values
local function convert_opacity(value)
    value = math.max(0, math.min(100, value))
    return string.format("%02X", (255 - (value * 2.55)))
end

-- colors and opaicty
local icon_color = convert_color(options.icon_color)
local icon_border_color = convert_color(options.icon_border_color)
local icon_opacity = convert_opacity(options.icon_opacity)

-- pause icon
local function draw_rectangles()
    return string.format([[{\an5\p1\alpha&H%s\1c&H%s&\3c&H%s&}m 0 0 l %d 0 l %d %d l 0 %d m %d 0 l %d 0 l %d %d l %d %d]],
        icon_opacity, icon_color, icon_border_color, options.rectangles_width, options.rectangles_width, options.rectangles_height, options.rectangles_height,
        options.rectangles_width + options.rectangles_spacing, options.rectangles_width * 2 + options.rectangles_spacing, options.rectangles_width * 2 + options.rectangles_spacing, options.rectangles_height,
        options.rectangles_width + options.rectangles_spacing, options.rectangles_height)
end

-- play icon
local function draw_triangle()
    return string.format([[{\an5\p1\alpha&H%s\1c&H%s&\3c&H%s&}m 0 0 l %d %d l 0 %d]], 
        icon_opacity, icon_color, icon_border_color, options.triangle_width, options.triangle_height / 2, options.triangle_height)
end

-- init
local indicator = mp.create_osd_overlay("ass-events")
local flash = mp.create_osd_overlay("ass-events")

-- keep track of pause toggle
local toggled = false

-- draw and update indicator
local function update_indicator()
    local _, _, display_aspect = mp.get_osd_size()
    if display_aspect == 0 or (indicator.visible and not toggled) then return end

    indicator.data = options.indicator_icon == "play" and draw_triangle() or draw_rectangles()
    indicator:update()

    if not options.indicator_stay then
        mp.add_timeout(options.indicator_timeout, function() indicator:remove() end)
    end
end

-- flash play icon
local function flash_icon()
    if not options.flash_play_icon then return flash:remove() end
    flash.data = draw_triangle()
    flash:update()
    mp.add_timeout(options.flash_icon_timeout, function() flash:remove() end)
end

-- check if file is video
local function is_video()
    local t = mp.get_property_native("current-tracks/video")
    if t and not (t.image or t.albumart) then
        return true
    else
        indicator:remove()
        flash:remove()
        return false
    end
end

-- observe when pause state changes
mp.observe_property("pause", "bool", function(_, paused)
    if not is_video() then return mp.unobserve_property("pause") end
    if paused then
        update_indicator()
        toggled = true
        if options.flash_play_icon then flash:remove() end
    else
        indicator:remove()
        if toggled then
            flash_icon()
            toggled = false
        end
    end

    -- keybind setup (if options allow it)
    if options.keybind_allow == true then
        mp.set_key_bindings({
           {options.keybind_set, function() mp.commandv("cycle", "pause") end}
        }, "pause-indicator", "force")

        if options.keybind_mode == "always" or (options.keybind_mode == "onpause" and paused) then
            mp.enable_key_bindings("pause-indicator")
        else
            mp.disable_key_bindings("pause-indicator")
        end
    end
end)

-- update pause indicator position if window size changes
mp.observe_property("osd-dimensions", "native", function()
    if indicator and indicator.visible then
        update_indicator()
    end
end)

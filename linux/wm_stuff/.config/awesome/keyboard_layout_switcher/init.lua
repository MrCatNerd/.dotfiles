local M = {} -- TODO: finish this and stuff

local awful = require("awful")

local cache = { -- why tf lua is 1 based indexed
	current_layout_index = 1,
	last_layout_index = 2,
}

local layouts = { "dvorak", "il" }

function M.switch_layouts() -- switch through current and last layout
	local switch_temp = cache.current_layout_index

	cache.current_layout_index = cache.last_layout_index
	cache.last_layout_index = switch_temp

	awful.spawn.with_shell("setxkbmap " .. layouts[cache.current_layout_index])
end

function M.scroll_layouts(scroll_direction)
	scroll_direction = scroll_direction or 1

	if scroll_direction < 0 then
		scroll_direction = -1
	else
		scroll_direction = 1
	end

	local switch_tmep = cache.current_layout_index
	cache.current_layout_index = (cache.current_layout_index % #layouts) + scroll_direction
	cache.last_layout_index = switch_tmep

	awful.spawn.with_shell("setxkbmap " .. layouts[cache.current_layout_index])
end

return M

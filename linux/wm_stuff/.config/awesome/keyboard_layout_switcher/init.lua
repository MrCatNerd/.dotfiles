local M = {}

local awful = require("awful")

local cache = { -- why tf lua is 1 based indexed
	current_layout_index = 1,
	last_layout_index = 2,
}

local layouts = { "dvorak", "il", "us" }

function M.switch_layouts() -- switch through current and last layout thingy
	cache.current_layout_index, cache.last_layout_index = cache.last_layout_index, cache.current_layout_index

	awful.spawn.with_shell("setxkbmap " .. layouts[cache.current_layout_index])
end

function M.scroll_layouts(scroll_direction)
	scroll_direction = scroll_direction or 1

	if scroll_direction < 0 then
		scroll_direction = -1
	else
		scroll_direction = 1
	end

	cache.last_layout_index = cache.current_layout_index
	cache.current_layout_index = (cache.current_layout_index + scroll_direction - 1) % #layouts + 1
	awful.spawn.with_shell("setxkbmap " .. layouts[cache.current_layout_index])
end

return M

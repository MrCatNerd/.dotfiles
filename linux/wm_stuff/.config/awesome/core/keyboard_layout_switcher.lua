-- pain

local M = {}

local awful = require("awful")

local data = { -- why tf lua is 1 based indexed
	current_layout_index = 1,
	last_layout_index = 2,
}

local layouts = { "dvorak", "il", "us" }

local function switch_layout(layout)
	awful.spawn.with_shell("setxkbmap " .. layout)
end

function M.switch_layouts() -- switch through current and last layout thingy
	data.current_layout_index, data.last_layout_index = data.last_layout_index, data.current_layout_index
	switch_layout(layouts[data.current_layout_index])
end

function M.scroll_layouts(scroll_direction)
	scroll_direction = scroll_direction or 1

	if scroll_direction < 0 then
		scroll_direction = -1
	else
		scroll_direction = 1
	end

	data.current_layout_index = (data.current_layout_index + scroll_direction - 1) % #layouts + 1
	switch_layout(layouts[data.current_layout_index])
end

return M

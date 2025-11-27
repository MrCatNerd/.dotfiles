-- startup
require("core.startup")

-- Libs and stuff

-- Standard awesome library
local gears = require("gears")
local awful = require("awful")
require("awful.autofocus")
-- Widget and layout library
local wibox = require("wibox")
-- Theme handling library
local beautiful = require("beautiful")
-- Notification library
local naughty = require("naughty")
local menubar = require("menubar")
local hotkeys_popup = require("awful.hotkeys_popup")

-- Load Debian menu entries
local debian = require("debian.menu")
local has_fdo, freedesktop = pcall(require, "freedesktop")

-- dpi function thingy
local dpi = require("beautiful.xresources").apply_dpi

-- {{{ Error handling
-- Check if awesome encountered an error during startup and fell back to
-- another config (This code will only ever execute for the fallback config)
if awesome.startup_errors then
	naughty.notify({
		preset = naughty.config.presets.critical,
		title = "Oops, there were errors during startup! (ya basically doomed)",
		text = awesome.startup_errors,
	})
end

-- Handle runtime errors after startup
do
	local in_error = false
	awesome.connect_signal("debug::error", function(err)
		-- Make sure we don't go into an endless error loop
		if in_error then
			return
		end
		in_error = true

		naughty.notify({
			preset = naughty.config.presets.critical,
			title = "Oops, an error happened!",
			text = tostring(err),
		})
		in_error = false
	end)
end
-- }}}

-- load basic stuff
require("core")

-- set my screens to the correct layout (before doing any screen stuff)
awful.spawn.with_shell("source $HOME/.screenlayout/homelayout.sh")

-- {{{ Menu
-- Create a launcher widget and a main menu
myawesomemenu = {
	{
		"hotkeys",
		function()
			hotkeys_popup.show_help(nil, awful.screen.focused())
		end,
	},
	{ "manual", terminal .. " -e man awesome" },
	{ "edit config", editor_cmd .. " " .. awesome.conffile },
	{ "restart", awesome.restart },
	{
		"quit",
		function()
			awesome.quit()
		end,
	},
}

local menu_awesome = { "awesome", myawesomemenu, beautiful.awesome_icon }
local menu_terminal = { "open terminal", terminal }

if has_fdo then
	mymainmenu = freedesktop.menu.build({
		before = { menu_awesome },
		after = { menu_terminal },
	})
else
	mymainmenu = awful.menu({
		items = {
			menu_awesome,
			{ "Debian", debian.menu.Debian_menu.Debian },
			menu_terminal,
		},
	})
end

mylauncher = awful.widget.launcher({ image = beautiful.awesome_icon, menu = mymainmenu })

-- Menubar configuration
menubar.utils.terminal = terminal -- Set the terminal for applications that require it
-- }}}

-- Keyboard map indicator and switcher
mykeyboardlayout = awful.widget.keyboardlayout()

-- {{{ Wibar
-- Create a textclock widget
mytextclock = wibox.widget.textclock()

-- Create a wibox for each screen and add it
local taglist_buttons = gears.table.join(
	awful.button({}, 1, function(t)
		t:view_only()
	end),
	awful.button({ modkey }, 1, function(t)
		if client.focus then
			client.focus:move_to_tag(t)
		end
	end),
	awful.button({}, 3, awful.tag.viewtoggle),
	awful.button({ modkey }, 3, function(t)
		if client.focus then
			client.focus:toggle_tag(t)
		end
	end),
	awful.button({}, 4, function(t)
		awful.tag.viewnext(t.screen)
	end),
	awful.button({}, 5, function(t)
		awful.tag.viewprev(t.screen)
	end)
)

local tasklist_buttons = gears.table.join(
	awful.button({}, 1, function(c)
		if c == client.focus then
			c.minimized = true
		else
			c:emit_signal("request::activate", "tasklist", { raise = true })
		end
	end),
	awful.button({}, 3, function()
		awful.menu.client_list({ theme = { width = 250 } })
	end),
	awful.button({}, 4, function()
		awful.client.focus.byidx(1)
	end),
	awful.button({}, 5, function()
		awful.client.focus.byidx(-1)
	end)
)
-- }}}

-- {{{ Wallpaper

local function set_wallpaper(s)
	-- Wallpaper
	if beautiful.wallpaper then
		local wallpaper = beautiful.wallpaper
		-- If wallpaper is a function, call it with the screen
		if type(wallpaper) == "function" then
			wallpaper = wallpaper(s)
		end
		-- gears.wallpaper.maximized(wallpaper, s, true)
		gears.wallpaper.maximized(wallpaper, s, false)
		-- gears.wallpaper.centered(wallpaper, s, 1)
	end
end

-- gears.timer({
-- 	timeout = 1, -- in seconds
-- 	autostart = true,
-- 	callback = function()
-- 		-- for s in screen do
-- 		-- 	-- I got no idea what to do here
-- 		-- 	-- maybe run a bash script to switch wallpapers or smh
-- 		-- end
-- 	end,
-- })

-- Re-set wallpaper when a screen's geometry changes (e.g. different resolution)
screen.connect_signal("property::geometry", set_wallpaper)

beautiful.tasklist_plain_task_name = true -- disable the extra tasklist client property notification icons

local static_vars = { -- i suck at lua lol
	-- don't worry about it this config is a mess lol
	sent_tasklist_mouse_notification = false,
	sent_mute_volume_notification = false,
	wallpaper_index = 1,
}

awful.screen.connect_for_each_screen(function(s)
	-- Wallpaper
	set_wallpaper(s)
	static_vars.wallpaper_index = static_vars.wallpaper_index + 1

	-- Each screen has its own tag table.
	-- awful.tag({ "1", "2", "3", "4", "5", "6", "7", "8", "9" }, s, awful.layout.layouts[1])
	local names = {
		"main",
		"vim",
		"gamez",
		"cats",
		"tools",
		"others",
		"misc",
	}

	local l = awful.layout.suit
	local layouts = { l.tile, l.tile, l.floating, l.floating }
	awful.tag(names, s, layouts)

	-- Create a promptbox for each screen
	s.mypromptbox = awful.widget.prompt()
	-- Create an imagebox widget which will contain an icon indicating which layout we're using.
	-- We need one layoutbox per screen.
	s.mylayoutbox = awful.widget.layoutbox(s)
	s.mylayoutbox:buttons(gears.table.join(
		awful.button({}, 1, function()
			awful.layout.inc(1)
		end),
		awful.button({}, 3, function()
			awful.layout.inc(-1)
		end),
		awful.button({}, 4, function()
			awful.layout.inc(1)
		end),
		awful.button({}, 5, function()
			awful.layout.inc(-1)
		end)
	))
	-- Create a taglist widget
	s.mytaglist = awful.widget.taglist({
		screen = s,
		filter = awful.widget.taglist.filter.all,
		buttons = taglist_buttons,
		style = {
			shape = gears.shape.circle,

			shape_border_width = 4,
			shape_border_color = beautiful.bg_muted,
			shape_border_color_focus = beautiful.bg_focus,
			shape_border_color_urgent = beautiful.bg_urgent,
			bg_focus = beautiful.bg_focus,
			bg_empty = beautiful.bg_normal,
			bg_occupied = beautiful.bg_normal,
			bg_urgent = beautiful.bg_urgent,
		},
		layout = {
			spacing = 3,

			--[[ spacing = 20,
			spacing_widget = {
				{
					color = beautiful.border_normal,
					-- forced_width = 5,
					shape = gears.shape.powerline,
					widget = wibox.widget.separator,
				},
				valign = "center",
				halign = "center",
				widget = wibox.container.place,
			}, ]]
			layout = wibox.layout.fixed.horizontal,
		},
		-- Notice that there is *NO* wibox.wibox prefix, it is a template,
		-- not a widget instance.
		widget_template = {
			{
				{
					{
						{
							id = "icon_role",
							widget = wibox.widget.imagebox,
						},
						margins = 2,
						widget = wibox.container.margin,
					},
					-- {
					-- 	id = "text_role",
					-- 	widget = wibox.widget.textbox,
					-- },
					layout = wibox.layout.fixed.horizontal,
				},
				left = 10,
				right = 10,
				widget = wibox.container.margin,
			},
			id = "background_role",
			widget = wibox.container.background,
			-- Add support for hover colors and an index label
			create_callback = function(self, c3, index, objects) --luacheck: no unused args
				local hover_color = beautiful.get().border_marked
				self:connect_signal("mouse::enter", function()
					if self.bg ~= hover_color then
						self.backup = self.bg
						self.has_backup = true
					end
					self.bg = hover_color

					if static_vars.sent_tasklist_mouse_notification then
						return
					end
					static_vars.sent_tasklist_mouse_notification = true
					naughty.notify({
						title = "Message from: Vim user",
						text = "Bro just used his mouse 💀",
						timeout = 5,
						destroy = function()
							static_vars.sent_tasklist_mouse_notification = false -- so it won't spam u every singe time
						end,
					})
				end)
				self:connect_signal("mouse::leave", function()
					if self.has_backup then
						self.bg = self.backup
					end
				end)
			end,
		},
	})

	-- Create a tasklist widget
	s.mytasklist = awful.widget.tasklist({
		screen = s,
		filter = awful.widget.tasklist.filter.currenttags,
		buttons = tasklist_buttons,
		layout = {
			layout = wibox.layout.flex.horizontal,
		},
		style = {
			font = "Hack Nerd Font 13.0",
			shape_border_width = 5,
			shape_border_color = beautiful.fg_normal,
			-- shape = gears.shape.rounded_bar,
			shape = gears.shape.circle,
			align = "center",
		},
		widget_template = {
			{
				{
					id = "clienticon",
					widget = awful.widget.clienticon,
				},
				margins = 3,
				widget = wibox.container.margin,
			},
			-- {
			-- 	{
			-- 		id = "text_role",
			-- 		widget = wibox.widget.textbox,
			-- 	},
			-- 	layout = wibox.layout.fixed.horizontal,
			-- },
			nil,
			create_callback = function(self, c, index, objects) --luacheck: no unused args
				self:get_children_by_id("clienticon")[1].client = c
			end,
			layout = wibox.layout.align.horizontal,
		},
	})

	-- THIS TOOK TOO MUCH TIME
	-- Create the wibox
	-- Create the transparent wibox with margins
	s.mywibox = awful.wibar({
		position = "top",
		margins = { bottom = dpi(25) },
		bg = "#00000000", -- Transparent background
		height = dpi(35),
		screen = s,
		opacity = 1.0,
	})

	-- Create background containers for neft, middle, and right sections
	local left_container = wibox.container.background()
	local middle_container = wibox.container.background()
	local right_container = wibox.container.background()

	-- Set background and shape properties
	local container_shape = function(cr, width, height)
		gears.shape.rounded_bar(cr, width, height)
	end

	left_container.bg = beautiful.bg_normal
	left_container.shape = container_shape

	middle_container.bg = beautiful.bg_normal
	middle_container.shape = container_shape

	right_container.bg = beautiful.bg_normal
	right_container.shape = container_shape

	-- Set up the widgets inside the background containers
	local left_widgets = wibox.widget({
		spacing = dpi(5),
		layout = wibox.layout.fixed.horizontal,
		s.mytaglist,
		s.mypromptbox,
	})

	local middle_widgets = wibox.widget({
		spacing = dpi(10),
		layout = wibox.layout.fixed.horizontal,
		s.mytasklist,
	})

	local right_widgets = wibox.widget({
		layout = wibox.layout.fixed.horizontal,
		mykeyboardlayout,
		wibox.widget.systray(),
		mytextclock,
		s.mylayoutbox,
		mylauncher,
	})

	left_container.widget = left_widgets
	middle_container.widget = middle_widgets
	right_container.widget = right_widgets

	-- Create margin containers with spacing
	local margin = dpi(5)
	local left_margin_container = wibox.container.margin(left_container, margin, margin, dpi(0), dpi(0))
	local middle_margin_container = wibox.container.margin(middle_container, margin, margin, dpi(0), dpi(0))
	local right_margin_container = wibox.container.margin(right_container, margin, margin, dpi(0), dpi(0))

	-- Set up the wibox with the background containers
	s.mywibox:setup({
		layout = wibox.layout.align.horizontal,
		left_margin_container,
		middle_margin_container,
		right_margin_container,
	})
end)
-- }}}

-- {{{ Mouse bindings
root.buttons(gears.table.join(
	awful.button({}, 3, function()
		mymainmenu:toggle()
	end),
	awful.button({}, 4, awful.tag.viewnext),
	awful.button({}, 5, awful.tag.viewprev)
))
-- }}}

-- {{{ Key bindings
globalkeys = gears.table.join(
	awful.key({ "Shift" }, "Alt_L", function() -- idk why but it doesn't work so i made my own switcher
		mykeyboardlayout.next_layout()
	end),
	awful.key({ "Mod1" }, "Shift_L", function()
		mykeyboardlayout.next_layout()
	end),

	awful.key({ "Mod4" }, "space", function()
		require("core.keyboard_layout_switcher").switch_layouts()
	end, { description = "Switch between last and current keyboard layouts" }),

	awful.key({ "Mod1" }, "space", function()
		require("core.keyboard_layout_switcher").scroll_layouts()
	end, { description = "Scroll through keyboard layouts" }),

	awful.key({ modkey }, "s", hotkeys_popup.show_help, { description = "show help", group = "awesome" }),
	awful.key({ modkey }, "Left", awful.tag.viewprev, { description = "view previous", group = "tag" }),
	awful.key({ modkey }, "Right", awful.tag.viewnext, { description = "view next", group = "tag" }),
	awful.key({ modkey }, "Escape", awful.tag.history.restore, { description = "go back", group = "tag" }),

	awful.key({ modkey }, "j", function()
		awful.client.focus.byidx(1)
	end, { description = "focus next by index", group = "client" }),
	awful.key({ modkey }, "k", function()
		awful.client.focus.byidx(-1)
	end, { description = "focus previous by index", group = "client" }),
	awful.key({ modkey }, "w", function()
		mymainmenu:show()
	end, { description = "show main menu", group = "awesome" }),

	awful.key({ modkey, "Shift" }, "s", function() -- screenshots
		awful.spawn("flameshot gui")
	end, { description = "Spawn Flameshot", group = "xx" }),

	-- Layout manipulation
	awful.key({ modkey, "Shift" }, "j", function()
		awful.client.swap.byidx(1)
	end, { description = "swap with next client by index", group = "client" }),

	awful.key({ modkey, "Shift" }, "k", function()
		awful.client.swap.byidx(-1)
	end, { description = "swap with previous client by index", group = "client" }),

	awful.key({ modkey, "Shift" }, "l", function()
		awful.screen.focus_relative(-1)
	end, { description = "focus the next screen", group = "screen" }),

	awful.key({ modkey, "Shift" }, "h", function()
		awful.screen.focus_relative(1)
	end, { description = "focus the previous screen", group = "screen" }),

	awful.key({ modkey }, "u", awful.client.urgent.jumpto, { description = "jump to urgent client", group = "client" }),

	awful.key({ modkey }, "Tab", function()
		awful.client.focus.history.previous()
		if client.focus then
			client.focus:raise()
		end
	end, { description = "go back", group = "client" }),

	-- Standard program
	awful.key({ modkey, "Control" }, "Return", function()
		awful.spawn(terminal)
	end, { description = "open a terminal", group = "launcher" }),

	awful.key({ modkey, "Control" }, "r", awesome.restart, { description = "reload awesome", group = "awesome" }),
	awful.key({ modkey, "Shift" }, "q", awesome.quit, { description = "quit awesome", group = "awesome" }),

	awful.key({ modkey }, "l", function()
		awful.tag.incmwfact(0.05)
	end, { description = "increase master width factor", group = "layout" }),

	awful.key({ modkey }, "h", function()
		awful.tag.incmwfact(-0.05)
	end, { description = "decrease master width factor", group = "layout" }),

	awful.key({ modkey, "Shift" }, "h", function()
		awful.tag.incnmaster(1, nil, true)
	end, { description = "increase the number of master clients", group = "layout" }),

	awful.key({ modkey, "Shift" }, "l", function()
		awful.tag.incnmaster(-1, nil, true)
	end, { description = "decrease the number of master clients", group = "layout" }),

	awful.key({ modkey, "Control" }, "h", function()
		awful.tag.incncol(1, nil, true)
	end, { description = "increase the number of columns", group = "layout" }),

	awful.key({ modkey, "Control" }, "l", function()
		awful.tag.incncol(-1, nil, true)
	end, { description = "decrease the number of columns", group = "layout" }),

	awful.key({ modkey }, "i", function()
		awful.layout.inc(1)
	end, { description = "select next", group = "layout" }),

	awful.key({ modkey, "Shift" }, "i", function()
		awful.layout.inc(-1)
	end, { description = "select previous", group = "layout" }),

	awful.key({ modkey, "Control" }, "n", function()
		local c = awful.client.restore()
		-- Focus restored client
		if c then
			c:emit_signal("request::activate", "key.unminimize", { raise = true })
		end
	end, { description = "restore minimized", group = "client" }),

	-- TODO: KeyBoard Volume control (https://github.com/streetturtle/awesome-wm-widgets/tree/master/volume-widget)
	--  - volume up
	--  volume down
	-- awful.key({}, "", function()
	-- 	volume_widget:inc(5)
	-- end, { description = "change volume (SteelSeries apex3 keyboard remap)", group = "volume" }),
	-- awful.key({}, "", function()
	-- 	volume_widget:dec(5)
	-- end, { description = "change volume (SteelSeries apex3 keyboard remap)", group = "volume" }),
	-- awful.key({ modkey }, "\\", function()
	-- 	volume_widget:toggle()
	-- end, { description = "change volume (SteelSeries apex3 keyboard remap)", group = "volume" }),

	-- Volume Up
	-- WARNING: I am using frontright because my sound balancing is forked up lol (and the realtek drivers are outdated AF)
	awful.key({}, "XF86AudioRaiseVolume", function()
		awful.spawn("amixer set Master 1%+")
		-- naughty.notify({ text = "Volume Up" })
	end, { description = "increase volume", group = "media" }),

	-- Volume Down
	awful.key({}, "XF86AudioLowerVolume", function()
		awful.spawn("amixer set Master 1%-")
		-- naughty.notify({ text = "Volume Down" })
	end, { description = "decrease volume", group = "media" }),

	-- Volume Mute
	awful.key({}, "XF86AudioMute", function()
		awful.spawn("amixer set Master toggle")
		if not static_vars.sent_mute_volume_notification then
			naughty.notify({
				text = "Mute Toggle",
				timeout = 1,
				destroy = function()
					static_vars.sent_tasklist_mouse_notification = false -- so it won't spam u every singe time
				end,
			})
		end
	end, { description = "mute volume", group = "media" }),

	-- Media Play/Pause
	awful.key({}, "XF86AudioPlay", function()
		awful.spawn("playerctl play-pause")
		naughty.notify({ text = "Play/Pause" })
	end, { description = "play/pause media", group = "media" }),

	-- Prompt
	-- Uses rofi
	-- awful.key({ modkey }, "r", function()
	--	 awful.screen.focused().mypromptbox:run()
	-- end, { description = "run prompt", group = "launcher" }),
	awful.key({ modkey }, "r", function()
		awful.spawn("rofi -show drun")
	end, { description = "run prompt", group = "launcher" }),

	awful.key({ modkey }, "x", function()
		awful.prompt.run({
			prompt = "Run Lua code: ",
			textbox = awful.screen.focused().mypromptbox.widget,
			exe_callback = awful.util.eval,
			history_path = awful.util.get_cache_dir() .. "/history_eval",
		})
	end, { description = "lua execute prompt", group = "awesome" }),
	-- Menubar
	awful.key({ modkey }, "p", function()
		menubar.show()
	end, { description = "show the menubar", group = "launcher" })
)

clientkeys = gears.table.join(
	awful.key({ modkey }, "f", function(c)
		c.fullscreen = not c.fullscreen
		c:raise()
	end, { description = "toggle fullscreen", group = "client" }),
	awful.key({ modkey, "Shift" }, "c", function(c)
		c:kill()
	end, { description = "close", group = "client" }),
	awful.key(
		{ modkey, "Control" },
		"space",
		awful.client.floating.toggle,
		{ description = "toggle floating", group = "client" }
	),
	awful.key({ modkey, "Control" }, "Return", function(c)
		c:swap(awful.client.getmaster())
	end, { description = "move to master", group = "client" }),
	awful.key({ modkey }, "o", function(c)
		c:move_to_screen()
	end, { description = "move to screen", group = "client" }),
	awful.key({ modkey }, "t", function(c)
		c.ontop = not c.ontop
	end, { description = "toggle keep on top", group = "client" }),
	awful.key({ modkey }, "n", function(c)
		-- The client currently has the input focus, so it cannot be
		-- minimized, since minimized clients can't have the focus.
		c.minimized = true
	end, { description = "minimize", group = "client" }),
	awful.key({ modkey }, "m", function(c)
		c.maximized = not c.maximized
		c:raise()
	end, { description = "(un)maximize", group = "client" }),
	awful.key({ modkey, "Control" }, "m", function(c)
		c.maximized_vertical = not c.maximized_vertical
		c:raise()
	end, { description = "(un)maximize vertically", group = "client" }),
	awful.key({ modkey, "Shift" }, "m", function(c)
		c.maximized_horizontal = not c.maximized_horizontal
		c:raise()
	end, { description = "(un)maximize horizontally", group = "client" })
)

-- Bind all key numbers to tags.
-- Be careful: we use keycodes to make it work on any keyboard layout.
-- This should map on the top row of your keyboard, usually 1 to 9.
for i = 1, 9 do
	globalkeys = gears.table.join(
		globalkeys,
		-- View tag only.
		awful.key({ modkey }, "#" .. i + 9, function()
			local screen = awful.screen.focused()
			local tag = screen.tags[i]
			if tag then
				tag:view_only()
			end
		end, { description = "view tag #" .. i, group = "tag" }),
		-- Toggle tag display.
		awful.key({ modkey, "Control" }, "#" .. i + 9, function()
			local screen = awful.screen.focused()
			local tag = screen.tags[i]
			if tag then
				awful.tag.viewtoggle(tag)
			end
		end, { description = "toggle tag #" .. i, group = "tag" }),
		-- Move client to tag.
		awful.key({ modkey, "Shift" }, "#" .. i + 9, function()
			if client.focus then
				local tag = client.focus.screen.tags[i]
				if tag then
					client.focus:move_to_tag(tag)
				end
			end
		end, { description = "move focused client to tag #" .. i, group = "tag" }),
		-- Toggle tag on focused client.
		awful.key({ modkey, "Control", "Shift" }, "#" .. i + 9, function()
			if client.focus then
				local tag = client.focus.screen.tags[i]
				if tag then
					client.focus:toggle_tag(tag)
				end
			end
		end, { description = "toggle focused client on tag #" .. i, group = "tag" })
	)
end

clientbuttons = gears.table.join(
	awful.button({}, 1, function(c)
		c:emit_signal("request::activate", "mouse_click", { raise = true })
	end),
	awful.button({ modkey }, 1, function(c)
		c:emit_signal("request::activate", "mouse_click", { raise = true })
		awful.mouse.client.move(c)
	end),
	awful.button({ modkey }, 3, function(c)
		c:emit_signal("request::activate", "mouse_click", { raise = true })
		awful.mouse.client.resize(c)
	end)
)

-- Set keys
root.keys(globalkeys)
-- }}}

-- {{{ Rules
-- Rules to apply to new clients (through the "manage" signal).
awful.rules.rules = {
	-- All clients will match this rule.
	{
		rule = {},
		properties = {
			border_width = beautiful.border_width,
			border_color = beautiful.border_normal,
			focus = awful.client.focus.filter,
			raise = true,
			keys = clientkeys,
			buttons = clientbuttons,
			screen = awful.screen.preferred,
			placement = awful.placement.no_overlap + awful.placement.no_offscreen,
		},
	},

	-- Floating clients.
	{
		rule_any = {
			instance = {
				"DTA", -- Firefox addon DownThemAll.
				"copyq", -- Includes session name in class.
				"pinentry",
			},
			class = {
				"Arandr",
				"Blueman-manager",
				"Gpick",
				"Kruler",
				"MessageWin", -- kalarm.
				"Sxiv",
				"Tor Browser", -- Needs a fixed window size to avoid fingerprinting by screen size.
				"Wpa_gui",
				"veromix",
				"xtightvncviewer",
			},

			-- Note that the name property shown in xprop might be set slightly after creation of the client
			-- and the name shown there might not match defined rules here.
			name = {
				"Event Tester", -- xev.
			},
			role = {
				"AlarmWindow", -- Thunderbird's calendar.
				"ConfigManager", -- Thunderbird's about:config.
				"pop-up", -- e.g. Google Chrome's (detached) Developer Tools.
			},
		},
		properties = { floating = true },
	},

	-- Add titlebars to normal clients and dialogs
	{ rule_any = { type = { "normal", "dialog" } }, properties = { titlebars_enabled = true } },

	-- Set Firefox to always map on the tag named "2" on screen 1.
	-- { rule = { class = "Firefox" },
	--   properties = { screen = 1, tag = "2" } },
}
-- }}}

-- {{{ Signals
-- Signal function to execute when a new client appears.
client.connect_signal("manage", function(c)
	-- Set the windows at the slave,
	-- i.e. put it at the end of others instead of setting it master.
	-- if not awesome.startup then awful.client.setslave(c) end

	if awesome.startup and not c.size_hints.user_position and not c.size_hints.program_position then
		-- Prevent clients from being unreachable after screen count changes.
		awful.placement.no_offscreen(c)
	end
end)

-- Add a titlebar if titlebars_enabled is set to true in the rules.
client.connect_signal("request::titlebars", function(c)
	-- buttons for the titlebar
	local buttons = gears.table.join(
		awful.button({}, 1, function()
			c:emit_signal("request::activate", "titlebar", { raise = true })
			awful.mouse.client.move(c)
		end),
		awful.button({}, 3, function()
			c:emit_signal("request::activate", "titlebar", { raise = true })
			awful.mouse.client.resize(c)
		end)
	)

	awful.titlebar(c):setup({
		{ -- Left
			awful.titlebar.widget.iconwidget(c),
			buttons = buttons,
			layout = wibox.layout.fixed.horizontal,
		},
		{ -- Middle
			{ -- Title
				align = "center",
				widget = awful.titlebar.widget.titlewidget(c),
			},
			buttons = buttons,
			layout = wibox.layout.flex.horizontal,
		},
		{ -- Right
			awful.titlebar.widget.maximizedbutton(c),
			awful.titlebar.widget.floatingbutton(c),
			awful.titlebar.widget.stickybutton(c),
			awful.titlebar.widget.ontopbutton(c),
			awful.titlebar.widget.closebutton(c),
			layout = wibox.layout.fixed.horizontal(),
		},
		layout = wibox.layout.align.horizontal,
	})
end)

-- Enable sloppy focus, so that focus follows mouse.
client.connect_signal("mouse::enter", function(c)
	c:emit_signal("request::activate", "mouse_enter", { raise = false })
end)

client.connect_signal("focus", function(c)
	c.border_color = beautiful.border_focus
end)

client.connect_signal("unfocus", function(c)
	c.border_color = beautiful.border_normal
end)
-- }}}

-- Set gaps
beautiful.useless_gaps = 30
beautiful.gap_single_client = true

-- Autostart Application
-- awful.spawn.with_shell("$HOME/.config/awesome/autostart.sh")
awful.spawn.with_shell("setxkbmap dvorak") -- dvorak btw
-- awful.spawn.with_shell("picom --experimental-backends -b --config=$HOME/.config/picom/picom.ini") -- picom
awful.spawn.with_shell("picom -b --config=$HOME/.config/picom/picom.ini") -- picom git
awful.spawn.once("otd-daemon")
-- awful.spawn.with_shell("pgrep -x caffeine-indica || caffeine-indicator") -- idk why caffeine-indica is caffeine-indicator
-- awful.spawn.once("xss-lock --transfer-sleep-lock -- screenlock_customized --nofork")
-- awful.spawn.once("sudo kanata -c ~/.config/kanata/kanata.kbd")

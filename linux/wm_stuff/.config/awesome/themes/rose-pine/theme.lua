-------------------------------
--  Rose Pine awesome theme  --
--  Made By MrCatNerd         --
-------------------------------
--
-- RIP 30 minutes of my life :(

local themes_path = require("gears.filesystem").get_themes_dir()
local dpi = require("beautiful.xresources").apply_dpi

local base = "#191724"
local surface = "#1f1d2e"
local overlay = "#26233a"
local muted = "#6e6a86"
local subtle = "#908caa"
local text = "#e0def4"
local love = "#eb6f92"
local gold = "#f6c177"
local rose = "#ebbcba"
local pine = "#31748f"
local foam = "#9ccfd8"
local iris = "#c4a7e7"
local highlightlow = "#21202e"
local highlightmed = "#403d52"
local highlighthigh = "#524f67"

-- {{{ Main
local theme = {}
-- theme.wallpaper = themes_path .. "zenburn/zenburn-background.png"
theme.wallpaper = require("gears").surface.load_uncached(
	require("gears").surface.load_uncached(string.format("%s/Pictures/Wallpapers/%s", os.getenv("HOME"), "ground.png"))
)
theme.hotkeys_modifiers_fg = "#FFFFFF"
-- }}}

-- {{{ Styles
theme.font = "Hack Nerd Font 10"

-- {{{ Colors
theme.fg_focus = text
theme.fg_normal = text
theme.fg_urgent = text

theme.bg_focus = pine
theme.bg_normal = base
theme.bg_urgent = iris

theme.bg_systray = theme.bg_normal
-- }}}

-- {{{ Borders
theme.useless_gap = dpi(5)
theme.border_width = dpi(2)
theme.border_normal = muted
theme.border_focus = rose
theme.border_marked = love
-- }}}

-- {{{ Titlebars
theme.titlebar_bg_focus = surface
theme.titlebar_bg_normal = surface
-- }}}

-- There are other variable sets
-- overriding the default one when
-- defined, the sets are:
-- [taglist|tasklist]_[bg|fg]_[focus|urgent|occupied|empty|volatile]
-- titlebar_[normal|focus]
-- tooltip_[font|opacity|fg_color|bg_color|border_width|border_color]
-- Example:
--theme.taglist_bg_focus = "#CC9393"
-- }}}

-- {{{ Widgets
-- You can add as many variables as
-- you wish and access them by using
-- beautiful.variable in your rc.lua
--theme.fg_widget        = "#AECF96"
--theme.fg_center_widget = "#88A175"
--theme.fg_end_widget    = "#FF5656"
--theme.bg_widget        = "#494B4F"
--theme.border_widget    = "#3F3F3F"
-- }}}

-- {{{ Mouse finder
theme.mouse_finder_color = rose
-- mouse_finder_[timeout|animate_timeout|radius|factor]
-- }}}

-- {{{ Icons
-- {{{ Taglist
theme.taglist_squares_sel = themes_path .. "zenburn/taglist/squarefz.png"
theme.taglist_squares_unsel = themes_path .. "zenburn/taglist/squarez.png"
--theme.taglist_squares_resize = "false"
-- }}}

-- {{{ Misc
theme.awesome_icon = themes_path .. "zenburn/awesome-icon.png"
theme.menu_submenu_icon = themes_path .. "default/submenu.png"
-- }}}

theme.taglist_fg_focus = rose
theme.tasklist_bg_focus = base
theme.tasklist_fg_focus = rose
theme.textbox_widget_as_label_font_color = subtle
theme.textbox_widget_margin_top = 1
theme.text_font_color_1 = foam
theme.text_font_color_2 = rose
theme.text_font_color_3 = subtle
theme.notify_font_color_1 = foam
theme.notify_font_color_2 = pine
theme.notify_font_color_3 = surface
theme.notify_font_color_4 = subtle
theme.notify_font = "Monaco 7"
theme.notify_fg = theme.fg_normal
theme.notify_bg = theme.bg_normal
theme.notify_border = theme.border_focus
theme.awful_widget_bckgrd_color = overlay
theme.awful_widget_border_color = overlay
theme.awful_widget_color = foam
theme.awful_widget_gradien_color_1 = iris
theme.awful_widget_gradien_color_2 = iris
theme.awful_widget_gradien_color_3 = iris
theme.awful_widget_height = 14
theme.awful_widget_margin_top = 2
-- }}}

-- {{{ Layout
theme.layout_tile = themes_path .. "zenburn/layouts/tile.png"
theme.layout_tileleft = themes_path .. "zenburn/layouts/tileleft.png"
theme.layout_tilebottom = themes_path .. "zenburn/layouts/tilebottom.png"
theme.layout_tiletop = themes_path .. "zenburn/layouts/tiletop.png"
theme.layout_fairv = themes_path .. "zenburn/layouts/fairv.png"
theme.layout_fairh = themes_path .. "zenburn/layouts/fairh.png"
theme.layout_spiral = themes_path .. "zenburn/layouts/spiral.png"
theme.layout_dwindle = themes_path .. "zenburn/layouts/dwindle.png"
theme.layout_max = themes_path .. "zenburn/layouts/max.png"
theme.layout_fullscreen = themes_path .. "zenburn/layouts/fullscreen.png"
theme.layout_magnifier = themes_path .. "zenburn/layouts/magnifier.png"
theme.layout_floating = themes_path .. "zenburn/layouts/floating.png"
theme.layout_cornernw = themes_path .. "zenburn/layouts/cornernw.png"
theme.layout_cornerne = themes_path .. "zenburn/layouts/cornerne.png"
theme.layout_cornersw = themes_path .. "zenburn/layouts/cornersw.png"
theme.layout_cornerse = themes_path .. "zenburn/layouts/cornerse.png"
-- }}}

-- {{{ Titlebar
theme.titlebar_close_button_focus = themes_path .. "zenburn/titlebar/close_focus.png"
theme.titlebar_close_button_normal = themes_path .. "zenburn/titlebar/close_normal.png"

theme.titlebar_minimize_button_normal = themes_path .. "default/titlebar/minimize_normal.png"
theme.titlebar_minimize_button_focus = themes_path .. "default/titlebar/minimize_focus.png"

theme.titlebar_ontop_button_focus_active = themes_path .. "zenburn/titlebar/ontop_focus_active.png"
theme.titlebar_ontop_button_normal_active = themes_path .. "zenburn/titlebar/ontop_normal_active.png"
theme.titlebar_ontop_button_focus_inactive = themes_path .. "zenburn/titlebar/ontop_focus_inactive.png"
theme.titlebar_ontop_button_normal_inactive = themes_path .. "zenburn/titlebar/ontop_normal_inactive.png"

theme.titlebar_sticky_button_focus_active = themes_path .. "zenburn/titlebar/sticky_focus_active.png"
theme.titlebar_sticky_button_normal_active = themes_path .. "zenburn/titlebar/sticky_normal_active.png"
theme.titlebar_sticky_button_focus_inactive = themes_path .. "zenburn/titlebar/sticky_focus_inactive.png"
theme.titlebar_sticky_button_normal_inactive = themes_path .. "zenburn/titlebar/sticky_normal_inactive.png"

theme.titlebar_floating_button_focus_active = themes_path .. "zenburn/titlebar/floating_focus_active.png"
theme.titlebar_floating_button_normal_active = themes_path .. "zenburn/titlebar/floating_normal_active.png"
theme.titlebar_floating_button_focus_inactive = themes_path .. "zenburn/titlebar/floating_focus_inactive.png"
theme.titlebar_floating_button_normal_inactive = themes_path .. "zenburn/titlebar/floating_normal_inactive.png"

theme.titlebar_maximized_button_focus_active = themes_path .. "zenburn/titlebar/maximized_focus_active.png"
theme.titlebar_maximized_button_normal_active = themes_path .. "zenburn/titlebar/maximized_normal_active.png"
theme.titlebar_maximized_button_focus_inactive = themes_path .. "zenburn/titlebar/maximized_focus_inactive.png"
theme.titlebar_maximized_button_normal_inactive = themes_path .. "zenburn/titlebar/maximized_normal_inactive.png"
-- }}}
-- }}}

return theme

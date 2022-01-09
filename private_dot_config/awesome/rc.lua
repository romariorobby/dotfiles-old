-- If LuaRocks is installed, make sure that packages installed through it are
-- found (e.g. lgi). If LuaRocks is not installed, do nothing.
pcall(require, "luarocks.loader")
local root = root
-- Widget
local battery = require("widgets.battery-widget.battery")
local packages = require("widgets.apt-widget.apt-widget")
local volume = require("widgets.volume-widget.volume")

-- Standard awesome library
local config = require('config')
local gears = require("gears")
local awful = require("awful")
							require("awful.autofocus")
local titlebar = awful.titlebar
local gfs = gears.filesystem
-- local button = awful.button
local wibox = require("wibox") -- Widget and layout library
local beautiful = require("beautiful") -- Theme handling library
-- Notification library
local naughty = require("naughty")
local menubar = require("menubar")

-- Enable hotkeys help widget for VIM and other apps
-- when client with a matching name is opened:
local hotkeys_popup = require("awful.hotkeys_popup")
											require("awful.hotkeys_popup.keys")

-- {{{ Error handling
-- Check if awesome encountered an error during startup and fell back to
-- another config (This code will only ever execute for the fallback config)
if awesome.startup_errors then
	naughty.notify({
		preset = naughty.config.presets.critical,
		title = "Oops, there were errors during startup!",
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

-- This is used later as the default terminal and editor to run.
local terminal = config.term
local browser = config.browser
local editor = os.getenv("EDITOR") or config.editor or "nvim"
local editor_cmd = terminal .. " -e " .. editor
local modkey = config.modkey
local theme_name = config.theme
local config_path = gfs.get_xdg_config_home() .. "awesome/"
local themes_path = config_path .. "themes/"
local sel_themes_dir = themes_path .. theme_name .. "/theme.lua"


-- {{{ Variable definitions
-- Themes define colours, icons, font and wallpapers.
beautiful.init(sel_themes_dir)

-- gap
beautiful.useless_gap = config.gap

-- WIP:
local toggle_useless_gaps = function()
    local selected_tag = awful.screen.focused().selected_tag

    if selected_tag.gap ~= 40 then
        selected_tag.gap = 40
    else
        selected_tag.gap = 2
    end

    awful.screen.connect_for_each_screen(function(s) awful.layout.arrange(s) end)
end

local remove_useless_gaps = function()
    awful.screen.focused().selected_tag.gap = config.gap
    awful.screen.connect_for_each_screen(function(s) awful.layout.arrange(s) end)
end

local useless_gap_decrease = function()
    local selected_tag = awful.screen.focused().selected_tag

    if selected_tag.gap > 2 then
        selected_tag.gap = selected_tag.gap - 2
        awful.screen.connect_for_each_screen(function(s) awful.layout.arrange(s) end)
    end
end

local useless_gap_increase = function()
    local selected_tag = awful.screen.focused().selected_tag

    selected_tag.gap = selected_tag.gap + 2
    awful.screen.connect_for_each_screen(function(s) awful.layout.arrange(s) end)
end

-- Table of layouts to cover with awful.layout.inc, order matters.
awful.layout.layouts = {
	awful.layout.suit.tile,
	awful.layout.suit.floating,
	awful.layout.suit.max,
	awful.layout.suit.spiral,
	-- awful.layout.suit.spiral.dwindle,
	-- awful.layout.suit.tile.left,
	-- awful.layout.suit.tile.bottom,
	-- awful.layout.suit.tile.top,
	-- awful.layout.suit.fair,
	-- awful.layout.suit.fair.horizontal,
	-- awful.layout.suit.max.fullscreen,
	-- awful.layout.suit.magnifier,
	-- awful.layout.suit.corner.nw,
	-- awful.layout.suit.corner.ne,
	-- awful.layout.suit.corner.sw,
	-- awful.layout.suit.corner.se,
}
-- }}}

-- {{{ Menu
-- Create a launcher widget and a main menu
local sub_menu1 = {
	{ "keymaps", function() hotkeys_popup.show_help(nil, awful.screen.focused()) end, },
	{ "edit config", editor_cmd .. " " .. awesome.conffile },
	{ "help", terminal .. " -e man awesome" },
	{ "quit", function() awesome.quit() end, },
}

local menus = awful.menu({
	items = {
		{ "awesome", sub_menu1, beautiful.awesome_icon },
		{ "terminal", terminal },
		{ "keymaps", function() hotkeys_popup.show_help(nil, awful.screen.focused()) end, },
		{ "restart", awesome.restart },
	},
})

local launcher = awful.widget.launcher({ image = beautiful.awesome_icon, menu = menus })

-- Menubar configuration
menubar.utils.terminal = terminal -- Set the terminal for applications that require it
-- }}}

-- {{{ Wibar

local keyboardlayout = awful.widget.keyboardlayout() -- Keyboard map indicator and switcher
local clock = wibox.widget.textclock() -- Create a textclock widget


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
local function widgetbar()
	if config.widgets.battery then
	return battery({
			path_to_icons = "/usr/share/icons/WhiteSur-dark/status/symbolic/",
			show_current_level = true,
			margin_right = 5,
			font =  "Siji"
		})
	end
end

local function set_wallpaper(s)
	-- Wallpaper
	if beautiful.wallpaper then
		local wallpaper = beautiful.wallpaper
		-- If wallpaper is a function, call it with the screen
		if type(wallpaper) == "function" then
			wallpaper = wallpaper(s)
		end
		gears.wallpaper.maximized(wallpaper, s, true)
	end
end

-- Re-set wallpaper when a screen's geometry changes (e.g. different resolution)
screen.connect_signal("property::geometry", set_wallpaper)

awful.screen.connect_for_each_screen(function(s)
	-- Wallpaper
	set_wallpaper(s)

	local num_tag = { "1", "2", "3", "4", "5", "6", "7", "8", "9" }
	-- Each screen has its own tag table.
	awful.tag(num_tag, s, awful.layout.layouts[1])

	-- Create a promptbox for each screen
	s.promptbox = awful.widget.prompt()
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
	})

	-- Create a tasklist widget
	s.mytasklist = awful.widget.tasklist({
		screen = s,
		filter = awful.widget.tasklist.filter.currenttags,
		buttons = tasklist_buttons,
	})
	-- Create the wibox
	s.wibox = awful.wibar({
		position = "top",
		screen = s,
		height = 20,
	})

	-- Add widgets to the wibox
	s.wibox:setup({
		layout = wibox.layout.align.horizontal,
		{ -- Left widgets
			layout = wibox.layout.fixed.horizontal,
			launcher,
			s.mytaglist,
			s.promptbox,
			s.mylayoutbox,
		},
		s.mytasklist, -- Middle widget
		{ -- Right widgets
			layout = wibox.layout.fixed.horizontal,
			wibox.widget.systray(),
			battery({
				path_to_icons = "/usr/share/icons/WhiteSur-dark/status/symbolic/",
				show_current_level = true,
				margin_right = 5,
				font =  "JetBrainsMono Nerd Font"
			}),
			-- packages(),
			-- volume({ widget_type = "vertical_bar", mixer_cmd = "pulsemixer", -- icon_dir = "/usr/share/icons/WhiteSur-dark/status/symbolic/" }),
			keyboardlayout,
			clock,
		},
	})
end)
-- }}}

-- {{{ Mouse bindings
root.buttons(gears.table.join(
	awful.button({}, 3, function()
		menus:toggle()
	end),
	awful.button({}, 4, awful.tag.viewnext),
	awful.button({}, 5, awful.tag.viewprev)
))
-- }}}

-- {{{ Key bindings
local map = awful.key
local globalkeys = gears.table.join(
	map({ modkey }, "g", toggle_useless_gaps, { description = "Toggle gaps", group = "client" }),
	map({ modkey }, ".", useless_gap_decrease, { description = "Decrease gaps", group = "layout" }),
	map({ modkey }, ",", useless_gap_increase, { description = "Increase gaps", group = "layout" }),
	map({ modkey , "Shift"}, "g", remove_useless_gaps, { description = "Toggle gaps", group = "client" }),
	map({ modkey}, "Backspace", function() naughty.destroy_all_notifications() end, {description = "destroy all notifications", group = "hotkeys"}),
	awful.key({ modkey }, "b",
		function ()
			local screen = awful.screen.focused()
			screen.wibox.visible = not screen.wibox.visible
		end),
	map({ modkey }, "F1", hotkeys_popup.show_help, { description = "show help", group = "awesome" }),
	map({ modkey , "Shift"}, "/", hotkeys_popup.show_help, { description = "show help", group = "awesome" }),
	map({ modkey }, "Left", awful.tag.viewprev, { description = "view previous", group = "tag" }),
	map({ modkey }, "Right", awful.tag.viewnext, { description = "view next", group = "tag" }),
	map({ modkey }, "Escape", awful.tag.history.restore, { description = "go back", group = "tag" }),

	map({ modkey }, "j", function()
		awful.client.focus.byidx(1)
	end, { description = "focus next by index", group = "client" }),
	map({ modkey }, "k", function()
		awful.client.focus.byidx(-1)
	end, { description = "focus previous by index", group = "client" }),
	map({ modkey }, "w", function()
		menus:show()
	end, { description = "show main menu", group = "awesome" }),

	-- Layout manipulation
	map({ modkey, "Shift" }, "j", function()
		awful.client.swap.byidx(1)
	end, { description = "swap with next client by index", group = "client" }),
	map({ modkey, "Shift" }, "k", function()
		awful.client.swap.byidx(-1)
	end, { description = "swap with previous client by index", group = "client" }),
	map({ modkey }, "space", function()
		awful.client.swap.byidx(1)
	end, { description = "swap windows", group = "client" }),
	map({ modkey, "Control" }, "j", function()
		awful.screen.focus_relative(1)
	end, { description = "focus the next screen", group = "screen" }),
	map({ modkey, "Control" }, "k", function()
		awful.screen.focus_relative(-1)
	end, { description = "focus the previous screen", group = "screen" }),
	map({ modkey }, "u", awful.client.urgent.jumpto, { description = "jump to urgent client", group = "client" }),
	map({ modkey }, "Tab", function()
		awful.client.focus.history.previous()
		if client.focus then
			client.focus:raise()
		end
	end, { description = "go back", group = "client" }),

	-- Standard program
	map({ modkey }, "Return", function()
		awful.spawn(terminal)
	end, { description = "open a terminal", group = "launcher" }),
	map({ modkey }, "Escape", awesome.restart, { description = "reload awesome", group = "awesome" }),
	map({ modkey, "Shift" }, "Escape", awesome.quit, { description = "quit awesome", group = "awesome" }),

	map({ modkey }, "l", function()
		awful.tag.incmwfact(0.05)
	end, { description = "increase master width factor", group = "layout" }),
	map({ modkey }, "h", function()
		awful.tag.incmwfact(-0.05)
	end, { description = "decrease master width factor", group = "layout" }),
	map({ modkey, "Shift" }, "h", function()
		awful.tag.incnmaster(1, nil, true)
	end, { description = "increase the number of master clients", group = "layout" }),
	map({ modkey, "Shift" }, "l", function()
		awful.tag.incnmaster(-1, nil, true)
	end, { description = "decrease the number of master clients", group = "layout" }),
	map({ modkey, "Control" }, "h", function()
		awful.tag.incncol(1, nil, true)
	end, { description = "increase the number of columns", group = "layout" }),
	map({ modkey, "Control" }, "l", function()
		awful.tag.incncol(-1, nil, true)
	end, { description = "decrease the number of columns", group = "layout" }),
	map({ modkey }, "]", function()
		awful.layout.inc(1)
	end, { description = "select next", group = "layout" }),
	map({ modkey}, "[", function()
		awful.layout.inc(-1)
	end, { description = "select previous", group = "layout" }),

	map({ modkey, "Control" }, "n", function()
		local c = awful.client.restore()
		-- Focus restored client
		if c then
			c:emit_signal("request::activate", "key.unminimize", { raise = true })
		end
	end, { description = "restore minimized", group = "client" }),

	-- Prompt
	map({ modkey }, "r", function()
		awful.screen.focused().promptbox:run()
	end, { description = "run prompt", group = "launcher" }),

	map({ modkey }, "x", function()
		awful.prompt.run({
			prompt = "Run Lua code: ",
			textbox = awful.screen.focused().promptbox.widget,
			exe_callback = awful.util.eval,
			history_path = awful.util.get_cache_dir() .. "/history_eval",
		})
	end, { description = "lua execute prompt", group = "awesome" }),
	-- Menubar
	map({ modkey, "Shift"}, "Return", function()
		menubar.show()
	end, { description = "show the menubar", group = "launcher" })
)

local clientkeys = gears.table.join(
	awful.key({ modkey }, "f", function(c)
		c.fullscreen = not c.fullscreen
		c:raise()
	end, { description = "toggle fullscreen", group = "client" }),
	awful.key({ modkey }, "q", function(c)
		c:kill()
	end, { description = "close", group = "client" }),
	awful.key(
		{ modkey, "Shift" },
		"space", function (c)
			c.floating = not c.floating
			c:raise()
		end, { description = "toggle floating", group = "client" }
	),
	awful.key(
		{ modkey}, "s", function (c)
			c.sticky = not c.sticky
			c:raise()
		end, { description = "toggle sticky", group = "client" }
	),
	-- awful.key(
	-- 	{modkey}, "y", function(c)
	-- 		c.titlebar = not c.titlebar
	-- 		c:raise()
	-- 	end, { description = "titlebar toogle", group = "client"}
	-- ),
	awful.key({ modkey, "Control" }, "space", function(c)
		c:swap(awful.client.getmaster())
	end, { description = "move to master", group = "client" }),
	awful.key({ modkey }, "o", function(c)
		c:move_to_screen()
	end, { description = "move to screen", group = "client" }),
	awful.key({ modkey, "Shift"}, "t", function(c)
		c.ontop = not c.ontop
	end, { description = "toggle keep on top", group = "client" }),
	awful.key({ modkey }, "n", function(c)
		-- The client currently has the input focus, so it cannot be
		-- minimized, since minimized clients can't have the focus.
		c.minimized = true
	end, { description = "minimize", group = "client" }),
	-- Maximize window like in neovim
	awful.key({ modkey }, "\\", function(c)
		c.maximized = not c.maximized
		c:raise()
	end, { description = "(un)maximize", group = "client" }),
	awful.key({ modkey }, "-", function(c)
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

local clientbuttons = gears.table.join(
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
			-- border_color = beautiful.border_normal,
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
				"TeamViewer",
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
	-- local titlebar = awful.titlebar

	titlebar(c):setup({
		{ -- Left
			awful.titlebar.widget.closebutton(c),
			awful.titlebar.widget.minimizebutton(c),
			-- fullscreenbutton(c),
			awful.titlebar.widget.maximizedbutton(c),

			awful.titlebar.widget.floatingbutton(c),
			awful.titlebar.widget.stickybutton(c),
			layout = wibox.layout.fixed.horizontal(),
		},
		{ -- Middle
			{ -- Title
				buttons = buttons,
				align = "center",
				widget = awful.titlebar.widget.titlewidget(c),
				icons = awful.titlebar.widget.iconwidget(c),
			},
			buttons = buttons,
			layout = wibox.layout.flex.horizontal,
		},
		{ -- Right
			awful.titlebar.widget.ontopbutton(c),
			layout = wibox.layout.fixed.horizontal,
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

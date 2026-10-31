-- Hyprland Lua config (Hyprland 0.55+)
-- Converted from hyprland.conf
-- See https://wiki.hypr.land/configuring/

------------------
---- MONITORS ----
------------------

-- See https://wiki.hypr.land/configuring/core/monitors/
hl.monitor({ output = "eDP-1", mode = "preferred", position = "0x0", scale = "auto" })
-- hl.monitor({ output = "HDMI-A-1", mode = "preferred", position = "0x0", scale = "auto" })
hl.monitor({ output = "desc:HP Inc. HP E24 G4 CN40391855", mode = "preferred", position = "1920x0", scale = "auto" })
hl.monitor({ output = "desc:HP Inc. HP E24 G4 CN40430864", mode = "preferred", position = "3840x0", scale = "auto" })
hl.monitor({
	output = "desc:Dell Inc. DELL P2422H 2MLFMZ3",
	mode = "preferred",
	position = "5760x0",
	scale = "auto",
	transform = 3,
})
-- hl.monitor({ output = "", mode = "preferred", position = "auto", scale = "1", mirror = "eDP-1" })
hl.monitor({ output = "", mode = "preferred", position = "auto", scale = "1" })

-------------------
---- AUTOSTART ----
-------------------

hl.on("hyprland.start", function()
	hl.exec_cmd("waybar")
	hl.exec_cmd("dunst")
	hl.exec_cmd("hyprpaper")
	hl.exec_cmd("copyq --start-server hide")
	hl.exec_cmd("/usr/lib/polkit-kde-authentication-agent-1")
end)

-------------------------------
---- ENVIRONMENT VARIABLES ----
-------------------------------

hl.env("XCURSOR_SIZE", "20")

-----------------
---- OPTIONS ----
-----------------

-- See https://wiki.hypr.land/configuring/core/config-options/
hl.config({
	input = {
		kb_layout = "us",
		kb_variant = "",
		kb_model = "",
		kb_options = "",
		kb_rules = "",

		follow_mouse = 1,

		touchpad = {
			natural_scroll = false,
		},

		sensitivity = 0, -- -1.0 - 1.0, 0 means no modification.
	},

	debug = {
		disable_logs = false,
	},

	general = {
		gaps_in = 6,
		gaps_out = 3,
		border_size = 2,

		col = {
			active_border = { colors = { "rgba(33ccffee)", "rgba(00ff99ee)" }, angle = 45 },
			inactive_border = "rgba(595959aa)",
		},

		layout = "dwindle",
	},

	decoration = {
		rounding = 2,

		blur = {
			enabled = true,
			size = 3,
			passes = 1,
		},

		-- shadow = {
		--     enabled      = true,
		--     range        = 4,
		--     render_power = 3,
		--     color        = 0xee1a1a1a,
		-- },
	},

	animations = {
		enabled = true,
	},

	dwindle = {
		-- pseudotile = true,
		preserve_split = true, -- you probably want this
	},

	-- master = {
	--     new_status = "master",
	-- },

	misc = {
		disable_hyprland_logo = true,
		disable_splash_rendering = true,
	},

	ecosystem = {
		no_update_news = true,
		no_donation_nag = true,
	},
})

--------------------
---- ANIMATIONS ----
--------------------

-- See https://wiki.hypr.land/configuring/core/animations/
hl.curve("myBezier", { type = "bezier", points = { { 0.05, 0.9 }, { 0.1, 1.05 } } })

hl.animation({ leaf = "windows", enabled = true, speed = 7, bezier = "myBezier" })
hl.animation({ leaf = "windowsOut", enabled = true, speed = 7, bezier = "default", style = "popin 80%" })
hl.animation({ leaf = "border", enabled = true, speed = 10, bezier = "default" })
hl.animation({ leaf = "borderangle", enabled = true, speed = 8, bezier = "default" })
hl.animation({ leaf = "fade", enabled = true, speed = 7, bezier = "default" })
hl.animation({ leaf = "workspaces", enabled = true, speed = 6, bezier = "default" })

----------------------
---- WINDOW RULES ----
----------------------

-- See https://wiki.hypr.land/configuring/core/rules/
-- hl.window_rule({
--     name  = "float-kitty",
--     match = { class = "^(kitty)$", title = "^(kitty)$" },
--     float = true,
-- })

---------------------
---- KEYBINDINGS ----
---------------------

-- Loads ~/.config/hypr/conf/keybinds.lua
require("conf/keybinds")

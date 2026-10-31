-- Keybinds (Hyprland 0.55+ Lua)
-- Place at ~/.config/hypr/conf/keybinds.lua
-- See https://wiki.hypr.land/configuring/core/binds/

local mainMod = "SUPER"

local function key(combo)
	return mainMod .. " + " .. combo
end

-- Apps
hl.bind(key("Return"), hl.dsp.exec_cmd("kitty"))
hl.bind(key("F"), hl.dsp.exec_cmd("firefox"))
hl.bind(key("SHIFT + F"), hl.dsp.exec_cmd("firefox --private-window"))
hl.bind(key("Print"), hl.dsp.exec_cmd('grim -g "$(slurp)"'))
hl.bind(key("Space"), hl.dsp.exec_cmd("rofi -show drun"))

hl.bind(key("SHIFT + M"), hl.dsp.exit())
-- hl.bind(key("F"), hl.dsp.window.fullscreen())

-- Window management
hl.bind(key("Q"), hl.dsp.window.close())
hl.bind(key("P"), hl.dsp.window.pseudo()) -- dwindle
hl.bind(key("V"), hl.dsp.window.float({ action = "toggle" }))
hl.bind(key("C"), hl.dsp.window.fullscreen({ mode = "maximized" })) -- monocle mode
hl.bind(key("SHIFT + C"), hl.dsp.window.fullscreen({ mode = "fullscreen" }))

-- Move focus with mainMod + hjkl
hl.bind(key("h"), hl.dsp.focus({ direction = "left" }))
hl.bind(key("l"), hl.dsp.focus({ direction = "right" }))
hl.bind(key("k"), hl.dsp.focus({ direction = "up" }))
hl.bind(key("j"), hl.dsp.focus({ direction = "down" }))

-- Previous / next existing workspace
hl.bind(key("W"), hl.dsp.focus({ workspace = "e-1" }))
hl.bind(key("E"), hl.dsp.focus({ workspace = "e+1" }))

-- Switch workspaces with mainMod + [0-9]
-- Move active window to a workspace with mainMod + SHIFT + [0-9]
for i = 1, 10 do
	local k = i % 10 -- workspace 10 is on key 0
	hl.bind(key(k), hl.dsp.focus({ workspace = i }))
	hl.bind(key("SHIFT + " .. k), hl.dsp.window.move({ workspace = i }))
end

-- Scroll through existing workspaces with mainMod + scroll
hl.bind(key("mouse_down"), hl.dsp.focus({ workspace = "e+1" }))
hl.bind(key("mouse_up"), hl.dsp.focus({ workspace = "e-1" }))

-- Move/resize windows with mainMod + LMB/RMB and dragging
hl.bind(key("mouse:272"), hl.dsp.window.drag(), { mouse = true })
hl.bind(key("mouse:273"), hl.dsp.window.resize(), { mouse = true })

-- Screen brightness
hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd("brightnessctl s +5%"))
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl s 5%-"))

-- Volume
hl.bind("XF86AudioMute", hl.dsp.exec_cmd("pactl set-sink-mute @DEFAULT_SINK@ toggle"))
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("pactl set-sink-volume @DEFAULT_SINK@ -5%"))
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("pactl set-sink-volume @DEFAULT_SINK@ +5%"))

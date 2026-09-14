---------------------
---- MY PROGRAMS ----
---------------------

-- Set programs that you use
local terminal    = "ghostty"
local fileManager = "nautilus"
local menu        = "qs ipc call launcher toggle"

---------------------
---- KEYBINDINGS ----
---------------------

local mainMod     = "SUPER" -- Sets "Windows" key as main modifier

-- Example binds, see https://wiki.hypr.land/Configuring/Basics/Binds/ for more
hl.bind(mainMod .. " + Return", hl.dsp.exec_cmd(terminal))
hl.bind(mainMod .. " + Q",     hl.dsp.window.close())
hl.bind(mainMod .. " + F",     hl.dsp.exec_cmd(fileManager))
hl.bind(mainMod .. " + X",     hl.dsp.window.float({ action = "toggle" }))
hl.bind(mainMod .. " + Space", hl.dsp.exec_cmd(menu))
hl.bind(mainMod .. " + C",     hl.dsp.exec_cmd("qs ipc call controlcenter toggle"))

-- Conmutador de ventanas nativo Quickshell (Alt + Tab)
hl.bind("ALT + Tab",        hl.dsp.exec_cmd("qs ipc call switcher next"))
hl.bind("ALT + SHIFT + Tab", hl.dsp.exec_cmd("qs ipc call switcher prev"))
hl.bind(mainMod .. " + V",     hl.dsp.exec_cmd("quickshell ipc call clipboard toggle"))
hl.bind(mainMod .. " + R",     hl.dsp.exec_cmd("killall quickshell; quickshell &"))
hl.bind(mainMod .. " + N",     hl.dsp.exec_cmd("zen-browser"))
hl.bind(mainMod .. " + P",     hl.dsp.window.pseudo())
hl.bind(mainMod .. " + ALT + J", hl.dsp.layout("togglesplit")) -- dwindle only
hl.bind(mainMod .. " + M", hl.dsp.window.fullscreen())
hl.bind(mainMod .. " + SHIFT + M", hl.dsp.window.fullscreen({ mode = "maximized", action = "toggle" }))

-- Move focus with mainMod + arrow keys / vim keys
hl.bind(mainMod .. " + h",     hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + j",     hl.dsp.focus({ direction = "down" }))
hl.bind(mainMod .. " + k",     hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + l",     hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod .. " + Left",  hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + Down",  hl.dsp.focus({ direction = "down" }))
hl.bind(mainMod .. " + Up",    hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + Right", hl.dsp.focus({ direction = "right" }))

-- Foco entre monitores (pantallas)
hl.bind(mainMod .. " + comma",  hl.dsp.focus({ monitor = "-1" }))
hl.bind(mainMod .. " + period", hl.dsp.focus({ monitor = "+1" }))

-- Mover ventana activa directamente entre monitores (pantallas)
hl.bind(mainMod .. " + ALT + Left",  hl.dsp.window.move({ monitor = "-1" }))
hl.bind(mainMod .. " + ALT + Right", hl.dsp.window.move({ monitor = "+1" }))
hl.bind(mainMod .. " + ALT + h",     hl.dsp.window.move({ monitor = "-1" }))
hl.bind(mainMod .. " + ALT + l",     hl.dsp.window.move({ monitor = "+1" }))

-- Switch workspaces with mainMod + [1-5]
-- Move active window to a workspace with mainMod + SHIFT + [1-5]
for i = 1, 5 do
    local key = i
    hl.bind(mainMod .. " + " .. key, hl.dsp.focus({ workspace = i }))
    hl.bind(mainMod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = i }))
end

-- Example special workspace (scratchpad)
hl.bind(mainMod .. " + S", hl.dsp.workspace.toggle_special("magic"))
hl.bind(mainMod .. " + SHIFT + S", hl.dsp.window.move({ workspace = "special:magic" }))

-- Scroll through workspaces on current monitor with mainMod + scroll
hl.bind(mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "m+1" }))
hl.bind(mainMod .. " + mouse_up", hl.dsp.focus({ workspace = "m-1" }))

-- Move/resize windows with mainMod + LMB/RMB and dragging
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

-- Laptop multimedia keys for volume and LCD brightness (Quickshell Native OSD)
hl.bind("XF86AudioRaiseVolume",  hl.dsp.exec_cmd("qs ipc call audio raise || wpctl set-volume -l 1.2 @DEFAULT_AUDIO_SINK@ 5%+"), { locked = true, repeating = true })
hl.bind("XF86AudioLowerVolume",  hl.dsp.exec_cmd("qs ipc call audio lower || wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"),        { locked = true, repeating = true })
hl.bind("XF86AudioMute",         hl.dsp.exec_cmd("qs ipc call audio mute || wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"),        { locked = true })
hl.bind("XF86AudioMicMute",      hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"),      { locked = true, repeating = true })

-- Brillo (Quickshell Native OSD)
hl.bind("XF86MonBrightnessUp",   hl.dsp.exec_cmd("qs ipc call brightness raise || brightnessctl set 5%+"), { locked = true, repeating = true })
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("qs ipc call brightness lower || brightnessctl set 5%-"), { locked = true, repeating = true })


-- Requires playerctl
hl.bind("XF86AudioNext", hl.dsp.exec_cmd("playerctl next"), { locked = true })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("playerctl previous"), { locked = true })

-- Bloqueo de pantalla Quickshell (teclado y tapa de laptop)
hl.bind(mainMod .. " + ALT + B", hl.dsp.exec_cmd("qs ipc call lock lock"))
hl.bind("switch:on:Lid Switch", hl.dsp.exec_cmd("qs ipc call lock lock"), { locked = true })

-- Menú de Sesión y Apagado
hl.bind(mainMod .. " + Escape", hl.dsp.exec_cmd("qs ipc call session toggle"))

-- Swaync
hl.bind(mainMod .. " + E", hl.dsp.exec_cmd("qs ipc call notifications toggle"))

-- Hyprshot
-- Screenshots (hyprshot)
hl.bind("Print",                  hl.dsp.exec_cmd("hyprshot -m output"))
hl.bind("ALT + Print",            hl.dsp.exec_cmd("hyprshot -m window"))
hl.bind("SHIFT + Print",          hl.dsp.exec_cmd("hyprshot -m region"))
hl.bind("CTRL + Print",           hl.dsp.exec_cmd("hyprshot -m region --clipboard-only"))

-- Mover/intercambiar ventanas estilo vim
hl.bind(mainMod .. " + SHIFT + h", hl.dsp.window.swap({ direction = "l" }))
hl.bind(mainMod .. " + SHIFT + j", hl.dsp.window.swap({ direction = "d" }))
hl.bind(mainMod .. " + SHIFT + k", hl.dsp.window.swap({ direction = "u" }))
hl.bind(mainMod .. " + SHIFT + l", hl.dsp.window.swap({ direction = "r" }))

-- Redimensionar estilo vim
local resizeStep = 30
hl.bind(mainMod .. " + CTRL + h", hl.dsp.window.resize({ x = -resizeStep, y = 0, relative = true }), { repeating = true })
hl.bind(mainMod .. " + CTRL + l", hl.dsp.window.resize({ x = resizeStep,  y = 0, relative = true }), { repeating = true })
hl.bind(mainMod .. " + CTRL + k", hl.dsp.window.resize({ x = 0, y = -resizeStep, relative = true }), { repeating = true })
hl.bind(mainMod .. " + CTRL + j", hl.dsp.window.resize({ x = 0, y = resizeStep,  relative = true }), { repeating = true })

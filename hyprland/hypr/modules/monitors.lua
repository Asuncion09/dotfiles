------------------
---- MONITORS ----
------------------

-- See https://wiki.hypr.land/Configuring/Basics/Monitors/
hl.monitor({
  output = "eDP-1",
  mode = "1920x1080@60",
  position = "0x0",
  scale = 1,
})

hl.monitor({
  output = "HDMI-A-1",
  mode = "1920x1080@100",
  position = "1920x0",
  scale = 1,
})

-- Fallback para monitores adicionales / externos
hl.monitor({
  output = "",
  mode = "preferred",
  position = "auto",
  scale = 1,
})

-- Detección de monitor externo HDMI conectado por hardware (sysfs DRM)
local function is_hdmi_connected()
    local paths = {
        "/sys/class/drm/card0-HDMI-A-1/status",
        "/sys/class/drm/card1-HDMI-A-1/status"
    }
    for _, path in ipairs(paths) do
        local f = io.open(path, "r")
        if f then
            local status = f:read("*l")
            f:close()
            if status == "connected" then
                return true
            end
        end
    end
    return false
end

-- Workspaces asignados (1 a 3 siempre en eDP-1; 4 y 5 en HDMI si está conectado, o en eDP-1 si es pantalla única)
hl.workspace_rule({ workspace = "1", monitor = "eDP-1", persistent = true })
hl.workspace_rule({ workspace = "2", monitor = "eDP-1", persistent = true })
hl.workspace_rule({ workspace = "3", monitor = "eDP-1", persistent = true })

if is_hdmi_connected() then
    hl.workspace_rule({ workspace = "4", monitor = "HDMI-A-1", persistent = true, default = true })
    hl.workspace_rule({ workspace = "5", monitor = "HDMI-A-1", persistent = true })
else
    hl.workspace_rule({ workspace = "4", monitor = "eDP-1", persistent = true })
    hl.workspace_rule({ workspace = "5", monitor = "eDP-1", persistent = true })
end

-- Al conectar monitor externo HDMI en caliente, transferir automáticamente los workspaces 4 y 5
hl.on("monitor.added", function ()
    hl.dispatch(hl.dsp.workspace.move({ workspace = 4, monitor = "HDMI-A-1" }))
    hl.dispatch(hl.dsp.workspace.move({ workspace = 5, monitor = "HDMI-A-1" }))
end)

-- Al desconectar monitor externo, devolver workspaces 4 y 5 a eDP-1 y asegurar foco limpio en workspace 1
hl.on("monitor.removed", function ()
    hl.dispatch(hl.dsp.workspace.move({ workspace = 4, monitor = "eDP-1" }))
    hl.dispatch(hl.dsp.workspace.move({ workspace = 5, monitor = "eDP-1" }))
    hl.dispatch(hl.dsp.focus({ workspace = 1 }))
end)

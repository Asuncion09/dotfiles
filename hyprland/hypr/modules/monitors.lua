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
  mode = "1920x1080@100.00Hz",
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

hl.workspace_rule({ workspace = "1", monitor = "eDP-1", persistent = true})
hl.workspace_rule({ workspace = "2", monitor = "eDP-1", persistent = true})
hl.workspace_rule({ workspace = "3", monitor = "eDP-1", persistent = true})
hl.workspace_rule({ workspace = "4", monitor = "eDP-1", persistent = true})
hl.workspace_rule({ workspace = "5", monitor = "eDP-1", persistent = true})


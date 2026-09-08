--------------------------------
---- WINDOWS AND WORKSPACES ----
--------------------------------

hl.window_rule({
    -- Ignore maximize requests from all apps. You'll probably like this.
    name           = "suppress-maximize-events",
    match          = { class = ".*" },

    suppress_event = "maximize",
})

hl.window_rule({
    name     = "fix-xwayland-drags",
    match    = {
        class      = "^$",
        title      = "^$",
        xwayland   = true,
        float      = true,
        fullscreen = false,
        pin        = false,
    },

    no_focus = true,
})

hl.window_rule({
  match = {
    class = "com.floating.medium"
  },
  float = true,
  size = { 550, 550 },
  opacity = 0.95,
  animation = "slide top",
  move = {1360, 50}
})

hl.window_rule({
  match = {
    class = "com.floating.high"
  },

  float = true,
  center = true,
  size = { 880, 600 },
  opacity = 0.95
})

hl.layer_rule({
  name = "rofi-popup",
  match = { namespace = "rofi"},
  animation = "slide top",
  dim_around = false
})


hl.layer_rule({
  name = "notification-animations",
  match = { namespace = "swaync-control-center"},
  animation = "slide top",
})

hl.window_rule({
  match = { class = "spotify"},
  size = { 800,600 },
  float = true
})

hl.window_rule({
  match = {
    class = "xdg-desktop-portal-gtk",
    title = "Open Folder"
  },
  center = true
})

hl.window_rule({
  match = {
    class = "net.davidotek.pupgui2",
  },
  float = true
})

hl.window_rule({
  match = {
    class = "org.nmrs.ui"
  },
  float = true,
  animation = "slide top",
  move = {1430, 50}
})

-- Reglas para Steam: evitar que submenús hover, tooltips y notificaciones roben foco
hl.window_rule({
  name = "steam-tooltips-nofocus",
  match = {
    class = "steam",
    title = "^$",
  },
  no_focus = true,
})

hl.window_rule({
  name = "steam-notifications-nofocus",
  match = {
    class = "steam",
    title = "^notificationtoasts.*",
  },
  float = true,
  no_focus = true,
})


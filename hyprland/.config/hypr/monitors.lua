-- Three-display desk layout.
--
--   Elgato Prompter       LG Ultrawide        Laptop
--   1024x600              2560x1080           2880x1800 @ 2x
--   -1024x0               0x0                 2560x0

hl.env("GDK_SCALE", "1")

hl.monitor({
  output = "desc:IDI Elgato Prom. 0x01348D27",
  mode = "1024x600@60",
  position = "-1024x0",
  scale = 1,
})

hl.monitor({
  output = "HDMI-A-1",
  mode = "preferred",
  position = "0x0",
  scale = 1,
})

hl.monitor({
  output = "eDP-1",
  mode = "preferred",
  position = "auto-right",
  scale = 2,
})

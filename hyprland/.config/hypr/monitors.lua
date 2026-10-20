-- Three-display desk layout.
--
--   Elgato Prompter       LG Ultrawide        Laptop
--   1024x600              2560x1080           2880x1800 @ 1.6x
--   0x0                    1024x0              3584x0
--
-- Keep every output at a non-negative coordinate. Hyprland 0.56 can strand
-- pinned Google Meet PiP windows when they are dragged onto a negative output.

hl.env("GDK_SCALE", "1")

hl.monitor({
  output = "desc:IDI Elgato Prom. 0x01348D27",
  mode = "1024x600@60",
  position = "0x0",
  scale = 1,
})

hl.monitor({
  output = "HDMI-A-1",
  mode = "preferred",
  position = "1024x0",
  scale = 1,
})

-- Apply 2x scaling to this BenQ wherever it is connected.
hl.monitor({
  output = "desc:BNQ BenQ EW3270U P4K04965019",
  mode = "preferred",
  position = "1024x0",
  scale = 2,
})

hl.monitor({
  output = "eDP-1",
  mode = "preferred",
  position = "auto-right",
  scale = 1.6,
})

-- Prefer the Dell for numbered workspaces; the laptop remains available.
-- Disconnected outputs fall back to an available monitor.
for workspace = 1, 10 do
  hl.workspace_rule({
    workspace = tostring(workspace),
    monitor = "desc:Dell Inc. DELL U4025QW 96FGJF4",
  })
end

local hypr_scripts = (os.getenv("XDG_CONFIG_HOME") or ((os.getenv("HOME") or "") .. "/.config")) .. "/hypr/scripts/"

-- Switch as soon as both Alt keys are down, regardless of which one is
-- released first. The helper keeps Hyprland and Espanso in sync.
o.bind("ALT + Alt_R", "Toggle Dvorak/QWERTY", hypr_scripts .. "keyboard-layout-toggle")

-- Temporary layout-independent clipboard override. Quattro's injected letter
-- keys are translated through Dvorak in Electron/Chromium applications.
local function send_clipboard_shortcut(mods, key)
  return function()
    hl.dispatch(hl.dsp.send_key_state({ mods = mods, key = key, state = "down" }))
    hl.dispatch(hl.dsp.send_key_state({ mods = mods, key = key, state = "up" }))
  end
end

hl.unbind("SUPER + C")
hl.unbind("SUPER + V")
hl.unbind("SUPER + X")
o.bind("SUPER + C", "Universal copy", send_clipboard_shortcut("CTRL", "Insert"))
o.bind("SUPER + V", "Universal paste", send_clipboard_shortcut("SHIFT", "Insert"))
o.bind("SUPER + X", "Universal cut", send_clipboard_shortcut("SHIFT", "Delete"))

-- Restore personal application choices that differ from Quattro's defaults.
hl.unbind("SUPER + SHIFT + A")
o.bind("SUPER + SHIFT + A", "ChatGPT (Codex)", { launch = "chatgpt" })

hl.unbind("SUPER + SHIFT + W")
o.bind("SUPER + SHIFT + W", "Typora", { launch = "typora --enable-wayland-ime" })

hl.unbind("SUPER + SHIFT + C")
o.bind("SUPER + SHIFT + C", "Calendar", "omarchy launch or focus webapp 'Google Calendar' 'https://calendar.google.com'")

hl.unbind("SUPER + SHIFT + E")
o.bind("SUPER + SHIFT + E", "Email", "omarchy launch or focus webapp 'Gmail' 'https://mail.google.com'")

-- Remove Quattro's HEY-only shortcut; Gmail remains on Super+Shift+E.
hl.unbind("SUPER + SHIFT + ALT + E")

-- Launch or focus the native Claude and T3 Code apps.
hl.unbind("SUPER + SHIFT + I")
hl.unbind("SUPER + SHIFT + ALT + I")
o.bind("SUPER + SHIFT + I", "Claude Desktop", { launch = "claude-desktop", focus = "^com[.]anthropic[.]Claude$" })
o.bind("SUPER + SHIFT + ALT + I", "T3 Code", { launch = "t3code", focus = "^com[.]t3tools[.]T3Code$" })

-- Personal utility bindings.
o.bind("SUPER + R", "Toggle recording mode (16:9)", hypr_scripts .. "recording-mode-toggle")
o.bind("SUPER + H", "Rescue off-screen windows", hypr_scripts .. "center-floats")
o.bind("SUPER + SHIFT + CTRL + C", "Screenshot active window", hypr_scripts .. "screenshot-activewindow")
o.bind("SUPER + ALT + C", "Screenshot full screen", "omarchy capture screenshot fullscreen")
o.bind("SUPER + ALT + P", "Record teleprompter (toggle)", hypr_scripts .. "record-teleprompter")
o.bind("SUPER + SHIFT + T", "Tasks", { tui = "taskwarrior-tui", focus = true })

-- Function-row media keys on the laptop keyboard. Quattro's defaults cover
-- XF86 media keys; this hardware exposes the same controls as plain F keys.
o.bind("F1", "Brightness down", "omarchy brightness display --monitor eDP-1 5%-", { locked = true, repeating = true })
o.bind("F2", "Brightness up", hypr_scripts .. "brightness-up-safe", { locked = true, repeating = true })

-- Adjust the LG external display directly over DDC/CI.
o.bind("ALT + F1", "LG brightness down", "omarchy brightness display --monitor HDMI-A-1 5%-", { locked = true, repeating = true })
o.bind("ALT + F2", "LG brightness up", "omarchy brightness display --monitor HDMI-A-1 +5%", { locked = true, repeating = true })

o.bind("F6", "Mute", "omarchy audio output volume mute-toggle", { locked = true })
o.bind("F7", "Volume down", "omarchy audio output volume lower", { locked = true, repeating = true })
o.bind("F8", "Volume up", "omarchy audio output volume raise", { locked = true, repeating = true })
o.bind("ALT + F7", "Volume down precise", "omarchy audio output volume -1", { locked = true, repeating = true })
o.bind("ALT + F8", "Volume up precise", "omarchy audio output volume +1", { locked = true, repeating = true })

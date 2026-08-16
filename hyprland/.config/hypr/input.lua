-- Keep Dvorak and QWERTY available. The dual-Alt binding switches layouts and
-- selects Espanso's matching single-layout profile.
hl.config({
  input = {
    kb_layout = "us,us",
    kb_variant = "dvorak,",
    kb_options = "compose:paus",
    resolve_binds_by_sym = true,

    repeat_rate = 60,
    repeat_delay = 200,
    numlock_by_default = true,

    -- Invert scroll direction for external mice and the laptop touchpad.
    natural_scroll = true,
    touchpad = {
      natural_scroll = true,
      scroll_factor = 0.4,
    },
  },
})

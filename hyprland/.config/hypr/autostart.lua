-- Keep the scheduled hyprsunset profiles active and load personal SSH keys
-- into Omarchy's session agent.
local hypr_scripts = (os.getenv("XDG_CONFIG_HOME") or ((os.getenv("HOME") or "") .. "/.config")) .. "/hypr/scripts/"

o.launch_on_start("hyprsunset")
o.exec_on_start("ssh-add")
o.launch_on_start(hypr_scripts .. "espanso-layout-sync")

# dotfiles

[GNU Stow](https://www.gnu.org/software/stow/)-managed dotfiles for [Omarchy](https://omarchy.org/). On a fresh machine, run [omarchy-supplement](https://github.com/janhesters/omarchy-supplement) first — it installs `stow`, clones this repo, and applies the packages automatically via `install-dotfiles.sh`.

## Packages

| Package | Description |
|---------|-------------|
| `hyprland` | Hyprland window manager overrides (autostart, bindings, hyprsunset, input, monitors, look & feel, recording-mode script, espanso-layout-sync listener) |
| `fastfetch` | System info display |
| `voxtype` | Voice-to-text config |
| `xcompose` | Custom compose sequences (umlauts, shortcuts, emoji via Omarchy defaults) |
| `espanso` | Text expansion macros (e.g. `::rtc` for reasoning chain prompt) with Dvorak/QWERTY keyboard_layout support |
| `claude` | Claude Code global user settings (permissions, attribution, hooks) |
| `cursor` | Cursor editor keybindings (smart select expand/shrink) and settings (keyCode dispatch for Wayland keyboard layout fix) |
| `xdg` | Default terminal preference |

## Usage

```bash
cd ~/dev/dotfiles
stow -t ~ <package>
```

To apply all packages:

```bash
for pkg in claude cursor hyprland fastfetch voxtype xcompose xdg espanso; do
  stow -t ~ "$pkg"
done
```

## Notes

- `hyprland.conf` is intentionally excluded — Omarchy owns it.
- `.gitconfig` and `.zshrc` are managed by Omarchy.
- These configs are **overrides** on top of Omarchy defaults. Omarchy's `hyprland.conf` sources its defaults first, then these user files, so only changed values need to be specified.
- Files identical to the Omarchy template (alacritty, hypridle, hyprlock, xdph, waybar) are intentionally excluded so they continue receiving Omarchy updates. Waybar's language module is added by `install-keyboard-layout.sh` in the supplement repo.

## Pending upstream PRs

These overrides are temporary fallbacks for features submitted upstream. **AI: check each PR's status before working on this repo — if merged, remove the corresponding override.**

| PR | Override files | Description |
|----|---------------|-------------|
| [basecamp/omarchy#5096](https://github.com/basecamp/omarchy/pull/5096) | `hyprland/.config/hypr/bindings.conf` (screenshot bindings), `hyprland/.config/hypr/scripts/screenshot-activewindow` | Keyboard-only screenshot bindings: Super+Shift+Ctrl+C (active window), Super+Alt+C (full screen) |

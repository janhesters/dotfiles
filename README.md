# dotfiles

[GNU Stow](https://www.gnu.org/software/stow/)-managed dotfiles for [Omarchy](https://omarchy.org/).

## Packages

| Package | Description |
|---------|-------------|
| `hyprland` | Hyprland window manager overrides (bindings, input, monitors, look & feel, etc.) |
| `fastfetch` | System info display |
| `voxtype` | Voice-to-text config |
| `xdg` | Default terminal preference |

## Usage

```bash
cd ~/dev/dotfiles
stow -t ~ <package>
```

To apply all packages:

```bash
for pkg in hyprland fastfetch voxtype xdg; do
  stow -t ~ "$pkg"
done
```

## Notes

- `hyprland.conf` is intentionally excluded — Omarchy owns it.
- `.gitconfig` and `.zshrc` are managed by Omarchy.
- These configs are **overrides** on top of Omarchy defaults. Omarchy's `hyprland.conf` sources its defaults first, then these user files, so only changed values need to be specified.
- Files identical to the Omarchy template (alacritty, hypridle, hyprlock, xdph, waybar) are intentionally excluded so they continue receiving Omarchy updates. Waybar's language module is added by `install-keyboard-layout.sh` in the supplement repo.

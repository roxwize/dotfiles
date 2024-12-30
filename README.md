this is rae's nixOS config meow

- **display manager**: SDDM
- **window manager**: openbox
- **status bar**: polybar

# installation

theoretically:

```sh
nix-shell -p git just
git clone https://git.sr.ht/~roxwize/.dotfiles
cd .dotfiles/
nixos-install --flake './nixos#[hostname]'
```

# usage

## openbox hotkeys

**Ctrl+Right click** on a titlebar to open the window's menu<br>
**Alt+C** over a window to do the same thing

**Middle click** on desktop to open menu
**Alt+Middle click** over a window to do the same thing
**Alt+D** to open the application launcher

**Alt+Left arrow** to go to the previous desktop<br>
**Alt+Right arrow** to go to the next desktop<br>
**Alt+[1-4]** to go to a specific desktop


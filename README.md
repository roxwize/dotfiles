this is rae's nixOS config meow

- **display manager**: SDDM
- **window manager**: openbox
- **status bar**: polybar

# installation

theoretically:

```sh
nix-shell -p git just
git clone https://github.com/roxwize/dotfiles
cd dotfiles/nixos
just switch [hostname]
```

# usage

## openbox hotkeys

**Ctrl+Right click** on a titlebar to open the window's menu<br>
**Alt+C** over a window to do the same thing

**Alt+D** to open the application menu

**Alt+Left arrow** to go to the previous desktop<br>
**Alt+Right arrow** to go to the next desktop<br>
**Alt+[1-4]** to go to a specific desktop


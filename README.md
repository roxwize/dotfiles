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

**Alt+Left click** and drag over a window to move it<br>
**Alt+Right click** and drag over a window to resize it<br>
**Ctrl+Right click** on titlebar to open its window's menu<br>
**Alt+C** over a window to do the same thing<br>

**Double click titlebar** to maximize its window completely<br>
**Left click maximize button** to maximize completely<br>
**Middle click maximize button** to maximize vertically<br>
**Right click maximize button** to maximize horizontally

**Right click** on desktop to open menu<br>
**Alt+Right click** over a window to do the same thing<br>
**Alt+D** to open the application launcher

**Alt+Left arrow** to go to the previous desktop<br>
**Alt+Right arrow** to go to the next desktop<br>
**Alt+[1-4]** to go to a specific desktop


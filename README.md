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

```
A-d
    Open application menu
A-c
    Open client (window) menu

A-Enter
    Iconify window
A-Up
    Raise window
A-Down
    Lower window
CA-x
    Close window
CA-m
    Maximize window

CA-Enter
    Open terminal (kitty)
CAS-r
    Restart

A-Left
    Switch to previous workspace
A-Right
    Switch to next workspace
```

or:

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


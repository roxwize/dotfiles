![image](https://github.com/user-attachments/assets/f0f66913-2616-4a3c-ac7f-55db6fc27116)

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
Menus
    A-d
        Main menu
    A-question
        Application menu
    A-period
        ssh menu
    A-c
        Client (window) menu

Window actions
    A-Return
        Iconify
    A-Up
        Raise
    A-Down
        Lower
    CA-x
        Close
    CA-f
        Fullscreen
    CA-m
        Maximize

Workspace management
    A-Left
        Switch to previous workspace
    A-Right
        Switch to next workspace

Miscellaneous
    CA-Return
        Open terminal (kitty)
    CAS-r
        Restart
```

or:

**Alt+Left click** and drag over a window to move it<br>
**Alt+Right click** and drag over a window to resize it<br>
**Ctrl+Right click** on titlebar to open its window's menu<br>
**Alt+C** over a window to do the same thing

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


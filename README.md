![image](https://github.com/user-attachments/assets/2ab0e4f6-6a94-437b-9598-4396500d1f5b)

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

from my experience the process is more involved, but it ultimately boils down to those three commands above (the first command is only for bootstrapping). youll need to make a configuration for your host which involves creating default configurations with `nixos-generate-config`, copying it to your host's folder in `nixos/hosts/[host]/`, editing it, and then adding it to `flake.nix`. after that you should clone the repo inside of `/home/rae/` on your filesystem

# usage

the system should boot into openbox and from there you'll have your statusbar and a lot of keybinds to learn x3

## openbox hotkeys

```
Menus
    A-d
        Main menu
    A-/
        Passwords
    A-? (SA-/)
        Application menu
    A-.
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
    A-[hjkl]
        Move
    CA-x
        Close
    CA-f
        Fullscreen
    CA-m
        Maximize
    SA-Left
        Switch focus to previous window
    SA-Right
        Switch focus to previous window
    A-Tab
        Cycle focus to windows in all workspaces

Workspace management
    A-Left
        Switch to previous workspace
    A-Right
        Switch to next workspace
    A-[123456]
        Switch to specific workspace

Miscellaneous
    A-F12
        Take screenshot
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
**Alt+[1-6]** to go to a specific desktop<br>
**Alt+Shift+Left arrow** to go to the previous desktop window<br>
**Alt+Shift+Right arrow** to go to the next desktop window<br>
**Alt+Tab** to cycle windows in all desktops

# (history)

here is the very first finalized version of this config that was originally tested on a qemu vm. it took 14 hours to set up. after running it on the machine itself and switching over to the configuration in its entirety i realized that it was complete and utter HORSESHIT. making things look nice again took another like four hours.

![image](https://github.com/user-attachments/assets/f0f66913-2616-4a3c-ac7f-55db6fc27116)

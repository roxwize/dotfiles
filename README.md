![image](https://github.com/user-attachments/assets/2ab0e4f6-6a94-437b-9598-4396500d1f5b)

# installation

theoretically:

```sh
nix-shell -p git
git clone https://git.sr.ht/~roxwize/.dotfiles
cd .dotfiles/
nixos-install --flake './nixos#[hostname]'
```

from my experience the process is more involved, but it ultimately boils down to those three commands above (the first command is only for bootstrapping). youll need to make a configuration for your host which involves creating default configurations with `nixos-generate-config`, copying it to your host's folder in `nixos/hosts/[host]/`, editing it, and then adding it to `flake.nix`. after that you should clone the repo inside of `/home/rae/` on your filesystem

# default applications

- **compositor** xcompmgr
- **DM** SDDM
- **launcher** rofi
- **statusbar** yambar
- **WM** openbox

<!--## raspberry PI devices

[raspberry-pi-nix](https://github.com/nix-community/raspberry-pi-nix) is used to build PI sd card images. have yur lil sd card on hand (paw) and run in the root of the repository:

```sh
nix build './nixos#nixosConfigurations.[hostname].config.system.build.sdImage'
```

and then Wait................... output will be in `result/` NYA!!

### ermm???

O.K., just take the image in `result/sd-image/[whatever]`, decompress it with zstd, then run `dd if=[decompressed image] of=[sd card device WITHOUT partition number] status=progress`

the system will automatically resize the root partition to match the size of the SD card, and from there any changes in post should likely be made over ssh...

```sh
nixos-rebuild switch --flake './nixos#[hostname]' --target-host root@[hostname]
```

ssh isnt automatically setup in a way that lets you do this from the start, you should define it in your host configuration beforehand. near has a decent example of this that you can look over if yu want...-->

# openbox hotkeys

M corresponds to super/meta key (usually inbetween Ctrl and Alt)

```
Menus
    M-d
        Main menu
    M-/
        Passwords
    M-? (SM-/)
        Application menu
    M-.
        ssh menu
    M-c
        Client (window) menu

Window actions
    M-Return
        Iconify
    M-Up
        Raise
    M-Down
        Lower
    M-[hjkl]
        Move
    CM-x
        Close
    CM-f
        Fullscreen
    CM-m
        Maximize
    SM-Left
        Switch focus to previous window
    SM-Right
        Switch focus to previous window
    M-Tab
        Cycle focus to windows in all workspaces

Workspace management
    M-Left
        Switch to previous workspace
    M-Right
        Switch to next workspace
    M-[123456]
        Switch to specific workspace

Miscellaneous
    M-F12
        Take screenshot
    CM-Return
        Open terminal (kitty)
    CMS-r
        Restart
```

# (history)

here is the very first finalized version of this config that was originally tested on a qemu vm. it took 14 hours to set up. after running it on the machine itself and switching over to the configuration in its entirety i realized that it was complete and utter HORSESHIT. making things look nice again took another like four hours.

![image](https://github.com/user-attachments/assets/f0f66913-2616-4a3c-ac7f-55db6fc27116)


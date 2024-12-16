{ pkgs, ... }:
{
    environment.systemPackages = with pkgs; [
        # system tools
        bat
        btop
        ffmpeg
        git
        gparted
        hyfetch
        imagemagick
        kdePackages.dolphin
        kitty
        maim
        monitor
        xclip
        yt-dlp
        zellij
        # text editors
        neovim
        vscodium
        # X11
        hsetroot
        nitrogen
        polybarFull
        rofi
        xcompmgr
        xdotool
        xorg.xev
        xorg.xwininfo
        # gtk
        posy-cursors
        pantheon.elementary-gtk-theme
        # misc
        uxn
    ];
}
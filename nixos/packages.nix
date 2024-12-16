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
        kitty
        monitor
        xclip
        xfce.xfce4-taskmanager
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
        themechanger
        xcompmgr
        xdotool
        xorg.xev
        xorg.xwininfo
        # gtk
        flat-remix-icon-theme
        posy-cursors
        pantheon.elementary-gtk-theme
        # misc
        uxn
    ];
}
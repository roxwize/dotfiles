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
        # misc
        uxn
    ];
}
{ pkgs, ... }:
{
    environment.systemPackages = with pkgs; [
        # system tools
        bat
        btop
        dconf-editor
        ffmpeg
        git
        gparted
        home-manager
        hyfetch
        imagemagick
        kitty
        maim
        monitor
        xclip
        zellij
        # internet
        nicotine-plus
        vesktop
        yt-dlp
        # development
        just
        ## language servers
        nil
        # games
        prismlauncher
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
        gimp
        uxn
    ];
}

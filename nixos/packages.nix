{ pkgs, ... }:
{
    environment.systemPackages = with pkgs; [
        # development
        just
        ## language servers
        nil
        # games
        prismlauncher
        # graphics
        gimp
        krita
        # gtk
        posy-cursors
        pantheon.elementary-gtk-theme
        # internet
        nicotine-plus
        vesktop
        yt-dlp
        # misc
        gimp
        uxn
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
    ];
}

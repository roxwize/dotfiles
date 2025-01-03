{ pkgs, ... }:
{
    # I'm not sure if you actually need stuff like GTK4 to be
    # in here when it's really only used with nix-shell and the
    # amount of time it saves during installation is probably
    # only like a few seconds
    environment.systemPackages = with pkgs; [
        # development
        (fenix.default.withComponents [ "cargo" "rustc" ])
        gcc
        gtk4
        just
        meson
        nodejs_23
        pkg-config
        vala
        ## language servers
        mesonlsp             # Meson
        nil                  # Nix
        rust-analyzer        # Rust
        vala-language-server # Vala
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
        # system tools
        alsa-utils
        bat
        btop
        dconf-editor
        ffmpeg
        flameshot
        git
        gparted
        home-manager
        hyfetch
        imagemagick
        kitty
        maim
        monitor
        pavucontrol
        scrot
        xclip
        zellij
        # text editors
        neovim
        vscodium
        # audio
        audacity
        mpc
        playerctl
        unstable.rmpc
        sunvox
        # X11
        hsetroot
        nitrogen
        polybarFull
        rofi
        xcompmgr
        xdotool
        xorg.xev
        xorg.xwininfo
        yambar
        # misc
        catppuccin-sddm
        nmap
        steam-run
        uxn
    ];
}

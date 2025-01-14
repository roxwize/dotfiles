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
        git
        godot_4
        gtk4
        just
        meson
        nodejs_23
        pkg-config
        pnpm
        vala
        ## language servers
        mesonlsp             # Meson
        nil                  # Nix
        rust-analyzer        # Rust
        vala-language-server # Vala
        # games
        prismlauncher
        steam-run
        uxn
        # graphics
        flameshot
        gimp
        imagemagick
        krita
        maim
        # gtk
        posy-cursors
        pantheon.elementary-gtk-theme
        # internet
        nicotine-plus
        vesktop
        yt-dlp
        # system tools
        bat
        btop
        dconf-editor
        ffmpeg
        gparted
        home-manager
        hyfetch
        kitty
        monitor
        wine
        xclip
        zellij
        # text editors
        neovim
        vscodium
        # audio
        alsa-utils
        audacity
        mpc
        pavucontrol
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
    ];
}

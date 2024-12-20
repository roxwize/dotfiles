{ pkgs, ... }:
{
    environment.systemPackages = with pkgs; [
        # development
        (fenix.default.withComponents [ "cargo" "rustc" ])
        gtk4
        just
        meson
        nodejs_23
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
        # misc
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

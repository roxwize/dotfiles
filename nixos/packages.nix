{ pkgs, ... }:
{
    # I'm not sure if you actually need stuff like GTK4 to be
    # in here when it's really only used with nix-shell and the
    # amount of time it saves during installation is probably
    # only like a few seconds
    environment.systemPackages = with pkgs; [
        # development
        (fenix.default.withComponents [ "cargo" "rustc" ])
        gcc                                                      # GNU Compiler Collection, version 13.3.0 (wrapper script)
        git                                                      # Distributed version control system
        godot_4                                                  # Free and Open Source 2D and 3D game engine
        gtk4                                                     # Multi-platform toolkit for creating graphical user interfaces
        just                                                     # Handy way to save and run project-specific commands
        meson                                                    # Open source, fast and friendly build system made in Python
        nodejs_23                                                # Event-driven I/O framework for the V8 JavaScript engine
        pnpm                                                     # Fast, disk space efficient package manager for JavaScript
        vala                                                     # Compiler for GObject type system
        ## language servers
        mesonlsp             # Meson
        nil                  # Nix
        rust-analyzer        # Rust
        vala-language-server # Vala
        # games
        unstable.luanti                                          # An open source voxel game engine (formerly Minetest)
        prismlauncher                                            # Free, open source launcher for Minecraft
        steam-run                                                # Run commands in the same FHS environment that is used for Steam
        uxn                                                      # Assembler and emulator for the Uxn stack machine
        # graphics
        flameshot                                                # Powerful yet simple to use screenshot software
        gimp                                                     # GNU Image Manipulation Program
        imagemagick                                              # Software suite to create, edit, compose, or convert bitmap images
        krita                                                    # Free and open source painting application
        maim                                                     # Command-line screenshot utility
        # gtk
        posy-cursors                                             # Posy's Improved Cursors for Linux
        pantheon.elementary-gtk-theme                            # GTK theme designed to be smooth, attractive, fast, and usable
        # internet
        nicotine-plus                                            # Graphical client for the SoulSeek peer-to-peer system
        vesktop                                                  # Alternate client for Discord with Vencord built-in
        yt-dlp                                                   # Command-line tool to download videos from YouTube.com and other sites (youtube-dl fork)
        # system tools
        bat                                                      # Cat(1) clone with syntax highlighting and Git integration
        btop                                                     # Monitor of resources
        dconf-editor                                             # GSettings editor for GNOME
        ffmpeg                                                   # Complete, cross-platform solution to record, convert and stream audio and video
        gparted                                                  # Graphical disk partitioning tool
        home-manager                                             # Nix-based user environment configurator
        hyfetch                                                  # neofetch with pride flags <3
        kitty                                                    # Modern, hackable, featureful, OpenGL based terminal emulator
        monitor                                                  # Manage processes and monitor system resources
        wine                                                     # Open Source implementation of the Windows API on top of X, OpenGL, and Unix
        xclip                                                    # Tool to access the X clipboard from a console application
        zellij                                                   # Terminal workspace with batteries included
        # text editors
        neovim                                                   # Vim text editor fork focused on extensibility and agility
        vscodium                                                 # Open source source code editor developed by Microsoft for Windows, Linux and macOS (VS Code without MS branding/telemetry/licensing)
        # audio
        alsa-utils                                               # ALSA, the Advanced Linux Sound Architecture utils
        audacity                                                 # Sound editor with graphical UI
        mpc                                                      # Minimalist command line interface to MPD
        pavucontrol                                              # PulseAudio Volume Control
        playerctl                                                # Command-line utility and library for controlling media players that implement MPRIS
        reaper                                                   # Digital audio workstation
        unstable.rmpc                                            # TUI music player client for MPD with album art support via kitty image protocol
        sunvox                                                   # Small, fast and powerful modular synthesizer with pattern-based sequencer
        # X11
        hsetroot                                                 # Allows you to compose wallpapers ('root pixmaps') for X
        nitrogen                                                 # Wallpaper browser and setter for X11
        polybarFull                                              # Fast and easy-to-use tool for creating status bars
        rofi                                                     # Window switcher, run dialog and dmenu replacement
        xcompmgr                                                 #
        xdotool                                                  # Fake keyboard/mouse input, window management, and more
        xorg.xev                                                 #
        xorg.xwininfo                                            #
        yambar                                                   # Modular status panel for X11 and Wayland
        # misc
        catppuccin-sddm                                          # Soothing pastel theme for SDDM
        kdePackages.kdenlive                                     # Free and open source video editor, based on MLT Framework and KDE Frameworks
        nmap                                                     # Free and open source utility for network discovery and security auditing
    ];
}

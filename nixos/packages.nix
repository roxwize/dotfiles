{ pkgs, ... }: {
	# I'm not sure if you actually need stuff like GTK4 to be
	# in here when it's really only used with nix-shell and the
	# amount of time it saves during installation is probably
	# only like a few seconds
	environment.systemPackages = with pkgs; [
		# development
		bun                                                      # Incredibly fast JavaScript runtime, bundler, transpiler and package manager – all in one
		cc65                                                     # C compiler for processors of 6502 family
		chibicc-uxn                                              # A small C compiler... for uxn
		llvmPackages_19.clang-tools                              # Standalone command line tools for C++ development
		fasm                                                     # x86(-64) macro assembler to binary, MZ, PE, COFF, and ELF
		(fenix.default.withComponents [ "cargo" "rustc" ])
		gcc                                                      # GNU Compiler Collection, version 13.3.0 (wrapper script)
		git                                                      # Distributed version control system
		gnumake                                                  # Tool to control the generation of non-source files from sources
		godot_4                                                  # Free and Open Source 2D and 3D game engine
		gtk4                                                     # Multi-platform toolkit for creating graphical user interfaces
		jdk23                                                    # Open-source Java Development Kit
		just                                                     # Handy way to save and run project-specific commands
		meson                                                    # Open source, fast and friendly build system made in Python
		nodejs_23                                                # Event-driven I/O framework for the V8 JavaScript engine
		pnpm                                                     # Fast, disk space efficient package manager for JavaScript
		python313                                                # High-level dynamically-typed programming language
		vala                                                     # Compiler for GObject type system
		## language servers
		mesonlsp             # Meson
		nil                  # Nix
		rust-analyzer        # Rust
		vala-language-server # Vala
		# games
		alvr                                                     # Stream VR games from your PC to your headset via Wi-Fi
		easyrpg-player                                           # RPG Maker 2000/2003 and EasyRPG games interpreter
		unstable.luanti                                          # An open source voxel game engine (formerly Minetest)
		prismlauncher                                            # Free, open source launcher for Minecraft
		(retroarch.override {                                    # Multi-platform emulator frontend for libretro cores
			cores = with libretro; [
				blastem                                            	# Sega Genesis
				dosbox                                            	# MS-DOS
				easyrpg                                           	# RPG Maker 2000/2003
				mame                                              	# Arcade
				melonds                                           	# Nintendo DS
				mesen                                             	# Nintendo Entertainment System
				mgba                                              	# Game Boy Advance
				pcsx2                                             	# PlayStation 2
				ppsspp                                            	# PlayStation Portable
				snes9x                                            	# Super Nintendo Entertainment System
				yabause                                           	# Sega Saturn
			];
		})
		steam-run                                                # Run commands in the same FHS environment that is used for Steam
		uxn                                                      # Assembler and emulator for the Uxn stack machine
		x16                                                      # Official emulator of CommanderX16 8-bit computer
		x16-rom                                                  # ROM file for CommanderX16 8-bit computer
		ynodesktop                                               # A desktop client for Yume Nikki Online with Discord Rich Presence
		# graphics
		flameshot                                                # Powerful yet simple to use screenshot software
		gimp                                                     # GNU Image Manipulation Program
		imagemagick                                              # Software suite to create, edit, compose, or convert bitmap images
		krita                                                    # Free and open source painting application
		maim                                                     # Command-line screenshot utility
		# gtk
		posy-cursors                                             # Posy's Improved Cursors for Linux
		pantheon.elementary-gtk-theme                            # GTK theme designed to be smooth, attractive, fast, and usable
		# network
		cachix                                                   # Command-line client for Nix binary cache hosting
		ngrok                                                    # Allows you to expose a web server running on your local machine to the internet
		nicotine-plus                                            # Graphical client for the SoulSeek peer-to-peer system
		playit-agent                                             # The playit program
		qbittorrent                                              # Featureful free software BitTorrent client
		slack                                                    # Desktop client for Slack
		vesktop                                                  # Alternate client for Discord with Vencord built-in
		yt-dlp                                                   # Command-line tool to download videos from YouTube.com and other sites (youtube-dl fork)
		# system tools
		android-tools                                            # Android SDK platform tools
		bat                                                      # Cat(1) clone with syntax highlighting and Git integration
		btop                                                     # Monitor of resources
		dconf-editor                                             # GSettings editor for GNOME
		kdePackages.dolphin                                      # File manager by KDE
		ffmpeg                                                   # Complete, cross-platform solution to record, convert and stream audio and video
		kdePackages.filelight                                    # Quickly visualize your disk space usage
		gparted                                                  # Graphical disk partitioning tool
		home-manager                                             # Nix-based user environment configurator
		hyfetch                                                  # neofetch with pride flags <3
		kitty                                                    # Modern, hackable, featureful, OpenGL based terminal emulator
		monitor                                                  # Manage processes and monitor system resources
		timeshift                                                # System restore tool for Linux
		unzip                                                    # Extraction utility for archives compressed in .zip format
		usbutils                                                 # Tools for working with USB devices, such as lsusb
		wineWowPackages.stable                                   # Open Source implementation of the Windows API on top of X, OpenGL, and Unix
		xclip                                                    # Tool to access the X clipboard from a console application
		zellij                                                   # Terminal workspace with batteries included
		# text editors
		neovim                                                   # Vim text editor fork focused on extensibility and agility
		vscodium                                                 # Open source source code editor developed by Microsoft for Windows, Linux and macOS (VS Code without MS branding/telemetry/licensing)
		# audio
		alsa-utils                                               # ALSA, the Advanced Linux Sound Architecture utils
		audacity                                                 # Sound editor with graphical UI
		# TODO: consider getting rid of this (no mpd support makes me sad......)
    fooyin                                                   # Customisable music player
		mpc                                                      # Minimalist command line interface to MPD
		pavucontrol                                              # PulseAudio Volume Control
		playerctl                                                # Command-line utility and library for controlling media players that implement MPRIS
		reaper                                                   # Digital audio workstation
		unstable.rmpc                                            # TUI music player client for MPD with album art support via kitty image protocol
		sunvox                                                   # Small, fast and powerful modular synthesizer with pattern-based sequencer
#   vcv-rack                                                 # Open-source virtual modular synthesizer
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
		anki                                                     # Spaced repetition flashcard program
		catppuccin-sddm                                          # Soothing pastel theme for SDDM
		flips                                                    # Patcher for IPS and BPS files
		unstable.kdePackages.kdenlive                            # Free and open source video editor, based on MLT Framework and KDE Frameworks
		kicad-small                                              # Open Source Electronics Design Automation suite, without 3D models
		mlt                                                      #! Open source multimedia framework, designed for television broadcasting (This is fucking stupid)
		nmap                                                     # Free and open source utility for network discovery and security auditing
		obs-studio                                               # Free and open source software for video recording and live streaming
		qemu_kvm                                                 # Generic and open source machine emulator and virtualizer
		soteria                                                  # Polkit authentication agent written in GTK designed to be used with any desktop environment
		temurin-jre-bin-23                                       # Eclipse Temurin, prebuilt OpenJDK binary
		temurin-jre-bin-8                                        # Eclipse Temurin, prebuilt OpenJDK binary
		vlc                                                      # Cross-platform media player and streaming server
	];

	services.flatpak.packages = [
		"com.github._0negal.Viper"                               # Launcher and updater for the Titanfall|2 mod Northstar
		"com.github.tchx84.Flatseal"                             # Manage Flatpak permissions
		"net.davidotek.pupgui2"                                  # Install Wine- and Proton-based compatibility tools
		"net.mancubus.SLADE"                                     # It's a DOOM editor

		# Glorified roblox android wrapper ;w;
		{ flatpakref = "https://sober.vinegarhq.org/sober.flatpakref"; sha256 = "1pj8y1xhiwgbnhrr3yr3ybpfis9slrl73i0b1lc9q89vhip6ym2l"; }
	];
}

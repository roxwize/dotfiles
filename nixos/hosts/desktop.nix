{ config, pkgs, inputs, ... }: {
	imports = [
		inputs.nix-flatpak.nixosModules.nix-flatpak
		./base.nix
		../packages.nix
	];

	boot = {
		extraModulePackages = with config.boot.kernelPackages; [ v4l2loopback ];
		extraModprobeConfig = ''
			options v4l2loopback devices=1 video_nr=1 card_label="OBS Cam" exclusive_caps=1
		'';
		supportedFilesystems = [ "ntfs" ];
	};

	security.polkit.enable = true;

	networking.networkmanager.enable = true;

	programs = {
		dconf.enable = true;
		firefox.enable = true;
		fish.enable = true;
		gnupg.agent = {
			enable = true;
			enableSSHSupport = true;
		};
		nix-ld.enable = true;
		steam = {
			enable = true;
			remotePlay.openFirewall = true;
			dedicatedServer.openFirewall = true;
			localNetworkGameTransfers.openFirewall = true;
		};
		thunderbird = {
			enable = true;
			policies.DisableTelemetry = true;
		};
	};

	services = {
		# Xorg
		xserver = {
			enable = true;
			xkb.layout = "us";
			windowManager = {
				cwm.enable = true;
				openbox.enable = true;
				twm.enable = true;
			};
		};
		displayManager = {
			sddm = {
				enable = true;
				settings = {
					Autologin = {
						User = "rae";
						Session = "none+openbox";
					};
				};
				theme = "catppuccin-mocha";
			};
		};

		# Touchpad support
		libinput.enable = true;
		# Sound
		pipewire = {
			enable = true;
			alsa.enable = true;
			pulse.enable = true;
			jack.enable = true;
		};
		# CUPS printing
		#     Can be configured at http://127.0.0.1:631/
		#     Local printers are host-specific (see `hardware.printers`)
		#     Avahi enables IPP Everywhere
		printing.enable = true;
		avahi = {
			enable = true;
			nssmdns4 = true;
			openFirewall = true;
		};
		# misc
		blueman.enable = true;
		flatpak.enable = true;
	};

	hardware = {
		bluetooth = {
			enable = true;
			powerOnBoot = true;
		};
		opentabletdriver.enable = true;
	};

	xdg.portal = {
		enable = true;
		config = {
			common = {
				default = [ "gtk" ];
			};
		};
		extraPortals = with pkgs; [ xdg-desktop-portal-gtk ];
	};

	fonts = {
		enableDefaultPackages = true;
		fontconfig = {
			enable = true;
			defaultFonts = {
				emoji = [ "Twitter Color Emoji" "Noto Color Emoji" ];
				monospace = [ "Fira Code Light" ];
			};
		};
		packages = with pkgs; [
			fira-code
			gohufont
			nasin-nanpa
			noto-fonts
			noto-fonts-cjk-sans
			noto-fonts-emoji
			twemoji-color-font
		];
	};

	users.users.rae.shell = pkgs.fish;

	virtualisation.docker.enable = true;
}

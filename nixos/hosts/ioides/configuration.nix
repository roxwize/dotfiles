{ inputs, config, pkgs, ... }: {
	imports = [
		inputs.nix-flatpak.nixosModules.nix-flatpak
		./hardware-configuration.nix
		./packages.nix
		../base.nix
		../../modules/system
	];

	r5e.system = {
		graphics = {
			display.x11 = {
				enable = true;
				windowManagers = [ "twm" "openbox" ];
				displayManager.autologin = {
					enable = true;
					session = "none+openbox";
				};
			};
			hardwareAcceleration = {
				enable = true;
				intel = {
					# TODO: change these when you get to your desktop pc
					videoPlayback = {
						enable = true;
						package = pkgs.intel-vaapi-driver;
					};
					qsv = {
						enable = true;
						package = pkgs.intel-media-sdk;
					};
				};
				nvidia = {
					enable = true;
					# TODO: this also needs to be changed back to default on your desktop
					package = config.boot.kernelPackages.nvidiaPackages.legacy_390;
				};
			};
		};
	};

	boot = {
		binfmt.emulatedSystems = [ "aarch64-linux" ];
		extraModulePackages = with config.boot.kernelPackages; [ v4l2loopback ];
		extraModprobeConfig = ''
			options v4l2loopback devices=1 video_nr=1 card_label="OBS Cam" exclusive_caps=1
		'';
		loader = {
			efi = {
				canTouchEfiVariables = false;
				efiSysMountPoint = "/efi";
			};
			grub = {
				enable = true;
				efiSupport = true;
				efiInstallAsRemovable = true;
				devices = [ "nodev" ];
			};
		};
		supportedFilesystems = [ "ntfs" ];
	};

#	# Music pendrive
#	fileSystems."/mnt/world" = {
#		device = "/dev/disk/by-uuid/639bae80-0f5d-481c-ae4e-d2c70f754a1c";
#		fsType = "ext4";
#		neededForBoot = false;
#	};
#	# Big fucking thing
#	fileSystems."/mnt/rae2" = {
#		device = "/dev/disk/by-uuid/fbbcc72f-34af-425c-9151-ef8919a6ae07";
#		fsType = "ext4";
#		neededForBoot = false;
#	};

	networking = {
		firewall.allowedTCPPorts = [ 80 443 5900 8080 19132 25565 ];
		hosts = {
			"10.0.0.2" = [ "near" "near.local" ];
		};
		networkmanager.enable = true;
	};

	hardware = {
		bluetooth = {
			enable = true;
			powerOnBoot = true;
		};
		opentabletdriver.enable = true;
	};
	
	fonts = {
		enableDefaultPackages = true;
		fontconfig = {
			enable = true;
			defaultFonts = {
				emoji = [ "Twitter Color Emoji" "Noto Color Emoji" ];
				monospace = [ "Fira Code Light" ];
			};
			subpixel.rgba = "rgb";
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

	programs = {
		dconf.enable = true;
		firefox.enable = true;
		fish.enable = true;
		gnupg.agent = {
			enable = true;
			enableSSHSupport = true;
		};
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

	security.polkit.enable = true;

	xdg = {
		mime = {
			defaultApplications = let
				audio = [ "vlc.desktop" "org.fooyin.fooyin.desktop" ];
				browser = "firefox.desktop";
				image = [ "sxiv.desktop" "gimp.desktop" ];
				text = "nvim.desktop";
				video = "vlc.desktop";
			in {
				"application/json" = text;
				"application/x-c++src" = text;
				"application/x-shellscript" = "kitty-open.desktop";
				"application/x-xcf" = "gimp.desktop";
				"audio/flac" = audio;
				"audio/mp2" = audio;
				"audio/mp3" = audio;
				"audio/wav" = audio;
				"audio/x-vorbis" = audio;
				"audio/x-vorbis+ogg" = audio;
				"image/avif" = image;
				"image/bmp" = image;
				"image/gif" = image;
				"image/jpeg" = image;
				"image/png" = image;
				"image/svg+xml" = [ "sxiv.desktop" "nvim.desktop" ];
				"image/tiff" = image;
				"image/webp" = image;
				"inode/directory" = "org.kde.dolphin.desktop";
				"text/html" = browser;
				"text/markdown" = text;
				"text/plain" = text;
				"text/x-c" = text;
				"video/avi" = video;
				"video/mp4" = video;
				"video/quicktime" = video;
				"video/webm" = video;
				"video/x-matroska" = video;
				"x-scheme-handler/http" = browser;
				"x-scheme-handler/https" = browser;
				"x-scheme-handler/mailto" = "thunderbird.desktop";
			};
		};
		portal = {
			enable = true;
			config = {
				common = {
					default = [ "gtk" ];
				};
			};
			extraPortals = with pkgs; [ xdg-desktop-portal-gtk ];
		};
	};

	users.users.rae.shell = pkgs.fish;

	virtualisation.docker.enable = true;

	time.timeZone = "America/New_York";
	
	system.stateVersion = "24.11";
}


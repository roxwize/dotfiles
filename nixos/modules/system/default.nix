{ pkgs, lib, config, ... }: let
	cfg = config.r5e.system;
in with lib; {
	options.r5e.system = {
		graphics = {
			display.x11 = {
				enable = mkEnableOption "X11";
				windowManagers = {
					twm.enable = mkEnableOption "twm";
				};
				displayManager = {
					# enable = mkEnableOption "SDDM";
					autologin = {
						enable = mkEnableOption "SDDM autologin";
						user = mkOption {
							type = types.str;
							default = "rae";
						};
						session = mkOption {
							type = types.str;
							default = "none+twm";
						};
					};
				};
			};

			hardwareAcceleration = {
				enable = mkEnableOption "graphics acceleration";
				intel = {
					videoPlayback = {
						# TODO wiki.nixos.org/wiki/Intel_Graphics
						enable = mkEnableOption "accelerated video playback";
						package = mkPackageOption pkgs "intel-media-driver";
					};
					qsv = {
						enable = mkEnableOption "Intel Quick Sync Video";
						package = mkPackageOption pkgs "vpl-gpu-rt";
					};
				};
				nvidia = {
					enable = mkEnableOption "NVIDIA drivers";
					package = mkPackageOption config.boot.kernelPackages.nvidiaPackages "stable";
				};
			};
		};

		programs = {
			steam = {
				enable = mkEnableOption "Steam";
				openFirewall = mkOption {
					type = types.bool;
					default = false;
				};
			};
			thunderbird = {
				enable = mkEnableOption "Mozilla Thunderbird";
			};
		};
	};

	config = {
		environment = {
			sessionVariables = {
				LIBVA_DRIVER_NAME = mkIf cfg.graphics.hardwareAcceleration.intel.videoPlayback.enable
					(if cfg.graphics.hardwareAcceleration.intel.videoPlayback.package == pkgs.intel-vaapi-driver then "i965" else "iHD");
			};
		};

		hardware = {
			graphics = {
				enable = cfg.graphics.hardwareAcceleration.enable;
				extraPackages =
					optional cfg.graphics.hardwareAcceleration.intel.videoPlayback.enable cfg.graphics.hardwareAcceleration.intel.videoPlayback.package
					++ optional cfg.graphics.hardwareAcceleration.intel.qsv.enable cfg.graphics.hardwareAcceleration.intel.qsv.package;
			};
			nvidia = mkIf cfg.graphics.hardwareAcceleration.nvidia.enable {
				modesetting.enable = true;
				powerManagement = {
					enable = false;
					finegrained = false;
				};
				open = false;
				nvidiaSettings = true;
				package = cfg.graphics.hardwareAcceleration.nvidia.package;
			};
		};

		services = {
			xserver = {
				enable = cfg.graphics.display.x11.enable;
				xkb.layout = "us";
				windowManager = cfg.graphics.display.x11.windowManagers;
				videoDrivers = optional cfg.graphics.hardwareAcceleration.nvidia.enable "nvidia";
			};
			displayManager.sddm = {
				enable = cfg.graphics.display.x11.enable;
				settings.Autologin = mkIf cfg.graphics.display.x11.displayManager.autologin.enable {
					User = cfg.graphics.display.x11.displayManager.autologin.user;
					Session = cfg.graphics.display.x11.displayManager.autologin.session;
				};
			};
		};

		programs = {
			steam = {
				enable = cfg.programs.steam.enable;
				remotePlay.openFirewall = cfg.programs.steam.openFirewall;
				dedicatedServer.openFirewall = cfg.programs.steam.openFirewall;
				localNetworkGameTransfers.openFirewall = cfg.programs.steam.openFirewall;
			};
			thunderbird = {
				enable = cfg.programs.thunderbird.enable;
				policies.DisableTelemetry = true;
			};
		};
	};
}


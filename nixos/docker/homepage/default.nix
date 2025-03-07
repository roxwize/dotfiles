{ pkgs, lib, config, ... }: let
	cfg = config.r5e.containers.homepage;
	settingsFormat = pkgs.formats.yaml {};
in with lib; {
	options.r5e.containers.homepage = {
		enable = mkEnableOption "homepage";
		listenPort = mkOption {
			type = types.int;
			default = 3000;
		};
		openFirewall = mkOption {
			type = types.bool;
			default = false;
		};
		settings = mkOption {
			inherit (settingsFormat) type;
			description = "See https://gethomepage.dev/configs/settings/";
			default = {};
		};
		widgets = mkOption {
			inherit (settingsFormat) type;
			description = "See https://gethomepage.dev/widgets/";
			default = [];
		};
		imagesDir = mkOption {
			type = types.path;
			default = "";
		};
	};

	config = mkMerge [
		(import ./compose.nix { inherit pkgs lib; })
		{
			environment.etc = mkIf cfg.enable {
				"homepage-dashboard/settings.yaml".source = settingsFormat.generate "settings.yaml" cfg.settings;
				"homepage-dashboard/widgets.yaml".source = settingsFormat.generate "widgets.yaml" cfg.widgets;
			};

			networking.firewall = mkIf cfg.openFirewall {
				allowedTCPPorts = [ cfg.listenPort ];
			};
			
			virtualisation.oci-containers.containers.homepage = {
				ports = [ (builtins.toString cfg.listenPort + ":3000/tcp") ];
				volumes = mkIf (cfg.imagesDir != null) [ (builtins.toString cfg.imagesDir + ":/app/public/images:rw") ];
			};
		}
	];
}

{ pkgs, lib, config, ... }: let
	cfg = config.r5e.containers.homepage;
	settingsFormat = pkgs.formats.yaml {};
in {
	options.r5e.containers.homepage = {
		enable = lib.mkEnableOption "homepage";
		listenPort = {
			type = lib.types.int;
			default = 3000;
		};
		openFirewall = lib.mkOption {
			type = lib.types.bool;
			default = false;
		};
		settings = lib.mkOption {
			inherit (settingsFormat) type;
			description = "See https://gethomepage.dev/configs/settings/";
			default = {};
		};
		widgets = lib.mkOption {
			inherit (settingsFormat) type;
			description = "See https://gethomepage.dev/widgets/";
			default = [];
		};
		imagesDir = lib.mkOption {
			type = lib.types.path;
			default = "";
		}
	};

	config = lib.mkMerge [
		(import ./compose.nix { inherit pkgs lib; })
		{
			environment.etc = lib.mkIf cfg.enable {
				"homepage-dashboard/settings.yaml".source = settingsFormat.generate "settings.yaml" cfg.settings;
				"homepage-dashboard/widgets.yaml".source = settingsFormat.generate "widgets.yaml" cfg.widgets;
			};

			networking.firewall = lib.mkIf cfg.openFirewall {
				allowedTCPPorts = [ builtins.toString cfg.listenPort ];
			};
			
			virtualisation.oci-containers.containers.homepage = {
				ports = [ builtins.toString cfg.listenPort + ":3000/tcp" ];
				volumes = lib.mkIf cfg.imagesDir [ builtins.toString cfg.imagesDir + "/app/public/images:rw" ];
			};
		}
	];
}

{ pkgs, lib, config, ... }: let
	cfg = config.containers.homepage;
	settingsFormat = pkgs.formats.yaml;
in {
	options.containers.homepage = {
		enable = lib.mkEnableOption "homepage";
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
	};

	config = {
		inherit (./compose.nix);
		
		environment.etc = lib.mkIf cfg.enable {
			"homepage-dashboard/settings.yaml".source = settingsFormat.generate "settings.yaml" cfg.settings;
			"homepage-dashboard/widgets.yaml".source = settingsFormat.generate "widgets.yaml" cfg.widgets;
		};

		networking.firewall = lib.mkIf cfg.openFirewall {
			allowedTCPPorts = [ 3000 ];
		};
	};
}

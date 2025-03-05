{ pkgs, ... }: let
	cfg = options.containers.homepage;
	settingsFormat = pkgs.formats.yaml;
in {
	options.containers.homepage = {
		enable = mkEnableOption "homepage";
		widgets = mkOption {
			inherit (settingsFormat) type;
		};
	};

	config = {
		inherit (./compose.nix);
		
		environment.etc = lib.mkIf cfg.enable {
			"homepage-dashboard/widgets.yaml".source = settingsFormat.generate "widgets.yaml" cfg.widgets;
		};
	};
}

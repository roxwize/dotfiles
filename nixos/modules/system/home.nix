# TODO unimplemented
{ pkgs, config, lib, ... }: let
	cfg = config.r5e.home;
in with lib; {
	options.r5e.user = mkOption {
		type = types.attrsOf {
			wallpaper = mkOption {
				type = types.str;
				default = /home/rae/.dotfiles/assets/wallpapers/current;
			};
		};
		default = {};
	};

	config = {
		
	};
}


{ lib, config, ... }: with lib; let
	c = options.containers;
in {
	options.containers = {
		homepage = {
			#TODO: https://github.com/NixOS/nixpkgs/blob/nixos-24.11/nixos/modules/services/misc/homepage-dashboard.nix#L221
			enable = mkEnableOption "homepage";
		};
	};

	config = mkIf c.homepage import ./homepage;
}

{ inputs, pkgs, ... }: {
	nix = {
		package = pkgs.nix;
		settings = {
			experimental-features = [ "nix-command" "flakes" ];
			trusted-users = [ "root" "rae" ];
			substituters = [
				"https://nix-community.cachix.org"
				"https://cache.nixos.org/"
			];
			trusted-public-keys = [
				"nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
				"cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
			];
		};
	};
	nixpkgs = {
		config = {
			allowBroken = true;
			allowUnfree = true;
			nvidia.acceptLicense = true;
		};
		overlays = import ./overlays.nix inputs;
	};
}


{
	description = "rae's nixOS config flake";

	inputs = {
		nixpkgs.url = "github:nixos/nixpkgs/nixos-24.11";
		nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
		nix-flatpak.url = "github:gmodena/nix-flatpak/?ref=latest";
		home-manager = {
			url = "github:nix-community/home-manager/release-24.11";
			inputs.nixpkgs.follows = "nixpkgs";
		};
		# Nix User Repository
		nur = {
			url = "github:nix-community/NUR";
			inputs.nixpkgs.follows = "nixpkgs";
		};
		# Rust toolchains
		fenix = {
			url = "github:nix-community/fenix";
			inputs.nixpkgs.follows = "nixpkgs";
		};
		# Raspberry Pi support
		raspberry-pi-nix.url = "github:nix-community/raspberry-pi-nix";
	};

	outputs = { self, nixpkgs, home-manager, nix-flatpak, ... }@inputs: {
		nixosConfigurations = let
			mkSystem = hostname: arch: with nixpkgs; {
				name = hostname;
				value = lib.nixosSystem {
					system = "${arch}-linux";
					specialArgs = { inherit inputs; hostname = hostname; };
					modules = [ ./hosts/${hostname}/configuration.nix ];
				};
			};
		in builtins.listToAttrs [
			(mkSystem "ioides" "x86_64")    # main pc
			(mkSystem "near"   "aarch64")   # raspberry pi 5 home server
		];

		homeConfigurations.rae = home-manager.lib.homeManagerConfiguration {
			pkgs = nixpkgs.legacyPackages.x86_64-linux;
			extraSpecialArgs = { inherit inputs; };
			modules = [
				./home
			];
		};
	};
}


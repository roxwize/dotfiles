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
    };

    outputs = { self, nixpkgs, home-manager, nix-flatpak, ... }@inputs: {
        nixosConfigurations =
            let
                system = hostname: {
                    name = hostname;
                    value = nixpkgs.lib.nixosSystem {
                        system = "x86_64-linux";
                        specialArgs = { inherit inputs; };
                        modules = [
                            nix-flatpak.nixosModules.nix-flatpak
                            ./hosts/${hostname}/configuration.nix
                        ];
                    };
                };
            in builtins.listToAttrs [
                (system "ioides")
                (system "qemu")
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

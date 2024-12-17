{
    description = "rae's nixOS config flake";

    inputs = {
        nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
        home-manager = {
            url = "github:nix-community/home-manager";
            inputs.nixpkgs.follows = "nixpkgs";
        };
    };

    outputs = inputs@{ self, nixpkgs, home-manager, ... }: {
        nixosConfigurations = {
            qemu = nixpkgs.lib.nixosSystem {
                system = "x86_64-linux";
                specialArgs = { inherit inputs; };
                modules = [
                    ./hosts/qemu/configuration.nix
                    # home-manager.nixosModules.home-manager {
                    #     home-manager = {
                    #         useGlobalPkgs = true;
                    #         useUserPackages = true;
                    #         users.rae = import ./home.nix;
                    #     };
                    # }
                ];
            };
        };
    };
}

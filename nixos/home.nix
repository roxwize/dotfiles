{ pkgs, ... }:
let
    home-manager = builtins.fetchTarball "https://github.com/nix-community/home-manager/archive/release-24.11.tar.gz";
    plasma-manager = builtins.fetchTarball "https://github.com/nix-community/plasma-manager/archive/trunk.tar.gz";
in
{
    imports = [
        "${home-manager}/nixos"
        "${plasma-manager}/modules"
    ];

    home-manager.users.rae = {
        home.stateVersion = "24.11";

        programs = {
            git = {
                enable = true;
                userName = "roxwize";
                userEmail = "rae@roxwize.xyz";
            };
            plasma = {
                enable = true;
                panels = [
                    {
                        location = "top";
                        height = 32;
                        widgets = [
                            "org.kde.plasma.kickoff"
                            "org.kde.plasma.icontasks"
                            "org.kde.plasma.marginsseparator"
                            "org.kde.plasma.digitalclock"
                        ];
                    }
                ];
            };
        };
    };
};

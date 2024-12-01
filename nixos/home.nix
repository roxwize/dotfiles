{ pkgs, ... }:
let
    home-manager = builtins.fetchTarball "https://github.com/nix-community/home-manager/archive/release-24.11.tar.gz";
in
{
    imports = [
        "${home-manager}/nixos"
#         "${plasma-manager}/modules"
    ];

    home-manager.users.rae = {
        home = {
            stateVersion = "24.11";
            sessionVariables = {
                BROWSER = "firefox";
                EDITOR = "hx";
                TERM = "kitty";
            };
            file = {
                ".background-image".source = ../assets/wallpapers/bleh.png;
                ".twmrc".source = ../configs/twm;
                ".config/i3/config".source = ../configs/i3;
            };
        };

        programs = {
            git = {
                enable = true;
                userName = "roxwize";
                userEmail = "rae@roxwize.xyz";
            };
        };
    };
}

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
            file = {
                ".twmrc".source = ../.twmrc;
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

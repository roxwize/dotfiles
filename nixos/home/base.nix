{ pkgs, ... }:
{
    home = {
        stateVersion = "24.11";
        username = "rae";
        homeDirectory = "/home/rae";
        sessionVariables = {
            BROWSER = "firefox";
            TERM = "kitty";
        };
        file = {
            ".e16/backgrounds" = {
                source = ../../assets/wallpapers;
                recursive = true;
            };
            ".e16/themes" = {
                source = ../../assets/e16-themes;
                recursive = true;
            };
            ".twmrc".source = ../../configs/twm;
            ".local/share/themes".source = ../../configs/openbox/themes;
        };
    };
    xdg.configFile = {
        "openbox".source = ../../configs/openbox;
    };

    programs = {
        fish = {
            enable = true;
            shellInit = ''
                set -g fish_greeting
            '';
        };
        git = {
            enable = true;
            userName = "roxwize";
            userEmail = "rae@roxwize.xyz";
        };
        kitty = {
            enable = true;
            font.name = "Fira Code";
            themeFile = "mayukai";
        };
        rofi = {
            enable = true;
            font = "Fira Code Light 11";
            terminal = "${pkgs.kitty}/bin/kitty";
        };
        vscode = {
            enable = true;
            package = pkgs.vscodium;
            extensions = with pkgs.vscode-extensions; [
                editorconfig.editorconfig
                jnoortheen.nix-ide
                mesonbuild.mesonbuild
                rust-lang.rust-analyzer
                skellock.just
                wakatime.vscode-wakatime
            ];
        };
    };

    gtk = {
        enable = true;
        cursorTheme.name = "Posy's Cursor";
        theme.name = "io.elementary.stylesheet.blueberry";
    };
}

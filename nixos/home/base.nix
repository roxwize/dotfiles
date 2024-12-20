{ ... }:
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
        "nvim" = {
            source = ../../configs/neovim;
            recursive = true;
        };
        "openbox".source = ../../configs/openbox;
    };

    programs = {
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
    };

    gtk = {
        enable = true;
        cursorTheme.name = "Posy's Cursor";
        theme.name = "io.elementary.stylesheet.blueberry";
    };
}

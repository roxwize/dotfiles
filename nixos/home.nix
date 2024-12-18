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
            ".twmrc".source = ../configs/twm;
            ".local/share/themes".source = ../configs/openbox/themes;
        };
    };
    xdg.configFile = {
        "openbox".source = ../configs/openbox;
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
        neovim = {
            enable = true;
            defaultEditor = true;
            vimAlias = true;
            plugins = with pkgs.vimPlugins; [
                vim-just
                vim-wakatime
            ];
            extraLuaConfig = ''
                vim.opt["tabstop"] = 4
                vim.opt["shiftwidth"] = 4
            '';
        };
    };

    services = {
        polybar = {
            enable = true;
            script = "polybar &";
            settings =
            let
                background = "#0000";
                foreground = "#030910";
                color0 = "#d9eafd";
                color1 = "#bcccdc";
                color2 = "#9aa6b2";
            in {
                "global/wm" = {
                    margin-top = 2;
                    margin-bottom = 2;
                };
                "bar/top" = {
                    background = background;
                    foreground = foreground;
                    width = "100%";
                    height = 32;
                    font-0 = "GohuFont:style=Regular:size=14;3";
                    modules-left = "cpu memory";
                    modules-center = "xworkspaces";
                    modules-right = "battery audio date";
                    module-margin = 1;
                    offset-y = 14;
                    padding = 2;
                };

                "module/cpu" = {
                    type = "internal/cpu";
                    label = "CPU: %percentage%%";
                    label-background = color0;
                    label-padding = 2;
                    interval = 2;
                };
                "module/memory" = {
                    type = "internal/memory";
                    label = "RAM: %percentage_used%%";
                    label-background = color1;
                    label-padding = 2;
                    interval = 2;
                };
                "module/xwindow" = {
                    type = "internal/xwindow";
                    label-active-font = 0;
                };
                "module/xworkspaces" = {
                    type = "internal/xworkspaces";
                    enable-scroll = false;
                    label-active = "%name%";
                    label-active-background = color2;
                    label-active-padding = 1;
                    label-occupied = "%name%";
                    label-occupied-foreground = "#fff";
                    label-occupied-padding = 1;
                    label-empty = "%name%";
                    label-empty-foreground = "#fff";
                    label-empty-padding = 1;
                    label-urgent = "%name%";
                    label-urgent-background = color0;
                    label-urgent-padding = 1;
                };
                "module/audio" = {
                    type = "internal/pulseaudio";
                };
                "module/battery" = {
                    type = "internal/battery";
                    battery = "BAT0";
                    adapter = "ADP1";
                    label-charging = "BAT: %percentage%%++";
                    label-discharging = "BAT: %percentage%%";
                    label-background = color1;
                    label-padding = 2;
                };
                "module/date" = {
                    type = "internal/date";
                    date = "%b %d %y";
                    time = "%I:%M %p";
                    label-background = color0;
                    label-padding = 2;
                    interval = 5;
                };
            };
        };
    };

    dconf.settings = {
        "net/launchpad/plank/docks/dock1" = {
            dock-items = ["firefox.dockitem" "io.elementary.terminal.dockitem" "codium.dockitem" "io.elementary.settings.dockitem"];
        };
        "org/gnome/desktop/background" = {
            picture-uri = "file://" + builtins.toString /home/rae/.dotfiles/assets/wallpapers/current;
        };
        "org/gnome/desktop/wm/preferences" = {
            button-layout = ":minimize,maximize,close";
        };
    };

    gtk = {
        enable = true;
        cursorTheme.name = "Posy's Cursor";
        theme.name = "io.elementary.stylesheet.blueberry";
    };
}

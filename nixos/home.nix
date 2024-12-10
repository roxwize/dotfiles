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
                TERM = "kitty";
            };
            file = {
                ".background-image".source = ../assets/wallpapers/2kki_rainyapartments.png;
                ".twmrc".source = ../configs/twm;
                ".config/i3/config".source = ../configs/i3;

                ".config/openbox/autostart".source = ../configs/openbox/autostart;
                ".config/openbox/rc.xml".source = ../configs/openbox/rc.xml;
            };
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
                #theme = "Catppuccin-Latte";
            };
            neovim = {
                enable = true;
                defaultEditor = true;
                vimAlias = true;
                plugins = with pkgs.vimPlugins; [
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
                    background = "#00000000";
                    foreground = "#fff";
                    color0 = "#ff3b1c32";
                    color1 = "#ff6a1e55";
                    color2 = "#ffa64d79";
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
                        modules-center = "xwindow";
                        modules-right = "date";
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
                    "module/date" = {
                        type = "internal/date";
                        date = "%b %d %y";
                        time = "%I:%M %p";
                        label-background = color2;
                        label-padding = 2;
                        interval = 5;
                    };
                };
            };
        };
    };
}

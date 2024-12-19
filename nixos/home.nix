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
            ".e16" = {
                source = ../configs/e16;
                recursive = true;
            };
            ".twmrc".source = ../configs/twm;
            ".local/share/themes".source = ../configs/openbox/themes;
        };
    };
    xdg.configFile = {
        "openbox".source = ../configs/openbox;
    };

    programs = {
        firefox = {
            enable = true;
            profiles.default = {
                isDefault = true;
                extensions = with pkgs.nur.repos.rycee.firefox-addons; [
                    canvasblocker
                    catppuccin-gh-file-explorer
                    privacy-badger
                    stylus
                    ublock-origin
                    violentmonkey
                ];
                settings = {
                    "browser.newtabpage.activity-stream.default.sites" = "https://en.wikipedia.org/";
                    "browser.newtabpage.activity-stream.discoverystream.enabled" = false;
                    "browser.newtabpage.activity-stream.feeds.telemetry" = false;
                    "browser.newtabpage.activity-stream.improvesearch.topSiteSearchShortcuts.havePinned" = "";
                    "browser.newtabpage.activity-stream.newtabWallpapers.wallpaper" = "dark-beach";
                    "browser.newtabpage.activity-stream.showSponsored" = false;
                    "browser.newtabpage.activity-stream.showSponsoredTopSites" = false;
                    "browser.newtabpage.activity-stream.telemetry" = false;
                    "browser.newtabpage.activity-stream.topSitesRows" = 2;
                    "browser.newtabpage.pinned" = [
                        {
                            url = "https://discord.com/app/";
                            label = "Discord";
                        }
                        {
                            url = "https://pikidiary.lol/";
                            label = "PikiDiary";
                        }
                        {
                            url = "https://en.wikipedia.org/";
                            label = "Wikipedia";
                        }
                    ];
                    "datareporting.healthreport.uploadEnabled" = false;
                    "font.name.monospace.x-western" = "Fira Code";
                    "layout.css.prefers-color-scheme.content-override" = 0;
                };
                bookmarks = [
                    {
                        name = "NixOS search";
                        url = "https://search.nixos.org/packages";
                    }
                    {
                        name = "Home Manager search";
                        url = "https://home-manager-options.extranix.com/";
                    }
                    {
                        name = "NUR search";
                        url = "https://nur.nix-community.org/";
                    }
                    {
                        name = "NixOS wiki";
                        url = "https://nixos.wiki/";
                    }
                ];
                search = {
                    default = "DuckDuckGo";
                    engines = {
                        "Nix packages" = {
                            urls = [{
                                template = "https://search.nixos.org/packages";
                                params = [
                                    { name = "type"; value = "packages"; }
                                    { name = "query"; value = "{searchTerms}"; }
                                ];
                            }];
                            icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
                        };

                        "Bing".metaData.hidden = true;
                    };
                    order = [ "DuckDuckGo" "Nix packages" ];
                    force = true;
                };
            };
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
        "io/elementary/code/settings" = {
            font = "Fira Code Light 10";
            use-system-font = false;
        };
        "net/launchpad/plank/docks/dock1" = {
            dock-items = [
                "gala-multitaskingview.dockitem"
                "firefox.dockitem"
                "io.elementary.terminal.dockitem"
                "codium.dockitem"
                "io.elementary.settings.dockitem"
            ];
        };
        "org/gnome/desktop/background" = {
            picture-uri = "file://" + builtins.toString /home/rae/.dotfiles/assets/wallpapers/current;
        };
        "org/gnome/desktop/interface" = {
            accent-color = "blue";
            color-scheme = "prefer-dark";
        };
        "org/gnome/desktop/wm/preferences" = {
            button-layout = ":minimize,maximize,close";
        };
        "org/pantheon/desktop/gala/appearance" = {
            button-layout = ":minimize,maximize,close";
        };
        "org/pantheon/desktop/gala/behavior" = {
            hotcorner-bottomright = "show-workspace-view";
        };
    };

    gtk = {
        enable = true;
        cursorTheme.name = "Posy's Cursor";
        theme.name = "io.elementary.stylesheet.blueberry";
    };
}

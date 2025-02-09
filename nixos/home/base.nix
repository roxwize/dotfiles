{ pkgs, inputs, ... }: {
    nixpkgs.overlays = import ../overlays.nix inputs;

    home = {
        stateVersion = "24.11";
        username = "rae";
        homeDirectory = "/home/rae";
        sessionVariables = {
            BROWSER = "firefox";
            TERM = "kitty";
        };
        file = {
            ".twmrc".source = ../../configs/twm;
            ".local/share/themes".source = ../../configs/openbox/themes;
            #! dumb (see todo)
            ".local/share/PrismLauncher" = {
                source = ../../assets/minecraft;
                recursive = true;
            };
        };
    };
    xdg.configFile = {
        "openbox".source = ../../configs/openbox;
        "rmpc".source = ../../configs/rmpc;
    };

    accounts.email = {
        maildirBasePath = "mail";
        accounts.rae = rec {
            address = "rae@roxwize.xyz";
            realName = "Rae 5e";
            userName = address;
            gpg = {
                key = "6F92AED338D339DE14E7491C5B1A0FAB9BAB81EE";
                signByDefault = true;
            };
            imap = {
                host = "mail.privateemail.com";
                port = 993;
            };
            smtp = {
                host = imap.host;
                port = 465;
            };
            thunderbird.enable = true;
        };
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
            extraConfig = {
                core = {
                    editor = "nvim";
                };
            };
        };
        kitty = {
            enable = true;
            font.name = "Fira Code";
            themeFile = "mayukai";
        };
        password-store = {
            enable = true;
            settings = {
                PASSWORD_STORE_DIR = "/home/rae/.dotfiles/secrets";
                PASSWORD_STORE_KEY = "6F92AED338D339DE14E7491C5B1A0FAB9BAB81EE";
            };
        };
        rofi = {
            enable = true;
            font = "Fira Code Light 11";
            terminal = "kitty";
        };
    };

    services = {
        flameshot = {
            enable = true;
            settings = {
                General = {
                    disabledTrayIcon = true;
                    showStartupLaunchMessage = false;
                };
            };
        };
        mpd = {
            enable = true;
            musicDirectory = "/mnt/world/music";
            extraConfig = ''
                audio_output {
                    type "pipewire"
                    name "main"
                }
                log_file "/tmp/mpd.log"
            '';
        };
        mpdris2 = {
            enable = true;
            mpd.musicDirectory = "/mnt/world/music";
            multimediaKeys = true;
            notifications = true;
        };
        mpris-proxy.enable = true;
    };

    gtk = {
        enable = true;
        cursorTheme.name = "Posy's Cursor";
        theme.name = "io.elementary.stylesheet.blueberry";
    };
}

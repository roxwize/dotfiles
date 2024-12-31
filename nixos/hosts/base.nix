{ pkgs, ... }:
{
    imports = [
        ../packages.nix
    ];

    nix.settings.experimental-features = ["nix-command" "flakes"];
    nixpkgs.config.allowUnfree = true;

    networking.networkmanager.enable = true;

    programs = {
        dconf.enable = true;
        firefox.enable = true;
        fish.enable = true;
        gnupg.agent = {
            enable = true;
            enableSSHSupport = true;
        };
        steam = {
            enable = true;
            remotePlay.openFirewall = true;
            dedicatedServer.openFirewall = true;
            localNetworkGameTransfers.openFirewall = true;
        };
    };

    services = {
        # Xorg
        xserver = {
            enable = true;
            xkb.layout = "us";
            windowManager = {
                cwm.enable = true;
                openbox.enable = true;
                twm.enable = true;
            };
        };
        displayManager = {
            sddm = {
                enable = true;
                settings = {
                    Autologin = {
                        User = "rae";
                        Session = "none+openbox";
                    };
                };
                theme = "catppuccin-mocha";
            };
        };

        # Touchpad support
        libinput.enable = true;
        # Sound
        pipewire = {
            enable = true;
            alsa.enable = true;
            pulse.enable = true;
        };
        # Music directory is host-dependent
        #? Using ALSA when we're using pipewire??? <https://nixos.wiki/wiki/MPD#PipeWire>
        mpd = {
            enable = true;
            #? user = "rae";
            extraConfig = ''
                audio_output {
                    type "pipewire"
                    name "main"
                }
            '';
        };
        # CUPS printing
        printing.enable = true;
        # misc
        flatpak.enable = true;
        blueman.enable = true;
        openssh = {
            enable = true;
            knownHosts = {
                "git.sr.ht" = {
                    hostNames = [ "git.sr.ht" ];
                    publicKey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIMZvRd4EtM7R+IHVMWmDkVU3VLQTSwQDSAvW0t2Tkj60";
                };
                "github.com" = {
                    hostNames = [ "github.com" ];
                    publicKey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOMqqnkVzrm0SdG6UOoqKLsabgH5C9okWi0dh2l9GKJl";
                };
            };
        };
    };

    hardware = {
        bluetooth = {
            enable = true;
            powerOnBoot = true;
        };
    };

    systemd.services = {
        flatpak-repo = {
            wantedBy = [ "multi-user.target" ];
            path = [ pkgs.flatpak ];
            script = ''
                flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
            '';
        };
        # https://github.com/NixOS/nixpkgs/issues/102547#issuecomment-1016671189
        mpd.environment = {
            XDG_RUNTIME_DIR = "/run/user/1000";
        };
    };

    xdg.portal = {
        enable = true;
        config = {
            common = {
                default = [ "gtk "];
            };
        };
        extraPortals = with pkgs; [ xdg-desktop-portal-gtk ];
    };

    fonts = {
        enableDefaultPackages = true;
        fontconfig = {
            enable = true;
            defaultFonts = {
                emoji = [ "Twitter Color Emoji" "Noto Color Emoji" ];
                monospace = [ "Fira Code Light" ];
            };
        };
        packages = with pkgs; [
            fira-code
            gohufont
            noto-fonts
            noto-fonts-cjk-sans
            noto-fonts-emoji
            twemoji-color-font
        ];
    };

    users.users.rae = {
        isNormalUser = true;
        extraGroups = [ "wheel" ];
        hashedPassword = "$y$j9T$YPq.Kl8rss1JmJ5Vg6cHE/$2kdfzCkkhaO.I4u714EQnS/ZFert5byisiRVxtC.9G2";
        shell = pkgs.fish;
    };
}

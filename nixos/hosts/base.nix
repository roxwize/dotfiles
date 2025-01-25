{ config, pkgs, inputs, ... }:
{
    imports = [
        ../packages.nix
    ];

    boot = {
        extraModulePackages = with config.boot.kernelPackages; [ v4l2loopback ];
        extraModprobeConfig = ''
            options v4l2loopback devices=1 video_nr=1 card_label="OBS Cam" exclusive_caps=1
        '';
    };

    security.polkit.enable = true;

    nix.settings.experimental-features = [ "nix-command" "flakes" ];
    nixpkgs = {
        config.allowUnfree = true;
        overlays = import ../overlays.nix inputs;
    };

    networking.networkmanager.enable = true;

    users.users.rae = {
        isNormalUser = true;
        extraGroups = [ "wheel" "docker" ];
        hashedPassword = "$y$j9T$YPq.Kl8rss1JmJ5Vg6cHE/$2kdfzCkkhaO.I4u714EQnS/ZFert5byisiRVxtC.9G2";
        shell = pkgs.fish;
    };

    programs = {
        dconf.enable = true;
        firefox.enable = true;
        fish.enable = true;
        gnupg.agent = {
            enable = true;
            enableSSHSupport = true;
        };
        nix-ld.enable = true;
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
        # CUPS printing
        #     Can be configured at http://127.0.0.1:631/
        #     Local printers are host-specific (see `hardware.printers`)
        #     Avahi enables IPP Everywhere
        printing.enable = true;
        avahi = {
            enable = true;
            nssmdns4 = true;
            openFirewall = true;
        };
        # misc
        flatpak = {
            enable = true;
            packages = [
                "com.github.tchx84.Flatseal"
                { flatpakref = "https://sober.vinegarhq.org/sober.flatpakref"; sha256 = "1pj8y1xhiwgbnhrr3yr3ybpfis9slrl73i0b1lc9q89vhip6ym2l"; }
            ];
        };
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
                "verygay.world" = {
                    hostNames = [ "verygay.world" ];
                    publicKey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAICMql669TiEneexyQsUWfCo9ouEJwk3f21d9chpBqFge";
                };
            };
        };
    };

    hardware.bluetooth = {
        enable = true;
        powerOnBoot = true;
    };

    xdg.portal = {
        enable = true;
        config = {
            common = {
                default = [ "gtk" ];
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

    i18n.defaultLocale = "en_US.UTF-8";
    console = {
        font = "gr928-8x16-thin"; # https://adeverteuil.github.io/linux-console-fonts-screenshots/
        keyMap = "us";
    };

    virtualisation.docker.enable = true;
}

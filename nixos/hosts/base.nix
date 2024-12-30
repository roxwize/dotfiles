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
    };

    services = {
        # X11
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
        # OpenSSH
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
        # Sound
        pipewire = {
            enable = true;
            pulse.enable = true;
        };
        # CUPS printing
        printing.enable = true;
        # Flatpak
        flatpak.enable = true;
    };

    xdg.portal.enable = true;

    fonts = {
        enableDefaultPackages = true;
        fontconfig = {
            enable = true;
            defaultFonts = {
                emoji = [ "Twitter Color Emoji" "Noto Color Emoji" ];
                monospace = [ "Fira Code Light" ];
            };
            subpixel.rgba = "rgb";
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

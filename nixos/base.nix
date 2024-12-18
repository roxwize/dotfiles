{ pkgs, ... }:
{
    imports = [
        ./packages.nix
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
                openbox.enable = true;
                twm.enable = true;
            };
            desktopManager = {
                pantheon.enable = true;
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
            };
        };
        # desktopManager = {
        #     plasma6.enable = true;
        # };

        # Touchpad support
        libinput.enable = true;
        # OpenSSH
        openssh.enable = true;
        # Sound
        pipewire = {
            enable = true;
            pulse.enable = true;
        };
        # CUPS printing
        printing.enable = true;
    };

    fonts = {
        enableDefaultPackages = true;
        packages = with pkgs; [
            noto-fonts
            noto-fonts-cjk-sans
            noto-fonts-emoji
            fira-code
            gohufont
        ];
    };

    users.users.rae = {
        isNormalUser = true;
        extraGroups = [ "wheel" ];
        hashedPassword = "$y$j9T$YPq.Kl8rss1JmJ5Vg6cHE/$2kdfzCkkhaO.I4u714EQnS/ZFert5byisiRVxtC.9G2";
        shell = pkgs.fish;
    };
}

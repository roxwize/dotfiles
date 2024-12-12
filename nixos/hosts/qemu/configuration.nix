{ config, lib, pkgs, ... }:
{
    imports = [
        ./hardware-configuration.nix
        ../../home.nix
    ];

    boot.loader = {
        # efi.efiSysMountPoint = "/boot/efi";
        grub = {
            enable = true;
            device = "/dev/sda"; # or "nodev" for efi only
            # efiSupport = true;
            # efiInstallAsRemovable = true;
        };
    };

    networking = {
        hostName = "gayfurries";
        networkmanager.enable = true;
    };

    time.timeZone = "America/New_York";
    i18n.defaultLocale = "en_US.UTF-8";
    console = {
        font = "gr928-8x16-thin"; # t || https://adeverteuil.github.io/linux-console-fonts-screenshots/
        keyMap = "us";
        #  useXkbConfig = true; # use xkb.options in tty.
    };

    programs = {
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
                i3.enable = true;
                openbox.enable = true;
                twm.enable = true;
            };
            desktopManager = {
                xfce.enable = true;
            };
        };
        displayManager = {
            sddm.enable = true;
            defaultSession = "none+openbox";
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

    environment.systemPackages = with pkgs; [
        # system tools
        bat
        btop
        ffmpeg
        git
        gparted
        hyfetch
        imagemagick
        kitty
        xclip
        yt-dlp
        zellij
        # text editors
        neovim
        vscodium
        # X11
        hsetroot
        nitrogen
        polybar
        rofi
        xcompmgr
        # misc
        uxn
    ];

    # Open ports in the firewall.
    # networking.firewall.allowedTCPPorts = [ ... ];
    # networking.firewall.allowedUDPPorts = [ ... ];
    # Or disable the firewall altogether.
    # networking.firewall.enable = false;

    system.copySystemConfiguration = true;

    # This option defines the first version of NixOS you have installed on this particular machine,
    # and is used to maintain compatibility with application data (e.g. databases) created on older NixOS versions.
    #
    # Most users should NEVER change this value after the initial install, for any reason,
    # even if you've upgraded your system to a new NixOS release.
    #
    # This value does NOT affect the Nixpkgs version your packages and OS are pulled from,
    # so changing it will NOT upgrade your system - see https://nixos.org/manual/nixos/stable/#sec-upgrading for how
    # to actually do that.
    #
    # This value being lower than the current NixOS release does NOT mean your system is
    # out of date, out of support, or vulnerable.
    #
    # Do NOT change this value unless you have manually inspected all the changes it would make to your configuration,
    # and migrated your data accordingly.
    #
    # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
    system.stateVersion = "24.11"; # Did you read the comment?
}

{ config, lib, pkgs, ... }:
{
    imports = [
        ./hardware-configuration.nix
        ../../base.nix
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

    networking.hostName = "gayfurries";

    time.timeZone = "America/New_York";
    i18n.defaultLocale = "en_US.UTF-8";
    console = {
        font = "gr928-8x16-thin"; # t || https://adeverteuil.github.io/linux-console-fonts-screenshots/
        keyMap = "us";
        #  useXkbConfig = true; # use xkb.options in tty.
    };

    # Open ports in the firewall.
    # networking.firewall.allowedTCPPorts = [ ... ];
    # networking.firewall.allowedUDPPorts = [ ... ];
    # Or disable the firewall altogether.
    # networking.firewall.enable = false;

    system.stateVersion = "24.11";
}

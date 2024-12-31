{ config, lib, pkgs, ... }:
{
    imports = [
        ./hardware-configuration.nix
        ../base.nix
    ];

    boot.loader = {
        efi = {
            canTouchEfiVariables = false;
            efiSysMountPoint = "/efi";
        };
        grub = {
            enable = true;
            efiSupport = true;
            efiInstallAsRemovable = true;
            devices = [ "nodev" ];
        };
    };

    networking.hostName = "ioides";

    services.xserver.videoDrivers = [ "nvidia" ];
    hardware.nvidia = {
        modesetting.enable = true;
        powerManagement = {
            enable = false;
            finegrained = false;
        };
        open = false;
        nvidiaSettings = true;
        package = config.boot.kernelPackages.nvidiaPackages.stable;
    };
    fonts.fontconfig.subpixel.rgba = "rgb";

    time.timeZone = "America/New_York";
    i18n.defaultLocale = "en_US.UTF-8";
    console = {
        font = "gr928-8x16-thin";
        keyMap = "us";
    };

    system.stateVersion = "24.11";
}


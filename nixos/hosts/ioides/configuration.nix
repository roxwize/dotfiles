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

    # Music pendrive
    fileSystems."/mnt/world" = {
        device = "/dev/disk/by-uuid/639bae80-0f5d-481c-ae4e-d2c70f754a1c";
        fsType = "ext4";
        neededForBoot = false;
    };

    networking.hostName = "ioides";

    services = {
        xserver.videoDrivers = [ "nvidia" "modesetting" "fbdev" ];
    };
    hardware = {
        graphics = {
            enable = true;
            extraPackages = with pkgs; [
                intel-media-sdk
            ];
        };
        nvidia = {
            modesetting.enable = true;
            powerManagement = {
                enable = false;
                finegrained = false;
            };
            open = false;
            nvidiaSettings = true;
            package = config.boot.kernelPackages.nvidiaPackages.stable;
        };
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


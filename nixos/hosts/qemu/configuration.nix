{ ... }:
{
    imports = [
        ./hardware-configuration.nix
        ../../base.nix
    ];

    boot.loader = {
        grub = {
            enable = true;
            device = "/dev/sda";
        };
    };

    networking.hostName = "qemu";

    time.timeZone = "America/New_York";
    i18n.defaultLocale = "en_US.UTF-8";
    console = {
        font = "gr928-8x16-thin"; # t || https://adeverteuil.github.io/linux-console-fonts-screenshots/
        keyMap = "us";
    };

    system.stateVersion = "24.11";
}

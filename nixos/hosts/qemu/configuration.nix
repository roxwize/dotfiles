{ ... }:
{
    imports = [
        ./hardware-configuration.nix
        ../desktop.nix
    ];

    boot.loader = {
        grub = {
            enable = true;
            device = "/dev/sda";
        };
    };

    networking.hostName = "qemu";

    time.timeZone = "America/New_York";

    system.stateVersion = "24.11";
}

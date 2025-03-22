{ lib, config, pkgs, modulesPath, ... }:

{

  ## Hardware

  # Cross compile for aarch64
  nixpkgs.crossSystem.config = "aarch64-unknown-linux-gnu";

  # Use the raspberry Pi 5 kernel
  boot.kernelPackages = pkgs.linuxPackagesFor
    (pkgs.linux_rpi4.override
      { rpiVersion = 5;
        argsOverride.defconfig = "bcm2712_defconfig";
      });

  # Only add strictly necessary modules
  hardware.firmware = [ pkgs.raspberrypiWirelessFirmware ];
  boot.initrd.includeDefaultModules = false;
  boot.initrd.kernelModules = [ "ext4" "mmc_block" ];
  disabledModules =
    [ "${modulesPath}/profiles/all-hardware.nix"
      "${modulesPath}/profiles/base.nix"
    ];

  # Configure u-boot image
  boot.loader.grub.enable = false;
  boot.loader.generic-extlinux-compatible.enable = true;

  imports = [ "${modulesPath}/installer/sd-card/sd-image.nix" ];
  sdImage.populateFirmwareCommands =
    let
      uboot = pkgs.buildUBoot
        { defconfig = "rpi_arm64_config";
          extraMeta.platforms = [ "aarch64-linux" ];
          filesToInstall = [ "u-boot.bin" ];
        };

      config = pkgs.writeText "config.txt"
        ''
          avoid_warnings=1
          enable_uart=1
          kernel=u-boot.bin
        '';
    in
      ''
        cp ${uboot}/u-boot.bin firmware/u-boot.bin
        cp ${pkgs.raspberrypifw}/share/raspberrypi/boot/{bootcode.bin,fixup*.dat,start*.elf} firmware/
        cp ${pkgs.raspberrypi-armstubs}/armstub8-gic.bin firmware/armstub8-gic.bin
        cp ${pkgs.raspberrypifw}/share/raspberrypi/boot/bcm2712-rpi-5-b.dtb firmware/
        cp ${config} firmware/config.txt
      '';
  sdImage.populateRootCommands =
    ''
      mkdir -p ./files/boot
      ${config.boot.loader.generic-extlinux-compatible.populateCmd} -c ${config.system.build.toplevel} -d ./files/boot
    '';

}

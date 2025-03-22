{ config, pkgs, lib, modulesPath, ... }:

{

  ## System

  imports =
    [ ./hardware.nix
      "${modulesPath}/profiles/headless.nix"
    ];

  networking.hostName = "wilson";

  system.stateVersion = "23.11";

  # turn off screen 5min after boot
  boot.kernelParams = [ "consoleblank=300" ];

  nix.settings.experimental-features = [ "nix-command" ];


  ## Packages

  nixpkgs.overlays = lib.singleton (self: super:
    { # don't shadow procps, etc.
      busybox = lib.setPrio 20 super.busybox;
    });


  ## Environment

  i18n.defaultLocale = "en_GB.UTF-8";
  i18n.extraLocaleSettings.LC_TIME = "it_IT.UTF-8";

  time.timeZone = "Europe/Rome";

  environment.sessionVariables =
    { PATH = [ "$HOME/bin" ];
      XDG_CONFIG_HOME = "$HOME/etc";
      XDG_DATA_HOME   = "$HOME/var/lib";
      XDG_CACHE_HOME  = "$HOME/var/cache";
      EDITOR = "vi";
      LESS = "-RSic -j.5";
      ABDUCO_CMD = "ash";
      ABDUCO_SOCKET_DIR = "$XDG_RUNTIME_DIR";
      SYSTEMD_COLORS = "16";
      PS1 = ''\e[32m\u\e[0m@\e[33m\H \e[36m\w\n\e[34mλ\e[0m '';
    };

  environment.shellInit =
    ''
      # create XDG directories
      mkdir -p $XDG_CONFIG_HOME $XDG_DATA_HOME $XDG_CACHE_HOME $HOME/bin

      # some aliases
      alias l="ls -lh"
      alias e="$EDITOR"
      alias ip="ip -c"
    '';

  environment.systemPackages = with pkgs; [ abduco busybox ];


  ## Users

  users.users.rnhmjoj =
    { isNormalUser = true;
      shell        = "${pkgs.busybox}/bin/ash";
      extraGroups  = [ "wheel" ];
      openssh.authorizedKeys.keys = [ key ];
    };


  ## Security

  security.sudo.wheelNeedsPassword = false;

  # never interrupt host key generation
  systemd.services.openssh.serviceConfig.TimeoutStartSec = "infinity";

  services.openssh.enable = true;
  services.openssh.settings.PermitRootLogin = "no";

  nix.settings.trusted-users = [ "rnhmjoj" "root" ];


  ## Network

  networking.usePredictableInterfaceNames = false;

  # Bridges for wired to wireless
  networking.bridges.br0.interfaces = [ "eth0" ];

  # change MAC address
  networking.interfaces.eth0.macAddress = "00:68:eb:26:b2:42";
  networking.interfaces.br0.macAddress =  "00:68:eb:26:b2:43";

  # Enable forwarding packets
  boot.kernel.sysctl = {
    "net.ipv6.conf.all.forwarding" = 1;
    "net.ipv4.conf.all.forwarding" = 1;
  };

  # Create an access point
  services.hostapd.enable = true;
  services.hostapd.radios.wlan0 =
    { band = "5g";
      channel = 0;
      countryCode = "PA";
      wifi4.capabilities =
        [ "HT40+" "SHORT-GI-20" "SHORT-GI-40" "MAX-AMSDU-3839" "DSSS_CCK-40" ];
      wifi5.capabilities = [ "MAX-MPDU-3895" "SHORT-GI-80" "SU-BEAMFORMEE" ];
      wifi5.operatingChannelWidth = "80";
      networks.wlan0 =
        { ssid = "<ssid-here>";
          bssid = "f8:0d:ac:60:E0:f9";
          authentication.mode = "wpa2-sha1";
          authentication.wpaPassword = "<psk-here>";
          settings.bridge = "br0";
        };
    };


  ## Make the image small

  # disable nscd
  services.nscd.enable = false;
  system.nssModules = lib.mkForce [];

  # use chrony
  services.timesyncd.enable = false;
  services.chrony.enable = true;

  # disable systemd stuff
  services.dbus.enable = lib.mkForce false;
  systemd.coredump.enable = false;
  systemd.services.mount-pstore.enable = false;
  systemd.services.systemd-udev-settle.enable = false;
  systemd.services.systemd-hostnamed.enable   = false;

}

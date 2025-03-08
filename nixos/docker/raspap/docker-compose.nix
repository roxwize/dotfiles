# Auto-generated using compose2nix v0.3.1.
{ pkgs, lib, ... }:

{
  # Runtime
  virtualisation.docker = {
    enable = true;
    autoPrune.enable = true;
  };
  virtualisation.oci-containers.backend = "docker";

  # Containers
  virtualisation.oci-containers.containers."raspap" = {
    image = "ghcr.io/raspap/raspap-docker:latest";
    environment = {
      "RASPAP_COUNTRY" = "GB";
      "RASPAP_SSID" = "raspap-webgui";
      "RASPAP_SSID_PASS" = "ChangeMe";
      "RASPAP_WEBGUI_PASS" = "secret";
      "RASPAP_WEBGUI_PORT" = "80";
      "RASPAP_WEBGUI_USER" = "admin";
    };
    volumes = [
      "/sys/fs/cgroup:/sys/fs/cgroup:rw"
    ];
    ports = [
      "8081:8081/tcp"
    ];
    log-driver = "journald";
    extraOptions = [
      "--cap-add=SYS_ADMIN"
      "--network=host"
      "--privileged"
    ];
  };
  systemd.services."docker-raspap" = {
    serviceConfig = {
      Restart = lib.mkOverride 90 "always";
      RestartMaxDelaySec = lib.mkOverride 90 "1m";
      RestartSec = lib.mkOverride 90 "100ms";
      RestartSteps = lib.mkOverride 90 9;
    };
    partOf = [
      "docker-compose-raspap-root.target"
    ];
    wantedBy = [
      "docker-compose-raspap-root.target"
    ];
  };

  # Root service
  # When started, this will automatically create all resources and start
  # the containers. When stopped, this will teardown all resources.
  systemd.targets."docker-compose-raspap-root" = {
    unitConfig = {
      Description = "Root target generated by compose2nix.";
    };
    wantedBy = [ "multi-user.target" ];
  };
}

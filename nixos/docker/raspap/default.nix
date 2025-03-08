{ pkgs, lib, config, ... }: let
	cfg = config.r5e.containers.raspap;
in with lib; {
	options.r5e.containers.pihole = {
		enable = mkEnableOption "raspap";
		ssid = mkOption {
			type = types.str;
			default = "raspap-webgui";
		};
		password = mkOption {
			type = types.str;
			default = "ChangeMe";
		};
		country = mkOption {
			type = types.str;
			default = "US";
		};
		webgui = {
			username = mkOption {
				type = types.str;
				default = "admin";
			};
			password = mkOption {
				type = types.str;
				default = "secret";
			};
			listenPort = mkOption {
				type = types.int;
				default = 80;
			};
			openFirewall = mkOption {
				type = types.bool;
				default = false;
			};
		};
	};

	config = mkIf cfg.enable (mkMerge [
		(import ./docker-compose.nix { inherit pkgs lib; })
		{
			virtualisation.oci-containers.containers.pihole = {
				environment = {
					RASPAP_SSID = cfg.ssid;
					RASPAP_SSID_PASS = cfg.password;
					RASPAP_COUNTRY = cfg.country;
					RASPAP_WEBGUI_USER = cfg.webgui.username;
					RASPAP_WEBGUI_PASS = cfg.webgui.password;
					RASPAP_WEBGUI_PORT = cfg.webgui.listenPort;
				};
			};

			networking.firewall = mkIf cfg.webgui.openFirewall {
				allowedTCPPorts = [ cfg.webgui.listenPort ];
			};
		}
	]);
}

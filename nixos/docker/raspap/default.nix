{ pkgs, lib, config, ... }: let
	cfg = config.r5e.containers.raspap;
in with lib; {
	options.r5e.containers.raspap = {
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
		listenPort = mkOption {
			type = types.int;
			default = 8081;
		};
		openFirewall = mkOption {
			type = types.bool;
			default = false;
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
		};
	};

	config = mkIf cfg.enable (mkMerge [
		(import ./docker-compose.nix { inherit pkgs lib; })
		{
			virtualisation.oci-containers.containers.raspap = {
				ports = [
					(builtins.toString cfg.listenPort + ":8081/tcp")
				];
				environment = {
					RASPAP_SSID = cfg.ssid;
					RASPAP_SSID_PASS = cfg.password;
					RASPAP_COUNTRY = cfg.country;
					RASPAP_WEBGUI_USER = cfg.webgui.username;
					RASPAP_WEBGUI_PASS = cfg.webgui.password;
					RASPAP_WEBGUI_PORT = builtins.toString cfg.webgui.listenPort;
				};
			};

			networking.firewall = mkIf cfg.openFirewall {
				allowedTCPPorts = [ cfg.listenPort cfg.webgui.listenPort ];
			};
		}
	]);
}

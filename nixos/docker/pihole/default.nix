{ pkgs, lib, config, ... }: let
	cfg = config.r5e.containers.pihole;
in with lib; {
	options.r5e.containers.pihole = {
		enable = mkEnableOption "pihole";
		openFirewall = mkOption {
			type = types.bool;
			default = false;
		};
		api-password = mkOption {
			type = types.str;
			default = "";
		};
	};

	config = mkIf cfg.enable (mkMerge [
		(import ./docker-compose.nix { inherit pkgs lib; })
		{
			virtualisation.oci-containers.containers.pihole = {
				environment = {
					TZ = config.time.timeZone;
					FTLCONF_webserver_api_password = mkIf (cfg.api-password != "") cfg.api-password;
				};
			};

			networking.firewall = mkIf cfg.openFirewall {
				allowedTCPPorts = [ 53 80 443 ];
			};
		}
	]);
}
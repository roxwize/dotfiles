{ inputs, pkgs, lib, ... }: {
	imports = [
		inputs.raspberry-pi-nix.nixosModules.raspberry-pi
		inputs.raspberry-pi-nix.nixosModules.sd-image
		./hardware-configuration.nix
		../base.nix
		../../docker
	];

	users.users.root.openssh.authorizedKeys.keys = [
		"ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIPyZFWvrboUTM/dKzz5kQHEKjNqI410VJUGiVckhjOve rae@ioides"
	];

	programs.git.enable = true;
	virtualisation.docker.enable = true;
	r5e.containers = {
		pihole = {
			enable = false;
			openFirewall = true;
			listenPortHTTP = 8080;
			listenPortHTTPS = 8443;
		};
	};

	services = {
		dnsmasq = {
			enable = true;
			settings = {
				dhcp-range = [ "192.168.14.10,192.168.14.254,24h" ];
				interface = "wlan0";
			};
		};
		hostapd = {
			enable = true;
			radios.wlan0 = {
				band = "2g";
				channel = 7;
				countryCode = "US";
				networks.wlan0 = {
					ssid = "near [2.4ghz]";
					authentication = {
						mode = "wpa2-sha256";
						wpaPassword = "techcat8";
					};
				};
				settings = {
					ht_capab = lib.mkForce "[HT40][SHORT-GI-20]";
				};
			};
		};
	};

	networking = {
		# bridges.br0 = {
		# 	interfaces = [ "end0" "wlan0" ];
		# };
		defaultGateway.address = "10.0.0.1";
		firewall.allowedTCPPorts = [ 53 22 ];
		firewall.allowedUDPPorts = [ 53 67 68 ];
		hostName = "near";
		interfaces = {
			# br0 = {
			# 	ipv4.addresses = [
			# 		{
			# 			address = "10.0.0.2";
			# 			prefixLength = 24;
			# 		}
			# 	];
			# };
			end0.useDHCP = true;
			wlan0.useDHCP = true;
		};
		networkmanager.unmanaged = [ "interface-name:wlan*" ];
		useDHCP = false;
		wireless.enable = true;
	};

	environment.etc."wpa_supplicant.conf".text = "";

	time.timeZone = "America/New_York";

	system.stateVersion = "24.11";
}

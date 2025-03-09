{ inputs, pkgs, lib, ... }: {
	imports = [
		inputs.raspberry-pi-nix.nixosModules.raspberry-pi
		inputs.raspberry-pi-nix.nixosModules.sd-image
		./hardware-configuration.nix
		../base.nix
		../../docker
	];

	boot.kernel.sysctl = {
		"net.ipv4.ip_forward" = true;
	};

	users.users.root.openssh.authorizedKeys.keys = [
		"ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIPyZFWvrboUTM/dKzz5kQHEKjNqI410VJUGiVckhjOve rae@ioides"
	];

	programs.git.enable = true;
	virtualisation.docker.enable = true;
	r5e.containers = {
		pihole = {
			enable = true;
			dhcp.enable = false;
			listenPortHTTP = 8080;
			listenPortHTTPS = 8443;
			openFirewall = true;
		};
	};

	services = {
		hostapd = {
			enable = true;
			radios.wlan0 = {
				band = "2g";
				channel = 7;
				countryCode = "US";
				networks.wlan0 = {
					authentication = {
						mode = "wpa2-sha256";
						wpaPassword = "techcat8";
					};
					logLevel = 1;
					ssid = "near";
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
		firewall = {
			allowedTCPPorts = [ 22 ];
			extraCommands = ''
				iptables -t nat -A POSTROUTING -o end0 -j MASQUERADE
			'';
		};
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

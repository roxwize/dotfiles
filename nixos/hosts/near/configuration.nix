{ inputs, pkgs, lib, ... }: {
	imports = [
		inputs.raspberry-pi-nix.nixosModules.raspberry-pi
		inputs.raspberry-pi-nix.nixosModules.sd-image
		./hardware-configuration.nix
		../base.nix
		../../modules/docker
	];

	# Packet forwarding
	boot.kernel.sysctl = {
		"net.ipv6.conf.all.forwarding" = 1;
		"net.ipv4.conf.all.forwarding" = 1;
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
				band = "5g";
				channel = 32;
				countryCode = "US";
				networks.wlan0 = {
					authentication = {
						mode = "wpa2-sha1";
						wpaPassword = "techcat8";
					};
					bssid = "6e:00:6a:7c:f4:db";
					logLevel = 1;
					settings.bridge = "br0";
					ssid = "near";
				};
				wifi4.capabilities = [ "HT40+" "SHORT-GI-20" "SHORT-GI-40" "MAX-AMSDU-3839" "DSSS_CCK-40" ];
				wifi5 = {
					capabilities = [ "MAX-MPDU-3895" "SHORT-GI-80" "SU-BEAMFORMEE" ];
					operatingChannelWidth = "80";
				};
			};
		};
	};

	networking = {
		bridges.br0.interfaces = [ "end0" ];
		firewall = {
			allowedTCPPorts = [ 22 ];
			extraCommands = ''
				iptables -t nat -A POSTROUTING -o end0 -j MASQUERADE
			'';
		};
		interfaces = {
			br0 = {
				# ipv4.addresses = [
				# 	{
				# 		address = "10.0.0.2";
				# 		prefixLength = 24;
				# 	}
				# ];
				macAddress = "2c:cf:67:04:a4:b8";
			};
			end0.macAddress = "2c:cf:67:04:a4:b8";
		};
	};

	environment.etc."wpa_supplicant.conf".text = "";

	time.timeZone = "America/New_York";

	system.stateVersion = "24.11";
}

{ inputs, pkgs, ... }: {
	imports = [
		inputs.raspberry-pi-nix.nixosModules.raspberry-pi
		inputs.raspberry-pi-nix.nixosModules.sd-image
		./hardware-configuration.nix
		../base.nix
		../../docker
	];

	hardware.enableRedistributableFirmware = true;

	users.users.root.openssh.authorizedKeys.keys = [
		"ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIPyZFWvrboUTM/dKzz5kQHEKjNqI410VJUGiVckhjOve rae@ioides"
	];

	programs.git.enable = true;
	virtualisation.docker.enable = true;
	r5e.containers = {
		pihole = {
			enable = true;
			openFirewall = true;
			listenPortHTTP = 8081;
			listenPortHTTPS = 8443;
		};
	};

	services = {
		# dnsmasq = {
		# 	enable = true;
		# 	extraConfig = ''
		# 		interface=wlan0
		# 		bind-interfaces
		# 	'';
		# };
		hostapd = {
			enable = true;
			interface = "wlan0";
			hwMode = "g";
			ssid = "near";
			wpaPassphrase = "RjkVTYUZE08HN"; #! world readable
		};
	};

	networking = {
		bridges.br0.interfaces = [ "end0" "wlan0" ];
		firewall.allowedTCPPorts = [ 22 ];
		hostName = "near";
		networkmanager.unmanaged = [ "interface-name:wlan0" ];
		wireless.enable = true;
	};

	environment.systemPackages = with pkgs; [
		bridge-utils
		# dnsmasq
		git
		hostapd
	];

	time.timeZone = "America/New_York";

	system.stateVersion = "24.11";
}

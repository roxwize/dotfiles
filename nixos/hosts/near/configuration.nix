{ inputs, pkgs, ... }: {
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
			enable = true;
		};
	};

	networking = {
		hostName = "near";
		firewall.allowedTCPPorts = [ 22 ];
	};

	environment.systemPackages = with pkgs; [ git linux-wifi-hotspot ];

	time.timeZone = "America/New_York";

	system.stateVersion = "24.11";
}

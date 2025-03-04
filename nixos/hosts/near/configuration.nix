{ inputs, ... }: {
	imports = [
		inputs.raspberry-pi-nix.nixosModules.raspberry-pi
		inputs.raspberry-pi-nix.nixosModules.sd-image
		./hardware-configuration.nix
		../base.nix
	];

	users.users.root.openssh.authorizedKeys.keys = [
		"ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIPyZFWvrboUTM/dKzz5kQHEKjNqI410VJUGiVckhjOve rae@ioides"
	];

	services.openssh = {
		ports = [ 22 ];
		banner = "I won't hold it against you";
		settings = {
			PasswordAuthentication = true;
		};
	};

	networking = {
		hostName = "near";
		firewall.allowedTCPPorts = [ 22 ];
	};

	time.timeZone = "America/New_York";

	system.stateVersion = "24.11";
}

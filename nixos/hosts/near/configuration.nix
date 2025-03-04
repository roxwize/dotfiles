{ inputs, ... }: {
	imports = [
		inputs.raspberry-pi-nix.nixosModules.raspberry-pi
		inputs.raspberry-pi-nix.nixosModules.sd-image
		./hardware-configuration.nix
		../base.nix
	];

    networking.hostName = "near";

    time.timeZone = "America/New_York";

    system.stateVersion = "24.11";
}

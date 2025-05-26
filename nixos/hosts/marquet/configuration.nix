{ pkgs, ... }: {
	imports = [
		./hardware-configuration.nix
		../base.nix
		../../modules/system
	];

	r5e.system = {
		graphics = {
			display.x11 = {
				enable = true;
				windowManagers = {
					twm.enable = true;
				};
				displayManager.autologin = {
					enable = false;
					session = "none+twm";
				};
			};
			hardwareAcceleration = {
				enable = true;
				intel.videoPlayback = {
					enable = true;
					package = pkgs.intel-vaapi-driver;
				};
			};
		};
	};
}


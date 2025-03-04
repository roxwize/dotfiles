{ lib, ... }: {
	raspberry-pi-nix.board = "bcm2712"; # RPI5 64bit
	hardware.raspberry-pi.config.all = {
		base-dt-params = {
			BOOT_UART = { enable = true; value = 1; };
			uart_2ndstage = { enable = true; value = 1; };
		};
		dt-overlays = {
			disable-bt = { enable = true; params = {}; };
		};
	};
}

{ ... }: {
	raspberry-pi-nix.board = "bcm2712"; # RPI5 64bit
	hardware.raspberry-pi.config.all = let 
		o = k: v: {
			name = k;
			value = {
				enable = true;
				value = v;
			};
		};
	in {
		base-dt-params = builtins.listToAttrs [
			(o "BOOT_UART" 1)
			(o "uart_2ndstage" 1)
		];
		dt-overlays = builtins.listToAttrs [
			(o "disable-bt" {})
		];
	};
}

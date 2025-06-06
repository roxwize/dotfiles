{ nur, fenix, nixpkgs-unstable, ... }: [
	nur.overlays.default
	fenix.overlays.default
	(import ./pkgs/overlay.nix {})
	(final: prev: {
		unstable = import nixpkgs-unstable {
			system = prev.system;
		};
	})
]


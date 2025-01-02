{ nur, fenix, nixpkgs-unstable, ... }: [
    nur.overlays.default
    fenix.overlays.default
    (final: prev: {
        unstable = import nixpkgs-unstable {
            system = prev.system;
        };
    })
]

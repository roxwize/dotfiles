{ inputs, ... }: {
    [
        inputs.nur.overlays.default
        inputs.fenix.overlays.default
        (final: prev: {
            unstable = import inputs.nixpkgs-unstable {
                system = prev.system;
            };
        })
    ];
}

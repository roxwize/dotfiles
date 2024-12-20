{ inputs, ... }:
{
    nixpkgs.overlays = [
        inputs.nur.overlays.default
        inputs.fenix.overlays.default
    ];
}

let
  # pinned Nixpkgs version
  nixpkgs = builtins.fetchTarball
    { url = "https://github.com/NixOS/nixpkgs/archive/76612b17c0ce.tar.gz";
      sha256 = "03pmy2dv212mmxgcvwxinf3xy6m6zzr8ri71pda1lqggmll2na12";
    };

  nixos = import (nixpkgs + "/nixos") { configuration = ./configuration.nix; };
in
{
  inherit (nixos.config.system.build) sdImage;
  inherit (nixos) system pkgs config;
}

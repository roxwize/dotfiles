default:
    @just --list

rebuild host operation:
    sudo nixos-rebuild {{operation}} --flake ./nixos#{{host}}

home-rebuild operation:
    home-manager {{operation}} --flake ./nixos

switch host:
    just rebuild {{host}} switch
    just home-rebuild switch

clean:
    sudo nix-env --profile /nix/var/nix/profiles/system --delete-generations old
    nix-collect-garbage -d
    nix store optimise

# commit local changes and push to upstream
push:
    @git add .
    git commit -m "~"
    git push

# run `switch` on default host
sd:
    @just switch qemu

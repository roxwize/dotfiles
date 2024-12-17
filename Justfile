default:
    @just --list

rebuild host operation:
    @cd nixos/ && sudo nixos-rebuild {{operation}} --flake .#{{host}} && cd ..

switch host:
    @just rebuild {{host}} switch

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

{ ... }: {
    imports = [
        ./base.nix

        ./dconf.nix
        ./mozilla.nix
        ./neovim.nix
        ./vscode.nix
        ./yambar.nix
    ];
}


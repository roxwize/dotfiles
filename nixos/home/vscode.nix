{ pkgs, ... }: {
    programs.vscode = {
        enable = true;
        package = pkgs.vscodium;
        enableUpdateCheck = false;
        enableExtensionUpdateCheck = false;
        extensions = with pkgs.vscode-extensions; [
            catppuccin.catppuccin-vsc
            catppuccin.catppuccin-vsc-icons
            editorconfig.editorconfig
            esbenp.prettier-vscode
            jnoortheen.nix-ide
            llvm-vs-code-extensions.vscode-clangd
            mesonbuild.mesonbuild
            rust-lang.rust-analyzer
            skellock.just
            wakatime.vscode-wakatime
        ];
        userSettings = {
            "editor.fontFamily" = "'Fira Code Light', monospace";
          # "editor.fontLigatures" = true;
            "editor.formatOnSave" = false;
            "editor.indentSize" = 4;
            "editor.tabSize" = 4;
            "explorer.confirmDelete" = false;
            "explorer.confirmDragAndDrop" = false;
            "mesonbuild.buildFolder" = "build";
            "prettier.tabWidth" = 4;
            "prettier.trailingComma" = "none";
            "prettier.singleAttributePerLine" = false;
            "prettier.useEditorConfig" = true;
            "telemetry.telemetryLevel" = "off";
            "workbench.colorTheme" = "Catppuccin Frappé";
            "workbench.iconTheme" = "catppuccin-frappe";
        };
    };
}

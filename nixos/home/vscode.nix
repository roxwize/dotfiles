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
            ms-vscode.live-server
            rust-lang.rust-analyzer
            skellock.just
            vadimcn.vscode-lldb
            wakatime.vscode-wakatime
        ];
        userSettings = 
            let
                df = lang: formatter: {
                    name = "[" + lang + "]";
                    value = {
                        "editor.defaultFormatter" = formatter;
                    };
                };
            in {
                "editor.detectIndentation" = false;
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
                "prettier.useTabs" = true;
                "svelte.enable-ts-plugin" = true;
                "telemetry.telemetryLevel" = "off";
                "workbench.activityBar.iconClickBehavior" = "toggle";
                "workbench.activityBar.location" = "bottom";
                "workbench.colorTheme" = "Catppuccin Frappé";
                "workbench.iconTheme" = "catppuccin-frappe";
            } // builtins.listToAttrs [
                (df "css"        "esbenp.prettier-vscode")
                (df "html"       "esbenp.prettier-vscode")
                (df "typescript" "esbenp.prettier-vscode")
                (df "javascript" "esbenp.prettier-vscode")
            ];
    };
}

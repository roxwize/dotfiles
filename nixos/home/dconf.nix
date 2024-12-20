{ ... }:
{
    dconf.settings = {
        "io/elementary/code/settings" = {
            font = "Fira Code Light 10";
            use-system-font = false;
        };
        "net/launchpad/plank/docks/dock1" = {
            dock-items = [
                "gala-multitaskingview.dockitem"
                "firefox.dockitem"
                "io.elementary.terminal.dockitem"
                "codium.dockitem"
                "io.elementary.settings.dockitem"
            ];
        };
        "org/gnome/desktop/background" = {
            picture-uri = "file://" + builtins.toString /home/rae/.dotfiles/assets/wallpapers/current;
        };
        "org/gnome/desktop/interface" = {
            accent-color = "blue";
            color-scheme = "prefer-dark";
        };
        "org/gnome/desktop/wm/preferences" = {
            button-layout = ":minimize,maximize,close";
        };
        "org/pantheon/desktop/gala/appearance" = {
            button-layout = ":minimize,maximize,close";
        };
        "org/pantheon/desktop/gala/behavior" = {
            hotcorner-bottomright = "show-workspace-view";
        };
    };
}

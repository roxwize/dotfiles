{ ... }: {
	dconf.settings = {
		"ca/desrt/dconf-editor/Settings" = {
			show-warning = false;
		};
		"io/elementary/code/settings" = {
			font = "Fira Code Light 10";
			use-system-font = false;
		};
		"net/launchpad/plank/docks/dock1" = {
			dock-items = [
				"firefox.dockitem"
				"vesktop.dockitem"
				"steam.dockitem"
				"codium.dockitem"
				"kitty.dockitem"
				"dolphin.dockitem"
				"slack.dockitem"
				"thunderbird.dockitem"
				"gimp.dockitem"
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
		# You dont use pantheon anymore buddy...
		"org/pantheon/desktop/gala/behavior" = {
			hotcorner-bottomright = "show-workspace-view";
		};
	};
}


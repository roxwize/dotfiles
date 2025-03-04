{ inputs, pkgs, ... }: {
    nix.settings = {
        experimental-features = [ "nix-command" "flakes" ];
        trusted-users = [ "root" "rae" ];
    };
    nixpkgs = {
        config.allowUnfree = true;
        overlays = import ../overlays.nix inputs;
    };

	users.users.rae = {
		isNormalUser = true;
		extraGroups = [ "wheel" "docker" "jackaudio" ];
		hashedPassword = "$y$j9T$YPq.Kl8rss1JmJ5Vg6cHE/$2kdfzCkkhaO.I4u714EQnS/ZFert5byisiRVxtC.9G2";
	};

	i18n.defaultLocale = "en_US.UTF-8";
	console = {
		font = "gr928-8x16-thin"; # https://adeverteuil.github.io/linux-console-fonts-screenshots/
		keyMap = "us";
	};
}
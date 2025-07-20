{ inputs, hostname, pkgs, ... }: {
	nix.settings = {
		experimental-features = [ "nix-command" "flakes" ];
		trusted-users = [ "root" "rae" ];
		substituters = [
			"https://nix-community.cachix.org"
			"https://cache.nixos.org/"
		];
		trusted-public-keys = [
			"nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
		];
	};
	nixpkgs = {
		config = {
			allowBroken = true;
			allowUnfree = true;
			nvidia.acceptLicense = true;
		};
		overlays = import ../overlays.nix inputs;
	};

	networking.hostName = hostname;

	users.users.rae = {
		isNormalUser = true;
		extraGroups = [ "wheel" "docker" "jackaudio" ];
		hashedPassword = "$y$j9T$YPq.Kl8rss1JmJ5Vg6cHE/$2kdfzCkkhaO.I4u714EQnS/ZFert5byisiRVxtC.9G2";
	};

	programs.nix-ld.enable = true;
	services.openssh = {
		enable = true;
		knownHosts =
			let
				host = name: key: {
					name = name;
					value = {
						hostNames = [ name ];
						publicKey = key;
					};
				};
			in builtins.listToAttrs [
				(host "git.sr.ht" "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIMZvRd4EtM7R+IHVMWmDkVU3VLQTSwQDSAvW0t2Tkj60")
				(host "github.com" "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOMqqnkVzrm0SdG6UOoqKLsabgH5C9okWi0dh2l9GKJl")
				(host "hackclub.app" "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJ3pezDUZG+4bPRZg2znAuuMp42AL+rc1HGUltnNf8cA")
				(host "verygay.world" "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAICMql669TiEneexyQsUWfCo9ouEJwk3f21d9chpBqFge")
			];
	};

	i18n.defaultLocale = "en_US.UTF-8";
	console = {
		font = "gr928-8x16-thin"; # https://adeverteuil.github.io/linux-console-fonts-screenshots/
		keyMap = "us";
	};
}

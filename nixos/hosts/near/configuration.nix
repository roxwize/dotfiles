{ inputs, pkgs, ... }: {
	imports = [
		inputs.raspberry-pi-nix.nixosModules.raspberry-pi
		inputs.raspberry-pi-nix.nixosModules.sd-image
		./hardware-configuration.nix
		../base.nix
	];

	users.users.root.openssh.authorizedKeys.keys = [
		"ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIPyZFWvrboUTM/dKzz5kQHEKjNqI410VJUGiVckhjOve rae@ioides"
	];

	programs.git.enable = true;
	virtualisation.docker.enable = true;

	services = {
		homepage-dashboard = {
			enable = true;
			listenPort = 80;
			openFirewall = true;
			settings = {
				title = "near";
				theme = "dark";
				color = "violet";
				headerStyle = "clean";
				target = "_self";
				quickLaunch.provider = "duckduckgo";
			};
			widgets = [
				{
					search.provider = "duckduckgo";
				}
				{
					resources = {
						cpu = true;
						memory = true;
						disk = "/";
						uptime = true;
						network = true;
					};
				}
				{
					openmeteo = {
						label = "Jacksonville";
						latitude = 30.3321838;
						longitude = -81.655651;
						timezone = "America/New_York";
						units = "imperial";
					};
				}
			];
		};
		openssh = {
			ports = [ 22 ];
			banner = "I won't hold it against you";
			settings = {
				PasswordAuthentication = false;
			};
		};
	};

	networking = {
		hostName = "near";
		firewall.allowedTCPPorts = [ 22 ];
		#! TODO: webkitgtk seems to be a cache miss (alongside SDL and openal) which makes this take FOREVER to build
		# networkmanager = {
		# 	enable = true;
		# };
	};

	environment.systemPackages = with pkgs; [ git ];

	time.timeZone = "America/New_York";

	system.stateVersion = "24.11";
}

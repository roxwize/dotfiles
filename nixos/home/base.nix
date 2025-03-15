{ pkgs, inputs, ... }: {
	nixpkgs.overlays = import ../overlays.nix inputs;

	home = {
		stateVersion = "24.11";
		username = "rae";
		homeDirectory = "/home/rae";
		sessionVariables = {
			BROWSER = "firefox";
			TERM = "kitty";
		};
		file = {
			".twmrc".source = ../../configs/twm;
			".local/share/themes".source = ../../configs/openbox/themes;
			#! dumb (see todo)
			".local/share/PrismLauncher" = {
				source = ../../assets/minecraft;
				recursive = true;
			};
		};
	};
	xdg.configFile = {
		"openbox".source = ../../configs/openbox;
		"rmpc".source = ../../configs/rmpc;
	};

	accounts.email = {
		maildirBasePath = "mail";
		accounts.rae = rec {
			primary = true;
			address = "rae@roxwize.xyz";
			realName = "Rae 5e";
			userName = address;
			passwordCommand = "pass show mail/rae";
			signature = {
				showSignature = "append";
				text = "rae <roxwize.xyz>";
				delimiter = "~~~~";
			};
			gpg = {
				key = "6F92AED338D339DE14E7491C5B1A0FAB9BAB81EE";
				signByDefault = true;
			};

			imap = {
				host = "mail.privateemail.com";
				port = 993;
			};
			smtp = {
				host = imap.host;
				port = 465;
			};

			thunderbird.enable = true;
		};
	};

	programs = {
		fish = {
			enable = true;
			shellInit = ''
				set -g fish_greeting
			'';
			plugins = [
				{
					name = "fishline";
					src = pkgs.fetchFromGitHub {
						owner = "0rax";
						repo = "fishline";
						rev = "v3.3.0";
						sha256 = "0j14nvhbz80pfkyzmwmj8x5b4pbngg9z4w04c6qrx3fip8fv70im";
					};
				}
			];
		};
		git = {
			enable = true;
			userName = "roxwize";
			userEmail = "rae@roxwize.xyz";
			extraConfig = {
				core = {
					editor = "nvim";
				};
			};
		};
		kitty = {
			enable = true;
			font = {
				name = "GohuFont";
				size = 10.5;
			};
			themeFile = "mayukai";
		};
		password-store = {
			enable = true;
			settings = {
				PASSWORD_STORE_DIR = "/home/rae/.dotfiles/secrets";
				PASSWORD_STORE_KEY = "6F92AED338D339DE14E7491C5B1A0FAB9BAB81EE";
			};
		};
		rofi = {
			enable = true;
			font = "Fira Code Light 11";
			terminal = "kitty";
			pass = {
				enable = true;
				stores = [ "/home/rae/.dotfiles/secrets" ];
			};
		};
		tiny = {
			enable = true;
			settings = {
				defaults = {
					nicks = [ "roxwize" ];
					notify = "mentions";
					realname = "rae 5e";
				};
				key_map = {
					ctrl_alt_left = "tab_prev";
					ctrl_alt_right = "tab_next";
				};
				layout = "aligned";
				log_dir = "/tmp/tinylog";
				servers = [
					{
						addr = "irc.libera.chat";
						join = [
							"#wikipedia-en"
							"#wikipedia-abstract"
							"#libera"
						];
						nicks = [ "roxwize" ];
						port = 6697;
						realname = "rae 5e";
						sasl = {
							username = "roxwize";
							password.command = "pass show libera_chat";
						};
						tls = true;
					}
				];
				scrollback = 65535;
			};
		};
	};

	services = {
		flameshot = {
			enable = true;
			settings = {
				General = {
					disabledTrayIcon = true;
					showStartupLaunchMessage = false;
				};
			};
		};
		mpd = {
			enable = true;
			musicDirectory = "/mnt/world/music";
			extraConfig = ''
				audio_output {
					type "pipewire"
					name "main"
				}
				log_file "/tmp/mpd.log"
			'';
		};
		mpdris2 = {
			enable = true;
			mpd.musicDirectory = "/mnt/world/music";
			multimediaKeys = true;
			notifications = true;
		};
		mpris-proxy.enable = true;
	};

	gtk = {
		enable = true;
		cursorTheme.name = "Posy's Cursor";
		theme.name = "io.elementary.stylesheet.blueberry";
	};
}

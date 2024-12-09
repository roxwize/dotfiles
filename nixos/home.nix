{ pkgs, ... }:
let
    home-manager = builtins.fetchTarball "https://github.com/nix-community/home-manager/archive/release-24.11.tar.gz";
in
{
    imports = [
        "${home-manager}/nixos"
#         "${plasma-manager}/modules"
    ];

    home-manager.users.rae = {
        home = {
            stateVersion = "24.11";
            sessionVariables = {
                BROWSER = "firefox";
                TERM = "kitty";
            };
            file = {
                ".background-image".source = ../assets/wallpapers/2kki_rainyapartments.png;
                ".twmrc".source = ../configs/twm;
                ".config/i3/config".source = ../configs/i3;
            };
        };

        programs = {
            git = {
                enable = true;
                userName = "roxwize";
                userEmail = "rae@roxwize.xyz";
            };
            kitty = {
                enable = true;
				font.name = "Fira Code";
                #theme = "Catppuccin-Latte";
            };
            neovim = {
                enable = true;
				defaultEditor = true;
				vimAlias = true;
                plugins = with pkgs.vimPlugins; [
                    vim-wakatime
                ];
				extraLuaConfig = ''
                	vim.opt["tabstop"] = 4
		    		vim.opt["shiftwidth"] = 4
				'';
            };
        };

		services = {
            polybar = {
                enable = true;
				script = "polybar &";
				settings = {
		    		"global/wm" = {
						font-0 = "GohuFont:style=Regular;antialias=false";
                        margin-top = 5;
						margin-bottom = 5;
		    		};
		    		"bar/top" = {
                        modules-left = "cpu memory";
		        		modules-center = "xwindow";
		        		modules-right = "date";
		    		};

		   			"module/cpu" = {
                        type = "internal/cpu";
						label = "CPU: %percentage%%";
						interval = 2;
		    		};
		    		"module/memory" = {
                        type = "internal/memory";
						label = "RAM: %percentage_used%%";
						interval = 2;
		    		};
		    		"module/xwindow" = {
                        type = "internal/xwindow";
						label-active-font = 0;
		    		};
		    		"module/date" = {
                        type = "internal/date";
						date = "%b %d %y";
						time = "%I:%M %p";
						interval = 5;
		    		};
				};
	    	};
		};
    };
}

{ pkgs, ... }: {
	programs.yambar = {
		enable = true;
		settings = {
			bar = {
				location = "top";
				height = 18;
				background = "00000088";
				font = "GohuFont:style=Regular:pixelsize=11";
				margin = 16;
				spacing = 3;

				left = [
					{
						# https://codeberg.org/dnkl/yambar/issues/53#issuecomment-264088
						# nixos ONLY ignores indentations in strings if they're spaces. stupid fucking piece of shit.
						# "Supporting tabs is wrong" MY ASS. supporting tabs is right. i can understand if you use
						# spaces but if you actively call them "outlawed" (yaml) and make them seem impractical or strange
						# then im sorry but i am going to smite you with the wrath of GOD. FUCK!!
						# i refuse to concede. i will simply not indent the offending line at all. dickweeds
						script = {
							path = "${pkgs.playerctl}/bin/playerctl";
							args = [
								"--follow"
								"metadata"
								"--format"
								"status|string|{{status}}\nartist|string|{{artist}}\ntitle|string|{{title}}\n"
							];
							content.map.conditions = {
								"status == Playing && artist != \"\"" = {
									string.text = "{artist} - {title}";
								};
								"status == Playing && artist == \"\"" = {
									string.text = "{title}";
								};
								"status != Playing" = {
									string.text = "god's in his heaven | all's right with the world";
								};
							};
						};
					}
				];
				center = [
					{
						script = {
							path = builtins.toString ../../scripts/arvelie.py;
							args = [ "-y" ];
							poll-interval = 30 * 1000; # TODO maybe try to see if you can sync this with the changing of the day...
							content.string.text = "{date}";
						};
					}
				];
				right = [
					{
						battery = {
							name = "BAT0";
							content.map.conditions."state != unknown".string.text = "bat {capacity}% |";
						};
					}
					{
						pipewire = {
							content.map.conditions."type == sink".string = {
								text = "vol {cubic_volume}% |";
								on-click = {
									left = "pavucontrol";
									wheel-up = "amixer sset Master 1%+";
									wheel-down = "amixer sset Master 1%-";
								};
							};
						};
					}
					{
						cpu = {
							poll-interval = 2000;
							content.map.conditions."id < 0".string.text = "cpu {cpu}%";
						};
					}
					{
						mem = {
							poll-interval = 2000;
							content.string.text = "ram {percent_used}% |";
						};
					}
					{
						clock = {
							date-format = "%d %b %y";
							time-format = "%H:%M";
							content.string.text = "{date} {time}";
						};
					}
				];
			};
		};
	};
}

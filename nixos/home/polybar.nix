{ ... }:
{
    services.polybar = {
        enable = true;
        script = "polybar &";
        settings =
        let
            background = "#0000";
            foreground = "#030910";
            color0 = "#d9eafd";
            color1 = "#bcccdc";
            color2 = "#9aa6b2";
        in {
            "global/wm" = {
                margin-top = 2;
                margin-bottom = 2;
            };
            "bar/top" = {
                background = background;
                foreground = foreground;
                width = "100%";
                height = 32;
                font-0 = "GohuFont:style=Regular:size=14;3";
                modules-left = "xworkspaces";
                modules-right = "cpu memory date";
                module-margin = 1;
                offset-y = 14;
                padding = 2;
            };

            "module/cpu" = {
                type = "internal/cpu";
                label = "CPU: %percentage%%";
                label-background = color0;
                label-padding = 2;
                interval = 2;
            };
            "module/memory" = {
                type = "internal/memory";
                label = "RAM: %percentage_used%%";
                label-background = color1;
                label-padding = 2;
                interval = 2;
            };
            "module/xwindow" = {
                type = "internal/xwindow";
                label-active-font = 0;
            };
            "module/xworkspaces" = {
                type = "internal/xworkspaces";
                enable-scroll = false;
                label-active = "%name%";
                label-active-background = color2;
                label-active-padding = 1;
                label-occupied = "%name%";
                label-occupied-foreground = "#fff";
                label-occupied-padding = 1;
                label-empty = "%name%";
                label-empty-foreground = "#fff";
                label-empty-padding = 1;
                label-urgent = "%name%";
                label-urgent-background = color0;
                label-urgent-padding = 1;
            };
            "module/audio" = {
                type = "internal/pulseaudio";
            };
            "module/battery" = {
                type = "internal/battery";
                battery = "BAT0";
                adapter = "ADP1";
                label-charging = "BAT: %percentage%%++";
                label-discharging = "BAT: %percentage%%";
                label-background = color1;
                label-padding = 2;
            };
            "module/date" = {
                type = "internal/date";
                date = "%b %d %y";
                time = "%I:%M %p";
                label-background = color0;
                label-padding = 2;
                interval = 5;
            };
        };
    };
}

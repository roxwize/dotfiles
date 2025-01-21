{ ... }: {
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
                font-0 = "GohuFont:style=Regular:size=11:antialias=false;3";
                modules-left = "xworkspaces audio";
                modules-right = "cpu memory date";
                module-margin = 1;
                offset-y = 14;
                padding = 2;
                bottom = true;
                dpi-x = 96;
                dpi-y = 96;
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
                label-active-background = color1;
                label-active-padding = 1;
                label-occupied = "%name%";
                label-occupied-background = color2;
                label-occupied-padding = 1;
                label-empty = "%name%";
                label-empty-foreground = "#fff";
                label-empty-padding = 1;
                label-urgent = "%name%";
                label-urgent-background = color0;
                label-urgent-padding = 1;
            };
            "module/audio" = {
                type = "internal/alsa";
                master-soundcard = "hw:1";
                master-mixer = "Master";
                format-volume = "<label-volume>";
                format-muted = "<label-muted>";
                label-volume = "VOL: %percentage%%";
                label-muted = "VOL: 0%";
                label-volume-background = color0;
                label-volume-padding = 2;
                label-muted-background = color0;
                label-muted-padding = 2;
                click-right = "pavucontrol";
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
                label-background = color2;
                label-padding = 2;
                interval = 5;
            };
        };
    };
}

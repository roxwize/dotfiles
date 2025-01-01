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
                        label = {
                            content.string.text = "god's in his heaven | all's right with the world";
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
                                text = "vol {linear_volume}% |";
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
                            date-format = "%b %d %y";
                            time-format = "%I:%M %p";
                            content.string.text = "{date} {time}";
                        };
                    }
                ];
            };
        };
    };
}

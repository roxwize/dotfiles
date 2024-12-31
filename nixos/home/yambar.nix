{ ... }: {
    programs.yambar = {
        enable = true;
        settings = {
            bar = {
                location = "top";
                height = 26;
                background = "00000066";

                right = [
                    {
                        clock = {
                            date-format = "%b %d %y";
                            time-format = "%I:%M %p";
                            content = [
                                {
                                    string.text = "{date} {time}";
                                }
                            ];
                        };
                    }
                ];
            };
        };
    };
}

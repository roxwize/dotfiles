{ pkgs, ... }: {
    programs.neovim = {
        enable = true;
        defaultEditor = true;
        vimAlias = true;
        plugins = with pkgs.vimPlugins; [
            vim-just
            vim-sleuth
            vim-wakatime
        ];
        extraLuaConfig = ''
            vim.opt.tabstop = 4
            vim.opt.softtabstop = 4
            vim.opt.shiftwidth = 4
            vim.opt.expandtab = true
        '';
    };
}

{ pkgs, ... }: {
    programs.neovim = {
        enable = true;
        defaultEditor = true;
        vimAlias = true;
        plugins = with pkgs.vimPlugins; [
            cmp_luasnip
            luasnip
            nvim-cmp
            nvim-lspconfig
            vim-just
            vim-sleuth
            vim-wakatime
        ];
        extraLuaConfig = ''
            require("lsp.lua")

            vim.opt.tabstop = 4
            vim.opt.softtabstop = 4
            vim.opt.shiftwidth = 4
            vim.opt.expandtab = true
        '';
    };
}

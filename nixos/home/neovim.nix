{ pkgs, ... }: {
	programs.neovim = {
		enable = true;
		defaultEditor = true;
		vimAlias = true;
		plugins = with pkgs.vimPlugins; [
			cmp_luasnip
			cmp-nvim-lsp
			luasnip         # Snippet engine
			neo-tree-nvim   # Filesystem tree
			nvim-cmp        # Code completion
			nvim-lspconfig
			rustaceanvim    # Rust support
			vim-just        # Syntax [just]
			vim-sleuth      # Indentation detection
			vim-wakatime    # Wakatime support
		];
		extraLuaConfig = builtins.readFile ../../configs/neovim.lua;
	};
}

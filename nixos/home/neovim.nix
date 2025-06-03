{ pkgs, ... }: {
	programs.neovim = {
		enable = true;
		defaultEditor = true;
		vimAlias = true;
		plugins = with pkgs.vimPlugins; [
			cmp_luasnip
			cmp-nvim-lsp
			luasnip
			nvim-cmp
			nvim-lspconfig
			rustaceanvim
			vim-just
			vim-sleuth
			vim-wakatime
		];
		extraLuaConfig = ''
			--vim.lsp.enable("ts_ls")
			--vim.lsp.enable("vala_ls")

			vim.opt.tabstop = 4
			vim.opt.softtabstop = 4
			vim.opt.shiftwidth = 4
			vim.opt.expandtab = true
			vim.opt.number = true

			-- cmp
			local cmp = require("cmp")
			cmp.setup {
				snippet = {
					expand = function(args)
						require("luasnip").lsp_expand(args.body)
					end
				},
				mapping = {
					['<C-up>'] = cmp.mapping.select_prev_item(),
					['<C-down>'] = cmp.mapping.select_next_item(),
					['<C-space>'] = cmp.mapping.complete(),
					['<C-e>'] = cmp.mapping.close(),
					['<tab>'] = cmp.mapping.confirm { select = true }
				},
				sources = cmp.config.sources({
					{ name = "nvim_lsp" },
					{ name = "luasnip" }
				})
			}

			local caps = vim.tbl_deep_extend(
				"force",
				vim.lsp.protocol.make_client_capabilities(),
				require("cmp_nvim_lsp").default_capabilities(),
				{ workspace = { didChangeWatchedFiles = { dynamicRegistration = true } } }
			)

			-- lspconfig
			local lc = require("lspconfig")

			lc.clangd.setup {
				autostart = true,
				capabilities = caps,
				cmd = { "clangd" }
			}
			lc.nil_ls.setup {
				autostart = true,
				capabilities = caps,
				cmd = { "nil" }
			}
			lc.ts_ls.setup { capabilities = caps }
			lc.vala_ls.setup { capabilities = caps }
		'';
	};
}

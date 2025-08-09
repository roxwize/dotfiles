--vim.lsp.enable("ts_ls")
--vim.lsp.enable("vala_ls")

vim.opt.list = true -- indent guides
vim.opt.number = true -- line numbers

vim.opt.tabstop = 4
vim.opt.shiftwidth = 4

-- neo-tree
require("neo-tree").setup {
	default_component_configs = {
		git_status = {
			symbols = {
				added = "+",
				conflict = "!",
				deleted = "-",
				ignored = ".",
				modified = "/",
				renamed = ">",
				staged = "S",
				unstaged = "u",
				untracked = "U"
			}
		},
		icon = {
			folder_closed = "-",
			folder_open = "+",
			folder_empty = "-",
			folder_empty_open = "-"
		}
	},
	filesystem = {
		window = {
			filtered_items = {
				visible = true,
				hide_dotfiles = false
			}
		}
	},
	sources = {
		"filesystem",
		"buffers",
		"git_status",
		"document_symbols"
	},
	source_selector = {
		winbar = true,
		sources = {
			{ source = "filesystem" },
			{ source = "buffers" },
			{ source = "git_status" },
			{ source = "document_symbols" }
		}
	}
}
vim.api.nvim_create_autocmd({"VimEnter"}, {
	command = "Neotree action=show position=right reveal=true"
})

---- language servers + intellisense
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

vim.lsp.config("clangd", { capabilities = caps })
lc.jsonls.setup {
	capabilities = caps,
	cmd = { "vscode-json-languageserver", "--stdio" }
}
lc.lua_ls.setup { capabilities = caps }
lc.mesonlsp.setup { capabilities = caps }
lc.nil_ls.setup { capabilities = caps }
lc.ts_ls.setup { capabilities = caps }
lc.vala_ls.setup { capabilities = caps }


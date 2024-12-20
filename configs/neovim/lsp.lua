-- cmp
local cmp = require("cmp")
cmp.setup {
    snippet = {
        expand = function(args)
            require("luasnip").lsp_expand(args.body)
        end
    },
    mapping = {
        ['<C-p>'] = cmp.mapping.select_prev_item(),
        ['<C-n>'] = cmp.mapping.select_next_item(),
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

lc.nix_nil.setup {
    autostart = true,
    capabilities = caps,
    cmd = { "nil" }
}

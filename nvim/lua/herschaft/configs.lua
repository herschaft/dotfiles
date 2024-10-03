vim.cmd(":colorscheme everforest")
vim.cmd(":set number")
vim.cmd(":set tabstop=4")
vim.cmd(":set shiftwidth=4")

local lsp_zero = require('lsp-zero')

-- lsp_attach is where you enable features that only work
-- if there is a language server active in the file
local lsp_attach = function(client, bufnr)
  local opts = {buffer = bufnr}
end

lsp_zero.extend_lspconfig({
	sign_text = true,
	lsp_attach = lsp_attach,
	capabilities = require('cmp_nvim_lsp').default_capabilities(),
})

require('lspconfig').clangd.setup({})
require('lspconfig').asm_lsp.setup({})
lsp_zero.setup_servers({'clangd', 'asm_lsp'})

local cmp = require("cmp")

cmp.setup({
	snippet = {
		expand = function(args)
			require("luasnip").lsp_expand(args.body)
		end,
	},
	window = {
	},
	mapping = cmp.mapping.preset.insert({
		['<C-f>'] = cmp.mapping.complete(),
		['<C-e>'] = cmp.mapping.abort(),
		['<C-Space>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
	}),
	sources = cmp.config.sources({
		{ name = 'nvim_lsp' },
		-- { name = 'vsnip' }, -- For vsnip users.
		{ name = 'luasnip' }, -- For luasnip users.
		-- { name = 'ultisnips' }, -- For ultisnips users.
		-- { name = 'snippy' }, -- For snippy users.
	}, {
		{ name = 'buffer' },
	})
})

local capabilities = require("cmp_nvim_lsp").default_capabilities()

require("lspconfig").clangd.setup({
	capabilities = capabilities,
	cmd = {'clangd'}
})

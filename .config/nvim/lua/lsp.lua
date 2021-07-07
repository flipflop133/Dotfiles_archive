local efm = require "efm"
local lspconfig = require "lspconfig"

-- LSP snippets support
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

custom_attach = function(client, _)
	-- Mappings
	local opts = {noremap = true, silent = true}
	set_keymap("n", "gd", "<Cmd>lua vim.lsp.buf.definition()<CR>", opts)
	set_keymap("n", "K", "<Cmd>lua vim.lsp.buf.hover()<CR>", opts)
	set_keymap("n", "[d", "<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>", opts)
	set_keymap("n", "]d", "<cmd>lua vim.lsp.diagnostic.goto_next()<CR>", opts)
	set_keymap('n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)

	-- Format on save
	vim.cmd([[autocmd BufWritePre * lua vim.lsp.buf.formatting_sync()]])

	-- Disable lsp formatter
	client.resolved_capabilities.document_formatting = false
end

custom_attach_hs = function(client, _)
	custom_attach(client)
	client.resolved_capabilities.document_formatting = true
end

local servers = {
	"rust_analyzer",
	"bashls",
	"tsserver",
}

for _, lsp in ipairs(servers) do
	lspconfig[lsp].setup {
		on_attach = custom_attach,
		capabilities = capabilities,
	}
end

lspconfig.hls.setup{
	on_attach = custom_attach_hs,
	capabilities = capabilities,
}

local sumneko_binary = "/usr/bin/lua-language-server"
lspconfig.sumneko_lua.setup{
	cmd = {sumneko_binary, "-E"};
	settings = {
		Lua = {
			diagnostics = {
				globals = {"mp", "love", "vim", "use"},
				disable = {"lowercase-global"}
			},
			telemetry = {enable = false}
		},
	},
	on_attach = custom_attach,
	capabilities = capabilities
}

lspconfig.gopls.setup{
	settings = {
		gopls = {
			analyses = {
				unusedparams = true,
				fieldalignment = true,
				nilness = true,
				unusedwrite = true
			},
			linksInHover = false,
			staticcheck = true
		}
	},
	on_attach = custom_attach,
	capabilities = capabilities,
}

lspconfig.efm.setup {
	init_options = {documentFormatting = true},
	filetypes = efm.filetypes,
	settings = {
		rootMarkers = {vim.loop.cwd()},
		languages = efm.languages,
	},
}

-- Documentation floating window
vim.lsp.handlers["textDocument/hover"] =
vim.lsp.with(
	vim.lsp.handlers.hover,
	{
		border = "single"
	}
)

-- Define diagnostics symbols
vim.fn.sign_define(
	"LspDiagnosticsSignError",
	{
		text = "",
		texthl = "LspDiagnosticsSignError"
	}
)
vim.fn.sign_define(
	"LspDiagnosticsSignWarning",
	{
		text = "",
		texthl = "LspDiagnosticsSignWarning"
	}
)
vim.fn.sign_define(
	"LspDiagnosticsSignInformation",
	{
		text = "",
		texthl = "LspDiagnosticsSignInformation"
	}
)
vim.fn.sign_define(
	"LspDiagnosticsSignHint",
	{
		text = "",
		texthl = "LspDiagnosticsSignHint"
	}
)

-- On screen diagnostics symbol
vim.lsp.handlers["textDocument/publishDiagnostics"] =
vim.lsp.with(
	vim.lsp.diagnostic.on_publish_diagnostics,
	{
		virtual_text = {prefix = "●"}
	}
)

local status_ok, lsp_installer = pcall(require, "nvim-lsp-installer")
if not status_ok then
	return
end

local lspconfig = require("lspconfig")

local servers = { "jsonls", "sumneko_lua", "clangd", "tsserver", "rust_analyzer", "pyright", "cssls", "html" }

lsp_installer.setup({
	ensure_installed = servers,
})

local opts = {
	on_attach = require("user.lsp.handlers").on_attach,
	capabilities = require("user.lsp.handlers").capabilities,
}

for _, server in pairs(servers) do
	local has_custom_opts, server_custom_opts = pcall(require, "user.lsp.settings." .. server)
	if has_custom_opts then
		opts = vim.tbl_deep_extend("force", opts, server_custom_opts)
	end
	lspconfig[server].setup(opts)
end

lspconfig.omnisharp.setup({
	cmd = {
		"/home/bagheri/.cache/omnisharp-vim/omnisharp-roslyn/run",
		"--languageserver",
		"--hostPID",
		tostring(vim.fn.getpid()),
	},
	on_attach = require("user.lsp.handlers").on_attach,
	capabilities = require("user.lsp.handlers").capabilities,
})

vim.cmd("let g:OmniSharp_highlighting = 0")
--vim.cmd("let g:neoformat_try_node_exe = 1")
--vim.cmd("let g:neoformat_try_node_exe = 1")

-- tagbar

--vim.cmd("let g:tagbar_iconchars = ['   ', '   ']")
vim.cmd("let g:tagbar_iconchars = ['  ', '  ']")

-- close tag uncommend plug autoClose to;
-- vim.cmd("let g:closetag_filenames = \"*.html,*.xhtml,*.phtml,*.php,*.jsx,*.tsx\"")
-- vim.cmd("let g:closetag_xhtml_filenames = '*.xhtml,*.jsx,*.tsx'")
-- vim.cmd("let g:closetag_filetypes = 'html,xhtml,phtml'")
-- vim.cmd("let g:closetag_xhtml_filetypes = 'xhtml,jsx'")
-- vim.cmd("let g:closetag_regions = { 'typescript.tsx':  'jsxRegion,tsxRegion', 'javascript.jsx': 'jsxRegion','typescriptreact': 'jsxRegion,tsxRegion','javascriptreact': 'jsxRegion',}")
-- vim.cmd("let g:closetag_shortcut = '>'")
-- vim.cmd("let g:closetag_close_shortcut = '<leader>>'")
-- vim.cmd("let g:closetag_enable_react_fragment = 1")

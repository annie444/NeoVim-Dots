-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")

vim.opt.rtp:append("/opt/homebrew/opt/fzf")

vim.g.do_filetype_lua = 1
vim.g.did_load_filetypes = 1

vim.opt.completeopt = { "menu", "menuone", "noselect" }

require("mason").setup()
require("mason-lspconfig").setup()

local lspconfig = require("lspconfig")
local lsp_defaults = lspconfig.util.default_config

lsp_defaults.capabilities =
  vim.tbl_deep_extend("force", lsp_defaults.capabilities, require("cmp_nvim_lsp").default_capabilities())

vim.diagnostic.config({
  virtual_text = false,
  severity_sort = true,
  float = {
    border = "rounded",
    source = "always",
    header = "",
    prefix = "",
  },
})

vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "rounded" })

vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = "rounded" })

lspconfig.sumneko_lua.setup({})

return {
  "williamboman/mason-lspconfig.nvim",
  opts = {
    automatic_installation = true,
    ensure_installed = {
      "clangd",
      "taplo",
      "bashls",
      "tsserver",
      "pyright",
      "ruff_lsp",
      "volar"
    },
  },
}

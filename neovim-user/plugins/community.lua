
return {
  "AstroNvim/astrocommunity",
  { import = "astrocommunity.colorscheme.catppuccin" },
  { import = "astrocommunity.colorscheme.monokai-pro-nvim" },
  { import = "astrocommunity.motion.hop-nvim" },
  { import = "astrocommunity.diagnostics.lsp_lines-nvim" },
  { import = "astrocommunity.pack.astro" },
  { import = "astrocommunity.pack.rust" },
  { import = "astrocommunity.pack.json" },
  { import = "astrocommunity.pack.go" },
  { import = "astrocommunity.pack.docker" },

  {
    "monokai-pro.nvim",
    opts = {
      terminal_colors = true,
      devicons = true, 
      filter = "octagon",
      plugins = {
        indent_blankline = {
          context_highlight = "pro", 
          context_start_underline = false,
        },
      },
    },
  },
}

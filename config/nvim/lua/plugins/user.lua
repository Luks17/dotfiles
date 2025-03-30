---@type LazySpec
return {
  -- Colorschemes
  { "folke/tokyonight.nvim", lazy = true },
  { "rose-pine/neovim", name = "rose-pine", lazy = true, opts = {} },
  {
    "rebelot/kanagawa.nvim",
    lazy = true,
    config = function()
      require("kanagawa").setup {
        -- disables line numbers bg
        colors = {
          theme = { all = { ui = { bg_gutter = "none" } } },
        },
      }
    end,
  },

  {
    "HiPhish/rainbow-delimiters.nvim",
    dependencies = "nvim-treesitter/nvim-treesitter",
    event = "User AstroFile",
    main = "rainbow-delimiters.setup",
    opts = {
      condition = function(bufnr)
        local buf_utils = require "astrocore.buffer"
        return buf_utils.is_valid(bufnr) and not buf_utils.is_large(bufnr)
      end,
    },
  },
}

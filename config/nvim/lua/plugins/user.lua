---@type LazySpec
return {
  -- Colorschemes
  { "folke/tokyonight.nvim", lazy = true },
  { "rose-pine/neovim", name = "rose-pine", lazy = true, opts = {} },

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

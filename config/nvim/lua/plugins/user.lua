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
}

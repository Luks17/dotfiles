return {
  "folke/drop.nvim",
  event = "VeryLazy",
  config = function()
    require("drop").setup {
      max = 7,
      theme = "stars",
    }
  end,
}

return {
  {
    "rebelot/heirline.nvim",
    opts = function(_, opts) opts.winbar = nil end,
  },
  {
    "neo-tree.nvim",
    opts = function(_, opts) opts.source_selector.winbar = false end,
  },
}

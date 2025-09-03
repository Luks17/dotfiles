return {
  "FabijanZulj/blame.nvim",
  event = "VeryLazy",
  cmd = "BlameToggle",
  specs = {
    {
      "AstroNvim/astrocore",
      ---@type AstroCoreOpts
      opts = {
        mappings = {
          n = {
            ["<Leader>gB"] = { "<cmd>BlameToggle virtual<cr>", desc = "Toggle Virtual Blame" },
          },
        },
      },
    },
  },
  opts = {},
}

-- Makes quickfix not suck
return {
  {
    "kevinhwang91/nvim-bqf",
    ft = "qf",
    dependencies = {
      "AstroNvim/astrocore",
      ---@param opts AstroCoreOpts
      opts = function(_, opts)
        if not opts.signs then opts.signs = {} end
        opts.signs.BqfSign = { text = " " .. require("astroui").get_icon "Selected", texthl = "BqfSign" }
      end,
    },
    opts = {},
  },
  {
    "stevearc/quicker.nvim",
    event = "VeryLazy",
    specs = {
      {
        "AstroNvim/astrocore",
        ---@type AstroCoreOpts
        opts = {
          mappings = {
            n = {
              ["<Leader>xq"] = { function() require("quicker").toggle { focus = true } end, desc = "Toggle quickfix" },
              ["<Leader>xl"] = {
                function() require("quicker").toggle { focus = true, loclist = true } end,
                desc = "Toggle loclist",
              },
            },
          },
        },
      },
    },
  },
}

---@type LazySpec
return {
  {
    "goolord/alpha-nvim",
    opts = function(_, opts)
      -- customize the dashboard header
      opts.section.header.val = {
        "                                 .           ",
        "                                       *     ",
        "     *              *                        ",
        "             .           .           .       ",
        "                        .*.                  ",
        "                                  *          ",
        "          |\\___/|                            ",
        "  .       )     (             .              ",
        "         =\\     /=                           ",
        "           )===(       *                     ",
        "          /     \\                            ",
        "   *      |     |                  .        ",
        "         /       \\                           ",
        "         \\       /                           ",
        "  _/\\_/\\_/\\__  _/_/\\_/\\_/\\_/\\_/\\_/\\_/\\_/\\_/\\_",
        "  |  |  |  |( (  |  |  |  |  |  |  |  |  |  |",
        "  |  |  |  | ) ) |  |  |  |  |  |  |  |  |  |",
        "  |  |  |  |(_(  |  |  |  |  |  |  |  |  |  |",
        "  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |"
      }
      return opts
    end,
  },
  {
    "vuki656/package-info.nvim",
    dependencies = { "MunifTanjim/nui.nvim" },
    opts = {},
    event = "BufRead package.json",
  }
}

return {
  "goolord/alpha-nvim",
  opts = function(_, opts)
    opts.config.layout = {
      { type = "padding", val = vim.fn.max { 2, vim.fn.floor(vim.fn.winheight(0) * 0.1) } },
      opts.section.header,
      { type = "padding", val = 3 },
      opts.section.buttons,
      { type = "padding", val = 2 },
      opts.section.footer,

    }
    -- customize the dashboard header
    opts.section.header.val = {
      "             *                          .    ",
      "  .               .                          ",
      "                                 .           ",
      "                                       *     ",
      "     *              .                        ",
      "             .           .           .       ",
      "                        .*.                  ",
      "                                  *          ",
      "          |\\___/|                            ",
      "  .       )     (             .              ",
      "         =\\     /=                           ",
      "           )===(       *                *    ",
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
}

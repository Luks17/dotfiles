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
    "folke/drop.nvim",
    event = "VeryLazy",
    config = function()
      require("drop").setup
      {
        max = 7,
        theme = "snow",
      }
    end
  },
  {
    "FabijanZulj/blame.nvim",
    config = function()
      require("blame").setup()
    end
  },
  {
    "HiPhish/rainbow-delimiters.nvim",
    dependencies = "nvim-treesitter/nvim-treesitter",
    event = "VeryLazy",
    main = "rainbow-delimiters.setup",
  },
  {
    "catppuccin/nvim",
    name = "catppuccin",
    ---@type CatppuccinOptions
    opts = {
      integrations = {
        aerial = true,
        alpha = true,
        cmp = true,
        dap = true,
        dap_ui = true,
        gitsigns = true,
        hop = true,
        illuminate = true,
        indent_blankline = true,
        markdown = true,
        mason = true,
        native_lsp = true,
        neotree = true,
        notify = true,
        semantic_tokens = true,
        symbols_outline = true,
        telescope = true,
        treesitter = true,
        ts_rainbow = false,
        ufo = true,
        which_key = true,
        window_picker = true,
        rainbow_delimiters = true
      }
    },
  },
  {
    "nvim-telescope/telescope.nvim",
    optional = true,
    opts = {
      highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
      },
    },
  },
  {
    "sustech-data/wildfire.nvim",
    event = "BufEnter",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    config = function()
      require("wildfire").setup()
    end,
  },
  {
    "hrsh7th/nvim-cmp",
    optional = true,
    dependencies = {
      { "js-everts/cmp-tailwind-colors", opts = {} },
    },
    opts = function(_, opts)
      local format_kinds = opts.formatting.format
      opts.formatting.format = function(entry, item)
        if item.kind == "Color" then
          item = require("cmp-tailwind-colors").format(entry, item)
          if item.kind == "Color" then return format_kinds(entry, item) end
          return item
        end
        return format_kinds(entry, item)
      end
    end,
  },
  {
    "NvChad/nvim-colorizer.lua",
    optional = true,
    opts = {
      user_default_options = {
        names = true,
        tailwind = true,
      },
    },
  },
  {
    "akinsho/toggleterm.nvim",
    opts = {
      direction = "float",
    },
  }
}

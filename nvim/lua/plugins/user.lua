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
    "folke/tokyonight.nvim",
    lazy = false,
  },
  {
    "projekt0n/github-nvim-theme",
    lazy = true
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
  },
  {
    "nanotee/sqls.nvim",
    lazy = true,
    dependencies = {
      "AstroNvim/astrocore",
      opts = {
        autocmds = {
          sqls_attach = {
            {
              event = "LspAttach",
              desc = "Load sqls.nvim with sqls",
              callback = function(args)
                local client = assert(vim.lsp.get_client_by_id(args.data.client_id))
                if client.name == "sqls" then require("sqls").on_attach(client, args.buf)
                  client.server_capabilities.documentFormattingProvider = false
                end
              end
            },
          },
        },
      },
    },
  },
  {
    "rafaelsq/nvim-goc.lua",
    ft = "go",
    config = function()
      vim.api.nvim_create_user_command("GoShowCoverage",
        function()
          vim.cmd('silent! lua require("nvim-goc").Coverage()')
        end,
        {}
      )
      vim.api.nvim_create_user_command("GoClearCoverage",
        function()
          vim.cmd('silent! lua require("nvim-goc").ClearCoverage()')
        end,
        {}
      )
      require("nvim-goc").setup(
        {
          verticalSplit = false
        }
      )
    end
  }
}

---@type LazySpec
return {
  "nvim-treesitter/nvim-treesitter",
  opts = function(_, opts)
    opts.ensure_installed = require("astrocore").list_insert_unique(opts.ensure_installed, {
      "lua",
      "astro",
      "bash",
      "tsx",
      "typescript",
      "javascript",
      "jsdoc",
      "php",
      "markdown",
      "python",
      "vue",
      "sql"
    })
  end,
}

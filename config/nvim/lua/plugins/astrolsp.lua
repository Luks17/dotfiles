-- AstroLSP allows you to customize the features in AstroNvim's LSP configuration engine
-- Configuration documentation can be found with `:h astrolsp`

---@type LazySpec
return {
  "AstroNvim/astrolsp",
  ---@param opts AstroLSPOpts
  opts = function(_, opts)
    opts.servers = opts.servers or {}
    table.insert(opts.servers, "elixirls")

    opts.config = require("astrocore").extend_tbl(opts.config or {}, {
      elixirls = {
        cmd = { "/usr/lib/elixir-ls/language_server.sh" },
      },
    })

    opts.formatting = {
      disabled = {
        "volar",
      },
    }
  end,
}

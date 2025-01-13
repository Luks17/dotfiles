return {
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
}

---@type LazySpec
return {
  "AstroNvim/astrolsp",
  ---@type AstroLSPOpts
  opts = {
    formatting = {
      disabled = {
        "volar"
      }
    },
    config = {
      tailwindcss = {
        filetypes = { "typescriptreact", "javascriptreact", "vue", "astro" }
      }
    }
  }
}

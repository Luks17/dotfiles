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
    ---@diagnostic disable: missing-fields
    config = {
      tailwindcss = {
        filetypes = { "typescriptreact", "javascriptreact", "vue", "astro" }
      }
    }
  }
}

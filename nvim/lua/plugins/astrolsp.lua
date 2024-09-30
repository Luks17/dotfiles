---@type LazySpec
return {
  "AstroNvim/astrolsp",
  ---@type AstroLSPOpts
  opts = {
    ---@diagnostic disable: missing-fields
    config = {
      tailwindcss = {
        filetypes = { "typescriptreact", "javascriptreact", "vue", "astro" }
      }
    }
  }
}

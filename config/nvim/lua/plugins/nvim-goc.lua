return {
  "rafaelsq/nvim-goc.lua",
  ft = "go",
  config = function()
    vim.api.nvim_create_user_command(
      "GoCheckCoverage",
      function() vim.cmd 'silent! lua require("nvim-goc").Coverage()' end,
      {}
    )
    vim.api.nvim_create_user_command(
      "GoClearCoverage",
      function() vim.cmd 'silent! lua require("nvim-goc").ClearCoverage()' end,
      {}
    )
    require("nvim-goc").setup {
      verticalSplit = false,
    }
  end,
}

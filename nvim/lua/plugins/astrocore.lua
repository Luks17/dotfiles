---@type LazySpec
return {
  "AstroNvim/astrocore",
  ---@type AstroCoreOpts
  opts = {
    autocmds = {
      autodefinetabwidth = {
        {
          event = "User",
          pattern = "AstroBufsUpdated",
          desc = "Define tab width and expandtab",
          group = "autodefinetabwidth",

          callback = function()
            local filetype = vim.bo.filetype
            local tabwidth = 4
            local expandtab = false;

            if filetype == "lua" or filetype == "yaml" then
				      tabwidth = 2;
				      expandtab = true;
            end

            if filetype == 'php' or filetype == 'typescriptreact' or filetype == 'vue' or filetype == 'typescript' or filetype == 'javascript' then
              expandtab = true;
            end

            vim.bo.tabstop = tabwidth
            vim.bo.shiftwidth = tabwidth
            vim.bo.softtabstop = tabwidth
            vim.bo.expandtab = expandtab
          end
        }
      }
    },
    mappings = {
      -- first key is the mode
      n = {
        -- second key is the lefthand side of the map

        -- Toggle Virtual Blame mapping, overriding Single Line Blame
        ["<Leader>gB"] = { "<cmd>BlameToggle virtual<cr>", desc = "Toggle Virtual Blame" },
      },
    }
  }
}

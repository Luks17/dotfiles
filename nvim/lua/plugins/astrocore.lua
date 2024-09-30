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
          desc = "Define tab width as 4 when a php, python, make or rust file is opened, otherwise set it as 2",
          group = "autodefinetabwidth",

          callback = function()
            local filetype = vim.bo.filetype
            local tabwidth = 4
            local expandtab = false;

            if filetype == "lua" then
				      tabwidth = 2;
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
    diagnostics = {
      virtual_text = false
    },
    mappings = {
      -- first key is the mode
      n = {
        -- second key is the lefthand side of the map

        -- Navigate buffers
        L = { function() require("astrocore.buffer").nav(vim.v.count > 0 and vim.v.count or 1) end, desc = "Next buffer" },
        H = { function() require("astrocore.buffer").nav(-(vim.v.count > 0 and vim.v.count or 1)) end, desc = "Previous buffer" },

        -- Toggle Virtual Blame mapping, overriding Single Line Blame
        ["<Leader>gB"] = { "<cmd>BlameToggle virtual<cr>", desc = "Toggle Virtual Blame" },
      },
    }
  }
}

-- AstroCore provides a central place to modify mappings, vim options, autocommands, and more!
-- Configuration documentation can be found with `:h astrocore`

---@type LazySpec
return {
  "AstroNvim/astrocore",
  ---@type AstroCoreOpts
  opts = {
    -- vim options can be configured here
    options = {
      opt = { -- vim.opt.<key>
        wrap = true, -- sets vim.opt.wrap
      },
    },

    -- Mappings can be configured through AstroCore as well.
    -- NOTE: keycodes follow the casing in the vimdocs. For example, `<Leader>` must be capitalized
    mappings = {
      -- first key is the mode
      n = {
        -- second key is the lefthand side of the map

        -- Toggle Virtual Blame mapping, overriding Single Line Blame
        ["<Leader>gB"] = { "<cmd>BlameToggle virtual<cr>", desc = "Toggle Virtual Blame" },

        ---@diagnostic disable: missing-parameter
        ["s"] = { function() require("hop").hint_words() end, desc = "Hop hint words" },
        ["<S-s>"] = { function() require("hop").hint_lines() end, desc = "Hop hint lines" },
      },
      v = {
        ---@diagnostic disable: missing-fields
        ["s"] = { function() require("hop").hint_words { extend_visual = true } end, desc = "Hop hint words" },
        ["<S-s>"] = { function() require("hop").hint_lines { extend_visual = true } end, desc = "Hop hint lines" },
      },
    },

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
            local expandtab = false

            if filetype == "lua" or filetype == "yaml" then
              tabwidth = 2
              expandtab = true
            end

            if
              filetype == "php"
              or filetype == "typescriptreact"
              or filetype == "vue"
              or filetype == "typescript"
              or filetype == "javascript"
            then
              expandtab = true
            end

            vim.bo.tabstop = tabwidth
            vim.bo.shiftwidth = tabwidth
            vim.bo.softtabstop = tabwidth
            vim.bo.expandtab = expandtab
          end,
        },
      },
    },
  },
}

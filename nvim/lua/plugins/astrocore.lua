---@type LazySpec
return {
  "AstroNvim/astrocore",
  ---@type AstroCoreOpts
  opts = {
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

        -- Toggle Virtual Blame mapping overriding Single Line Blame
        ["<Leader>gl"] = { "<cmd>ToggleBlame virtual<cr>", desc = "Toggle Virtual Blame" },
      },
    }
  }
}

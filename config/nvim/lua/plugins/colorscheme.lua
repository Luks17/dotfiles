---@type LazySpec
return {
    {
        "rose-pine/neovim",
        name = "rose-pine",
        opts = {},
    },
    {
        "rebelot/kanagawa.nvim",
        lazy = true,
        config = function()
            require("kanagawa").setup {
                -- disables line numbers bg
                colors = {
                    theme = { all = { ui = { bg_gutter = "none" } } },
                },
            }
        end,
    },
}

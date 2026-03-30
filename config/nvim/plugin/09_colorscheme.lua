Setup.now(function()
    vim.pack.add({ 'https://github.com/rose-pine/neovim', 'https://github.com/rebelot/kanagawa.nvim' })

    require('rose-pine').setup()

    -- require('kanagawa').setup({
    --     -- disables line numbers bg
    --     colors = {
    --         theme = { all = { ui = { bg_gutter = 'none' } } },
    --     },
    -- })

    vim.cmd('colorscheme rose-pine')
end)

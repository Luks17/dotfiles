local function gs_multi_mode(gs_callback)
    if vim.fn.mode():match('[vV\22]') then
        gs_callback({ vim.fn.line('.'), vim.fn.line('v') })
        return
    end
    gs_callback()
end

Setup.later(function()
    vim.pack.add({ 'https://github.com/lewis6991/gitsigns.nvim' })

    local gs = require('gitsigns')
    gs.setup({
        on_attach = function(bufnr)
            MapSet({ 'n', 'v' }, '<leader>gs', function() gs_multi_mode(gs.stage_hunk) end, 'Stage/Unstage hunk')
            MapSet({ 'n', 'v' }, '<leader>gr', function() gs_multi_mode(gs.reset_hunk) end, 'Reset hunk')

            MapSet('n', '<leader>gS', gs.stage_buffer, 'Stage/Unstage buffer')
            MapSet('n', '<leader>gR', gs.reset_buffer, 'Reset buffer')

            MapSet('n', '<leader>gbl', function() gs.blame_line({ full = true }) end, 'Blame line')
            MapSet('n', '<leader>gbb', gs.blame, 'Open buffer blame')
            MapSet('n', '<leader>gbc', gs.toggle_current_line_blame, 'Toggle current line blame')
        end,
    })
end)

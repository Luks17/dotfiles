return {
    'LintaoAmons/scratch.nvim',
    event = 'VeryLazy',
    config = function()
        MapSet('n', '<leader>bsn', '<cmd>ScratchWithName<cr>', 'New scratch buffer')
        MapSet('n', '<leader>bso', '<cmd>ScratchOpen<cr>', 'Open scratch buffer')
    end,
}

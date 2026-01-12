return {
    'nvim-neotest/neotest',
    event = 'BufFilePre',
    dependencies = {
        'nvim-neotest/nvim-nio',
        'nvim-lua/plenary.nvim',
        'antoinemadec/FixCursorHold.nvim',
        'nvim-treesitter/nvim-treesitter',

        'marilari88/neotest-vitest',
        'fredrikaverpil/neotest-golang',
    },
    config = function()
        local neotest = require('neotest')
        neotest.setup({
            adapters = {
                require('neotest-vitest'),
                require('neotest-golang')({
                    runner = 'gotestsum',
                }),
            },
        })

        MapSet('n', '<leader>tr', neotest.run.run, 'Run nearest test')
        MapSet('n', '<leader>tS', neotest.run.run, 'Stop nearest test')
        MapSet('n', '<leader>td', function() neotest.run.run({ strategy = 'dap' }) end, 'Debug nearest test')
        MapSet('n', '<leader>tf', function() neotest.run.run(vim.fn.expand('%')) end, 'Test entire file')
        MapSet('n', '<leader>to', neotest.output.open, 'Test output')
        MapSet('n', '<leader>tO', neotest.output_panel.toggle, 'Toggle tests output panel')
        MapSet('n', '<leader>ts', neotest.summary.toggle, 'Toggle test summary')
    end,
}

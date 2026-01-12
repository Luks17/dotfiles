return {
    {
        'nvim-neotest/neotest',
        event = { 'BufReadPre', 'BufNewFile' },
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
            MapSet('n', '<leader>tw', function() neotest.run.run(vim.fn.getcwd()) end, 'Test entire workspace')
            MapSet('n', '<leader>to', neotest.output.open, 'Test output')
            MapSet('n', '<leader>tO', neotest.output_panel.toggle, 'Toggle tests output panel')
            MapSet('n', '<leader>ts', neotest.summary.toggle, 'Toggle test summary')
        end,
    },
    {
        'andythigpen/nvim-coverage',
        event = { 'BufReadPre', 'BufNewFile' },
        dependencies = 'nvim-lua/plenary.nvim',
        config = function()
            local coverage = require('coverage')
            coverage.setup({
                auto_reload = true,
                go_test_args = {
                    '-v',
                    '-race',
                    '-count=1',
                    '-coverprofile=' .. vim.fn.getcwd() .. '/coverage.out',
                },
            })

            MapSet('n', '<leader>tcl', function() coverage.load(true) end, 'Load coverage')
            MapSet('n', '<leader>tcc', coverage.clear, 'Clear coverage')
            MapSet('n', '<leader>tct', coverage.toggle, 'Toggle coverage signs')
            MapSet('n', '<leader>tcs', coverage.summary, 'Coverage summary')
        end,
    },
}

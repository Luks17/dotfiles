return {
    {
        'monkoose/neocodeium',
        event = { 'BufReadPre', 'BufNewFile' },
        config = function()
            local neocodeium = require('neocodeium')
            neocodeium.setup({
                show_label = true,
            })

            local cmds = require('neocodeium.commands')

            MapSet('i', '<A-a>', neocodeium.accept, 'Accept entire suggestion')
            MapSet('i', '<A-l>', neocodeium.accept_line, 'Accept line suggestion')
            MapSet('i', '<A-w>', neocodeium.accept_word, 'Accept word suggestion')
            MapSet('i', '<A-e>', neocodeium.cycle_or_complete, 'Cycle suggestion')
            MapSet('i', '<A-x>', neocodeium.clear, 'Clear suggestion')

            MapSet('n', '<leader>as', cmds.enable, 'Start AI assistant')
            MapSet('n', '<leader>aS', function() cmds.disable(true) end, 'Stop AI assistant')
            MapSet('n', '<leader>ar', cmds.restart, 'Restart AI assistant')
        end,
    },
    {
        'NickvanDyke/opencode.nvim',
        event = { 'BufReadPre', 'BufNewFile' },
        dependencies = {
            'ibhagwan/fzf-lua',
        },
        config = function()
            vim.g.opencode_opts = {
                provider = {
                    enabled = 'tmux',
                    tmux = {
                        options = '-h',
                    },
                },
            }

            local opencode = require('opencode')
            local prefix = '<leader>ao'

            MapSet({ 'n', 'x' }, '<leader>aoa', function() opencode.ask('@this: ', { submit = true }) end, 'Ask')
            MapSet({ 'n', 'x' }, '<leader>aos', function() opencode.select() end, 'Execute action')
            MapSet(
                { 'n', 'x' },
                '<leader>aor',
                function() return require('opencode').operator('@this ') end,
                'Add range to opencode',
                { expr = true }
            )
            MapSet(
                'n',
                '<leader>aol',
                function() return require('opencode').operator('@this ') .. '_' end,
                'Add line to opencode',
                { expr = true }
            )
        end,
    },
}

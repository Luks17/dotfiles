return {
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
}

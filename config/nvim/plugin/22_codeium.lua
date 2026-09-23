Setup.later(function()
    vim.pack.add({
        'https://github.com/monkoose/neocodeium',
    })

    AddClues({
        { mode = { 'n', 'x' }, keys = '<Leader>ac', desc = '+Codeium' },
    })

    local neocodeium = require('neocodeium')
    neocodeium.setup({
        show_label = true,
    })

    local cmds = require('neocodeium.commands')

    MapSet('i', '<A-a>', neocodeium.accept, 'Accept entire suggestion')
    MapSet('i', '<A-l>', neocodeium.accept_line, 'Accept line suggestion')
    MapSet('i', '<A-e>', neocodeium.accept_word, 'Accept word suggestion')
    MapSet('i', '<A-r>', neocodeium.cycle_or_complete, 'Cycle suggestion')
    MapSet('i', '<A-x>', neocodeium.clear, 'Clear suggestion')

    MapSet('n', '<leader>acs', cmds.enable, 'Start AI assistant')
    MapSet('n', '<leader>acS', function() cmds.disable(true) end, 'Stop AI assistant')
    MapSet('n', '<leader>acr', cmds.restart, 'Restart AI assistant')
end)

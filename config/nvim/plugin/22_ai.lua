Setup.later(function()
    vim.pack.add({
        'https://github.com/monkoose/neocodeium',
        'https://github.com/NickvanDyke/opencode.nvim',
    })

    AddClues({
        { mode = { 'n', 'x' }, keys = '<Leader>a', desc = '+AI' },
        { mode = { 'n', 'x' }, keys = '<Leader>ao', desc = '+OpenCode' },
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

    MapSet('n', '<leader>as', cmds.enable, 'Start AI assistant')
    MapSet('n', '<leader>aS', function() cmds.disable(true) end, 'Stop AI assistant')
    MapSet('n', '<leader>ar', cmds.restart, 'Restart AI assistant')

    local opencode = require('opencode')

    MapSet({ 'n', 'x' }, '<leader>aoe', function() opencode.select() end, 'Execute action')
    MapSet({ 'n', 'x' }, '<leader>aob', function() opencode.prompt('@buffer ') end, 'Add buffer to opencode')
    MapSet({ 'n', 'x' }, '<leader>aoB', function() opencode.prompt('@buffers ') end, 'Add all open buffers to opencode')
    MapSet(
        { 'n', 'x' },
        '<leader>aod',
        function() opencode.prompt('@diagnostics ') end,
        'Add current buffer diagnostics to opencode'
    )
    MapSet({ 'n', 'x' }, '<leader>aoq', function() opencode.prompt('@quickfix ') end, 'Add quickfix to opencode')
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
end)

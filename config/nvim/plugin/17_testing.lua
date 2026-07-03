local pane_id

local function run_on_tmux(cmd)
    local tmux = require('tmux')

    if tmux.pane_cmd(pane_id, cmd) then return end

    pane_id = tmux.split({ cmd = 'exec $SHELL', focus = true })
    tmux.pane_cmd(pane_id, cmd)
end

local function debug_test()
    local ft = vim.bo.filetype

    if ft == 'go' then
        require('dap-go').debug_test()
    else
        vim.notify('No debug-test adapter configured for ' .. ft, vim.log.levels.WARN)
    end
end

Setup.later(function()
    vim.pack.add({
        'https://github.com/vim-test/vim-test',
    })

    vim.g['test#custom_strategies'] = { run_on_tmux = run_on_tmux }
    if require('tmux').is_tmux_available() then
        vim.g['test#strategy'] = 'run_on_tmux'
    else
        vim.g['test#strategy'] = 'neovim_sticky'
        vim.g['test#neovim_sticky#reopen_window'] = 1
    end

    vim.g['test#go#gotest#options'] = '-v'

    AddClues({
        { mode = 'n', keys = '<Leader>t', desc = '+Testing' },
    })

    MapSet('n', '<leader>tr', ':TestNearest<CR>', 'Run nearest test')
    MapSet('n', '<leader>tf', ':TestFile<CR>', 'Run all tests in file')
    MapSet('n', '<leader>tw', ':TestSuite<CR>', 'Run all tests in suite')
    MapSet('n', '<leader>tl', ':TestLast<CR>', 'Run last test')
    MapSet('n', '<leader>tv', ':TestVisit<CR>', 'Open file of the last test run')
    MapSet('n', '<leader>td', debug_test, 'Debug nearest test')
end)

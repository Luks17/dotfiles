local tmux_state = {
    pane_id = nil,
}

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
        event = 'VeryLazy',
        dependencies = {
            'ibhagwan/fzf-lua',
        },
        config = function()
            local opencode = require('opencode')
            local tmux = require('config.tmux')
            local fallback = require('opencode.terminal')

            local open_tmux = function()
                tmux_state.pane_id = tmux.tmux_split({ cmd = 'opencode --port', focus = false })
            end

            local stop_tmux = function()
                if tmux_state.pane_id ~= nil then
                    tmux.tmux_kill_pane(tmux_state.pane_id)
                    tmux_state.pane_id = nil
                end
            end

            vim.g.opencode_opts = {
                server = {
                    start = function()
                        if tmux.is_tmux_available() == false then
                            fallback.start('opencode --port')
                            return
                        end
                        open_tmux()
                    end,
                    stop = function()
                        if tmux.is_tmux_available() == false then
                            fallback.stop()
                            return
                        end
                        stop_tmux()
                    end,
                    toggle = function()
                        if tmux.is_tmux_available() == false then
                            fallback.toggle('opencode --port')
                            return
                        end

                        if tmux_state.pane_id ~= nil then
                            stop_tmux()
                        else
                            open_tmux()
                        end
                    end,
                },
            }

            MapSet({ 'n', 'x' }, '<leader>aos', function() opencode.start() end, 'Start')
            MapSet({ 'n', 'x' }, '<leader>aoe', function() opencode.select() end, 'Execute action')
            MapSet({ 'n', 'x' }, '<leader>aob', function() opencode.prompt('@buffer ') end, 'Add buffer to opencode')
            MapSet(
                { 'n', 'x' },
                '<leader>aoB',
                function() opencode.prompt('@buffers ') end,
                'Add all open buffers to opencode'
            )
            MapSet(
                { 'n', 'x' },
                '<leader>aod',
                function() opencode.prompt('@diagnostics ') end,
                'Add current buffer diagnostics to opencode'
            )
            MapSet(
                { 'n', 'x' },
                '<leader>aoq',
                function() opencode.prompt('@quickfix ') end,
                'Add quickfix to opencode'
            )
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

local mason_pkgs = vim.fn.stdpath('data') .. '/mason/packages/'

local setup_go = function(dap)
    require('dap-go').setup()
    dap.configurations.go = {}
end

local setup_js = function(dap)
    for _, adapter_type in ipairs({ 'node', 'chrome', 'msedge' }) do
        local pwa_type = 'pwa-' .. adapter_type

        dap.adapters[pwa_type] = {
            type = 'server',
            host = 'localhost',
            port = '${port}',
            executable = {
                command = 'node',
                args = {
                    mason_pkgs .. 'js-debug-adapter/js-debug/src/dapDebugServer.js',
                    '${port}',
                },
            },
        }

        -- Maps non pwa .vscode/launch.json adapter types to ther pwa equivalent
        -- e.g.: chrome -> pwa-chrome
        dap.adapters[adapter_type] = function(callback, config)
            local pwa_adapter = dap.adapters[pwa_type]
            config.type = pwa_type

            callback(pwa_adapter)
        end
    end
end

return {
    'mfussenegger/nvim-dap',
    event = 'VeryLazy',
    dependencies = {
        {
            'igorlfs/nvim-dap-view',
            opts = {},
        },
        {
            'nalum/nvim-dap-go',
            commit = 'b4a44a5e022e34bb9eca3c27527aef3dda9a1cfa',
        },
    },
    config = function()
        local dap = require('dap')

        setup_go(dap)
        setup_js(dap)

        local widgets = require('dap.ui.widgets')

        MapSet('n', '<leader>ds', dap.continue, 'Start/continue debugger')
        MapSet('n', '<leader>dp', dap.pause, 'Pause debugger')
        MapSet('n', '<leader>dh', widgets.hover, 'Check the hovered value')
        MapSet('n', '<leader>dB', dap.clear_breakpoints, 'Clear breakpoints')
        MapSet('n', '<leader>db', dap.toggle_breakpoint, 'Toggle breakpoint')
        MapSet(
            'n',
            '<leader>dc',
            function() dap.toggle_breakpoint(vim.fn.input('Breakpoint condition: ')) end,
            'Conditional breakpoint'
        )
        MapSet('n', '<leader>dC', dap.run_to_cursor, 'Run debugger to cursor')
        MapSet('n', '<leader>dq', dap.disconnect, 'Quit debugger session')
        MapSet('n', '<leader>dQ', dap.terminate, 'Terminate debugger')
        MapSet('n', '<leader>do', dap.step_over, 'Step over')
        MapSet('n', '<leader>di', dap.step_into, 'Step into')
        MapSet('n', '<leader>dO', dap.step_out, 'Step out')

        local dap_view = require('dap-view')
        MapSet('n', '<leader>dv', dap_view.toggle, 'Toggle dap view')
        MapSet('n', '<leader>dw', dap_view.add_expr, 'Watch expression under the cursor')
    end,
}

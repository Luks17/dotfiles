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
        require('dap-go').setup()

        local dap = require('dap')
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
        MapSet(
            'n',
            '<leader>dw',
            dap_view.add_expr,
            'Watch expression under the cursor'
        )
    end,
}

return {
    'rebelot/heirline.nvim',
    dependencies = {
        'nvim-mini/mini.icons',
        {
            'Zeioth/heirline-components.nvim',
            opts = {
                icons = {
                    VimIcon = '',
                },
            },
        },
    },
    lazy = false,
    config = function()
        local heirline = require('heirline')
        local lib = require('heirline-components.all')

        vim.opt.showtabline = 2 -- required

        lib.init.subscribe_to_events()
        heirline.load_colors(lib.hl.get_colors())

        heirline.setup({
            tabline = {
                lib.component.tabline_conditional_padding(),
                lib.component.tabline_buffers({ close_button = false, padding = { right = 2 } }),
                lib.component.fill({ hl = { bg = 'tabline_bg' } }),
            },
            statusline = {
                hl = { fg = 'fg', bg = 'bg' },
                lib.component.mode({
                    mode_text = {
                        icon = { kind = 'VimIcon' },
                        padding = { left = 1 },
                    },
                }),
                lib.component.git_branch(),
                lib.component.file_info(),
                lib.component.git_diff(),
                lib.component.diagnostics(),
                lib.component.fill(),
                lib.component.cmd_info(),
                lib.component.fill(),
                lib.component.lsp(),
                lib.component.compiler_state(),
                lib.component.virtual_env(),
                lib.component.nav(),
            },
        })
    end,
}

Setup.now(function()
    vim.pack.add({
        'https://github.com/rebelot/heirline.nvim',
        'https://github.com/Zeioth/heirline-components.nvim',
    })

    require('heirline-components').setup({
        icons = {
            VimIcon = '',
        },
    })

    local heirline = require('heirline')
    local lib = require('heirline-components.all')

    lib.init.subscribe_to_events()
    heirline.load_colors(lib.hl.get_colors())

    heirline.setup({
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
end)

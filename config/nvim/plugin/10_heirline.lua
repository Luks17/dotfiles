Setup.now(function()
    vim.pack.add({
        'https://github.com/rebelot/heirline.nvim',
        'https://github.com/Zeioth/heirline-components.nvim',
    })

    local heirline = require('heirline')
    local lib = require('heirline-components.all')

    lib.init.subscribe_to_events()
    heirline.load_colors(lib.hl.get_colors())

    heirline.setup({
        statusline = {
            hl = { fg = 'fg', bg = 'bg' },
            lib.component.mode(),
            lib.component.file_info(),
            lib.component.git_branch(),
            lib.component.git_diff(),
            lib.component.diagnostics(),
            lib.component.fill(),
            lib.component.lsp(),
            lib.component.nav({ scrollbar = false }),
            lib.component.mode({ surround = { separator = 'right' } }),
        },
    })
end)

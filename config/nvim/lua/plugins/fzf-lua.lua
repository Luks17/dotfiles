return {
    'ibhagwan/fzf-lua',
    dependencies = { 'nvim-mini/mini.icons' },
    opts = {},
    event = 'VeryLazy',
    config = function()
        local fzf = require('fzf-lua')
        fzf.register_ui_select()

        MapSet('n', '<leader>ef', fzf.files, 'Find files')
        MapSet('n', '<leader>eg', fzf.live_grep, 'Live grep')
        MapSet('n', '<leader>er', fzf.oldfiles, 'Recent files')
        MapSet('n', '<leader>eu', fzf.undotree, 'Undo tree')
        MapSet('n', '<leader>bl', fzf.buffers, 'List buffers')

        local border = vim.api.nvim_get_option_value('winborder', {})

        fzf.setup({
            winopts = {
                border = border,
                preview = {
                    border = border,
                },
            },
        })
    end,
}

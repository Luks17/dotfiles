local setup_bigfile = function(snacks) return {} end

local setup_image = function(snacks) return {} end

local setup_picker = function(snacks)
    MapSet('n', '<leader>ef', snacks.picker.files, 'Find files')
    MapSet('n', '<leader>eg', snacks.picker.grep, 'Live grep')
    MapSet('n', '<leader>er', snacks.picker.recent, 'Recent files')
    MapSet('n', '<leader>eu', snacks.picker.undo, 'Undo tree')
    MapSet('n', '<leader>bl', snacks.picker.buffers, 'List buffers')

    return {
        layout = 'default',
        ui_select = true,
    }
end

local setup_scratch = function(snacks)
    MapSet('n', '<leader>bso', snacks.scratch.open, 'Open scratch buffer')
    MapSet('n', '<leader>bss', snacks.scratch.select, 'Select scratch buffer')

    return {}
end

local setup_terminal = function(snacks)
    MapSet('n', '<leader>ot', snacks.terminal.toggle, 'Toggle floating terminal')
    local border = vim.api.nvim_get_option_value('winborder', {})

    return {
        win = {
            border = border,
            position = 'float',
        },
    }
end

Setup.now_if_args(function()
    vim.pack.add({ 'https://github.com/folke/snacks.nvim' })

    local snacks = require('snacks')
    snacks.setup({
        bigfile = setup_bigfile(snacks),
        image = setup_image(snacks),
        picker = setup_picker(snacks),
        scratch = setup_scratch(snacks),
        terminal = setup_terminal(snacks),
    })

    -- file explorer rename lsp integration
    Setup.new_autocmd(
        'User',
        'MiniFilesActionRename',
        function(event) snacks.rename.on_rename_file(event.data.from, event.data.to) end,
        'Rename file in explorer LSP integration'
    )
end)

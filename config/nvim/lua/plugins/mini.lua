-- Global table with information for leader keys
-- Will be used on 'mini.clue' for helping with keymaps
local leader_group_clues = {
    -- { mode = 'n', keys = '<Leader>b', desc = '+Buffer' },
    { mode = 'n', keys = '<Leader>e', desc = '+Explore/Edit' },
    -- { mode = 'n', keys = '<Leader>f', desc = '+Find' },
    -- { mode = 'n', keys = '<Leader>g', desc = '+Git' },
    -- { mode = 'n', keys = '<Leader>l', desc = '+Language' },
    -- { mode = 'n', keys = '<Leader>m', desc = '+Map' },
    -- { mode = 'n', keys = '<Leader>o', desc = '+Other' },
    -- { mode = 'n', keys = '<Leader>s', desc = '+Session' },
    -- { mode = 'n', keys = '<Leader>t', desc = '+Terminal' },
    -- { mode = 'n', keys = '<Leader>v', desc = '+Visits' },
    -- { mode = 'x', keys = '<Leader>g', desc = '+Git' },
    -- { mode = 'x', keys = '<Leader>l', desc = '+Language' },
}

return {
    'nvim-mini/mini.nvim',
    version = false,
    config = function()
        -- general
        require('mini.files').setup({
            mappings = {
                -- Allow both enter and L to enter dirs or open files
                go_in = '<CR>',
                go_in_plus = 'L',
                -- Allow both backspace and H to leave dirs
                go_out = '<BS>',
                go_out_plus = 'H'
            },
        })
        require('mini.fuzzy').setup()
        local MiniClue = require('mini.clue')
        MiniClue.setup({
            clues = {
                leader_group_clues,
                MiniClue.gen_clues.builtin_completion(),
                MiniClue.gen_clues.g(),
                MiniClue.gen_clues.marks(),
                MiniClue.gen_clues.registers(),
                MiniClue.gen_clues.square_brackets(),
                MiniClue.gen_clues.windows({ submode_resize = true }),
                MiniClue.gen_clues.z(),
            },
            triggers = {
                { mode = { 'n', 'x' }, keys = '<Leader>' }, -- Leader triggers
                -- { mode =   'n',        keys = '\\' },       -- mini.basics
                { mode = { 'n', 'x' }, keys = '[' },        -- mini.bracketed
                { mode = { 'n', 'x' }, keys = ']' },
                { mode =   'i',        keys = '<C-x>' },    -- Built-in completion
                { mode = { 'n', 'x' }, keys = 'g' },        -- `g` key
                { mode = { 'n', 'x' }, keys = "'" },        -- Marks
                { mode = { 'n', 'x' }, keys = '`' },
                { mode = { 'n', 'x' }, keys = '"' },        -- Registers
                { mode = { 'i', 'c' }, keys = '<C-r>' },
                { mode =   'n',        keys = '<C-w>' },    -- Window commands
                { mode = { 'n', 'x' }, keys = 's' },        -- `s` key (mini.surround, etc.)
                { mode = { 'n', 'x' }, keys = 'z' },        -- `z` key
            },
            window = {
                config = { width = 70, anchor = 'SE', row = 'auto', col = 'auto' },
                delay = 500,
                scroll_up = '<C-k>',
                scroll_down = '<C-j>',
            },
        })
        require('mini.notify').setup()
        require('mini.diff').setup()
        require('mini.git').setup()
        require('mini.sessions').setup()

        -- editings
        require('mini.ai').setup()
        require('mini.surround').setup()
        require('mini.comment').setup()
        require('mini.pairs').setup()
        require('mini.bracketed').setup()
        require('mini.trailspace').setup()
        require('mini.jump').setup()

        -- ui
        require('mini.starter').setup()
        require('mini.tabline').setup()
        require('mini.statusline').setup()
        require('mini.icons').setup()
        require('mini.cursorword').setup()
        local MiniHipatterns = require('mini.hipatterns')
        MiniHipatterns.setup({
            highlighters = {
                fixme = { pattern = '%f[%w]()FIXME()%f[%W]', group = 'MiniHipatternsFixme' },
                hack  = { pattern = '%f[%w]()HACK()%f[%W]',  group = 'MiniHipatternsHack'  },
                todo  = { pattern = '%f[%w]()TODO()%f[%W]',  group = 'MiniHipatternsTodo'  },
                note  = { pattern = '%f[%w]()NOTE()%f[%W]',  group = 'MiniHipatternsNote'  },

                hex_color = MiniHipatterns.gen_highlighter.hex_color(),
            },
        })
    end
}

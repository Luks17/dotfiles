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
        require('mini.clue').setup()
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
        require('mini.hipatterns').setup({
            highlighters = {
                fixme = { pattern = '%f[%w]()FIXME()%f[%W]', group = 'MiniHipatternsFixme' },
                hack  = { pattern = '%f[%w]()HACK()%f[%W]',  group = 'MiniHipatternsHack'  },
                todo  = { pattern = '%f[%w]()TODO()%f[%W]',  group = 'MiniHipatternsTodo'  },
                note  = { pattern = '%f[%w]()NOTE()%f[%W]',  group = 'MiniHipatternsNote'  },

                hex_color = require('mini.hipatterns').gen_highlighter.hex_color(),
            },
        })
    end
}

vim.pack.add({ 'https://github.com/nvim-mini/mini.nvim' })

local misc = require('mini.misc')
Setup.now = function(f) misc.safely('now', f) end
Setup.later = function(f) misc.safely('later', f) end
Setup.now_if_args = vim.fn.argc(-1) > 0 and Setup.now or Setup.later
Setup.on_event = function(ev, f) misc.safely('event:' .. ev, f) end
Setup.on_filetype = function(ft, f) misc.safely('filetype:' .. ft, f) end

-- Advanced text object manipulation
Setup.later(function()
    local mini_ai = require('mini.ai')
    mini_ai.setup({
        custom_textobjects = {
            F = mini_ai.gen_spec.treesitter({ a = '@function.outer', i = '@function.inner' }),
        },
        search_method = 'cover_or_next',
        n_lines = 200,
    })
end)

-- Navigation with brackets
Setup.later(function() require('mini.bracketed').setup() end)

-- Remove buffers in a smart manner.
Setup.later(function()
    local mini_bufremove = require('mini.bufremove')
    local mini_starter = require('mini.starter')

    mini_bufremove.setup()

    local open_dashboard_if_last_buffer = function()
        local buf_nr = vim.api.nvim_get_current_buf()
        local is_empty = vim.api.nvim_buf_get_name(buf_nr) == '' and vim.bo.filetype == ''
        if not is_empty then return end

        mini_starter.open()
        vim.schedule(function() vim.api.nvim_buf_delete(buf_nr, { force = true }) end) -- remove stray buffer
    end

    MapSet('n', '<leader>bc', function()
        mini_bufremove.delete()
        open_dashboard_if_last_buffer()
    end, 'Close current buffer')
end)

-- Show next key clues in a bottom right window.
Setup.later(function()
    local mini_clue = require('mini.clue')
    mini_clue.setup({
        clues = {
            Config.clues,
            mini_clue.gen_clues.builtin_completion(),
            mini_clue.gen_clues.g(),
            mini_clue.gen_clues.marks(),
            mini_clue.gen_clues.registers(),
            mini_clue.gen_clues.square_brackets(),
            mini_clue.gen_clues.windows({ submode_resize = true }),
            mini_clue.gen_clues.z(),
        },
        triggers = {
            { mode = { 'n', 'x' }, keys = '<Leader>' },
            { mode = { 'n', 'x' }, keys = '<localleader>' },
            -- { mode = 'n', keys = '\\' }, -- mini.basics
            { mode = { 'n', 'x' }, keys = '[' },
            { mode = { 'n', 'x' }, keys = ']' },
            { mode = 'i', keys = '<C-x>' },
            { mode = { 'n', 'x' }, keys = 'g' },
            { mode = { 'n', 'x' }, keys = "'" },
            { mode = { 'n', 'x' }, keys = '`' },
            { mode = { 'n', 'x' }, keys = '"' },
            { mode = { 'i', 'c' }, keys = '<C-r>' },
            { mode = 'n', keys = '<C-w>' },
            { mode = { 'n', 'x' }, keys = 's' },
            { mode = { 'n', 'x' }, keys = 'z' },
        },
        window = {
            config = {
                width = 70,
                anchor = 'SE',
                row = 'auto',
                col = 'auto',
            },
            delay = 500,
            scroll_up = '<C-k>',
            scroll_down = '<C-j>',
        },
    })
end)

-- Comment support
Setup.later(function()
    require('mini.comment').setup({
        options = {
            custom_commentstring = function()
                return require('ts_context_commentstring').calculate_commentstring() or vim.bo.commentstring
            end,
        },
    })
end)

-- Cursor hightlight at current word
Setup.later(function() require('mini.cursorword').setup() end)

-- Git diff integration
Setup.later(function() require('mini.diff').setup() end)

-- File explorer
Setup.later(function()
    local mini_files = require('mini.files')
    mini_files.setup({
        mappings = {
            go_in = '<CR>',
            go_in_plus = 'L',
            go_out = '<BS>',
            go_out_plus = 'H',
        },
    })

    MapSet('n', '<leader>ee', function()
        local is_file = vim.bo.buftype == ''
        local buf_name = vim.api.nvim_buf_get_name(0)

        if not is_file then
            mini_files.open()
        else
            mini_files.open(buf_name, false)
        end
        vim.schedule(function() mini_files.reveal_cwd() end)
    end, 'Open file explorer')
end)

-- Highlighting of colors and other patterns
Setup.later(function()
    local mini_hipatterns = require('mini.hipatterns')
    mini_hipatterns.setup({
        highlighters = {
            fixme = {
                pattern = '%f[%w]()FIXME()%f[%W]',
                group = 'MiniHipatternsFixme',
            },
            hack = {
                pattern = '%f[%w]()HACK()%f[%W]',
                group = 'MiniHipatternsHack',
            },
            todo = {
                pattern = '%f[%w]()TODO()%f[%W]',
                group = 'MiniHipatternsTodo',
            },
            note = {
                pattern = '%f[%w]()NOTE()%f[%W]',
                group = 'MiniHipatternsNote',
            },
            hex_color = mini_hipatterns.gen_highlighter.hex_color(),
        },
    })
end)

-- Icons provider
Setup.now(function() require('mini.icons').setup() end)

-- Split/Join arguments
Setup.later(function()
    local mini_splitjoin = require('mini.splitjoin')
    mini_splitjoin.setup({
        mappings = { toggle = '' }, -- Disable default bindings
    })

    MapSet({ 'n', 'x' }, 'sj', mini_splitjoin.join, 'Join arguments')
    MapSet({ 'n', 'x' }, 'sk', mini_splitjoin.split, 'Split arguments')
end)

-- Jump to next/previous single character
Setup.later(function() require('mini.jump').setup() end)

-- Notification provider
Setup.now(function() require('mini.notify').setup() end)

-- Start screen
Setup.now(
    function()
        require('mini.starter').setup({
            header = table.concat({
                '           .       .  ',
                '  .               .*. ',
                '        |\\___/|       ',
                '   .    )     (       ',
                '       =\\     /=      ',
                '         )===(       .',
                '        /     \\       ',
                ' *     |      |        ',
                '       /       \\   .  ',
                '       \\       /      ',
                '_/\\_/\\_/\\__  _/_/\\/\\_/',
                '|  |  |  |( (  |  |  |',
                '|  |  |  | ) ) |  |  |',
                '|  |  |  |(_(  |  |  |',
                '|  |  |  |  |  |  |  |',
            }, '\n'),
            footer = '',
        })
    end
)

-- Surrounding actions
Setup.later(function() require('mini.surround').setup() end)

-- Tab line
Setup.now(function() require('mini.tabline').setup() end)

-- Trail space
Setup.later(function()
    local mini_trailspace = require('mini.trailspace')
    mini_trailspace.setup()
    MapSet('n', '<leader>oc', mini_trailspace.trim, 'Trim all trailspace on file')
end)

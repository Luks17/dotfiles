return {
    -- ┌─────────────────────────┐
    -- │         General         │
    -- └─────────────────────────┘
    {
        'nvim-mini/mini.files',
        version = false,
        event = 'VeryLazy',
        config = function()
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
        end,
    },
    {
        'nvim-mini/mini.fuzzy',
        version = false,
        event = 'VeryLazy',
        config = function() require('mini.fuzzy').setup() end,
    },
    {
        'nvim-mini/mini.clue',
        version = false,
        event = 'VeryLazy',
        config = function()
            local leader_group_clues = {
                { mode = { 'n', 'x' }, keys = '<Leader>a', desc = '+AI' },
                { mode = { 'n', 'x' }, keys = '<Leader>ao', desc = '+OpenCode' },
                { mode = 'n', keys = '<Leader>b', desc = '+Buffer' },
                { mode = 'n', keys = '<Leader>bs', desc = '+Scratch' },
                { mode = 'n', keys = '<Leader>e', desc = '+Explore' },
                { mode = 'n', keys = '<Leader>g', desc = '+Git' },
                { mode = 'n', keys = '<Leader>gb', desc = '+Blame' },
                { mode = 'n', keys = '<Leader>d', desc = '+Debug' },
                { mode = 'n', keys = '<Leader>l', desc = '+LSP' },
                { mode = 'n', keys = '<Leader>t', desc = '+Testing' },
                { mode = 'n', keys = '<Leader>tc', desc = '+Coverage' },
                { mode = 'n', keys = '<Leader>o', desc = '+Other' },
                { mode = 'n', keys = '<Leader>ox', desc = '+Quickfix' },
                { mode = 'n', keys = '<Leader>p', desc = '+Package' },
            }

            local mini_clue = require('mini.clue')
            mini_clue.setup({
                clues = {
                    leader_group_clues,
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
        end,
    },
    {
        'nvim-mini/mini.notify',
        version = false,
        event = 'VeryLazy',
        config = function()
            local mini_notify = require('mini.notify')
            mini_notify.setup()

            MapSet('n', '<leader>on', mini_notify.show_history, 'Show notifications history')
        end,
    },
    {
        'nvim-mini/mini.diff',
        version = false,
        event = 'VeryLazy',
        config = function() require('mini.diff').setup() end,
    },
    {
        'nvim-mini/mini.bufremove',
        version = false,
        event = 'VeryLazy',
        dependencies = 'nvim-mini/mini.starter',
        config = function()
            local mini_bufremove = require('mini.bufremove')

            mini_bufremove.setup()

            local mini_starter = require('mini.starter')

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
        end,
    },
    -- ┌─────────────────────────┐
    -- │         Editing         │
    -- └─────────────────────────┘
    {
        'nvim-mini/mini.ai',
        version = false,
        event = { 'BufReadPre', 'BufNewFile' },
        dependencies = 'nvim-treesitter/nvim-treesitter-textobjects',
        config = function()
            local mini_ai = require('mini.ai')
            mini_ai.setup({
                custom_textobjects = {
                    F = mini_ai.gen_spec.treesitter({
                        a = '@function.outer',
                        i = '@function.inner',
                    }),
                },
                search_method = 'cover_or_next',
                n_lines = 200,
            })
        end,
    },
    {
        'nvim-mini/mini.surround',
        version = false,
        event = 'VeryLazy',
        config = function() require('mini.surround').setup() end,
    },
    {
        'nvim-mini/mini.comment',
        version = false,
        event = 'VeryLazy',
        config = function()
            require('mini.comment').setup({
                options = {
                    custom_commentstring = function()
                        return require('ts_context_commentstring').calculate_commentstring() or vim.bo.commentstring
                    end,
                },
            })
        end,
    },
    {
        'nvim-mini/mini.pairs',
        version = false,
        event = 'VeryLazy',
        config = function() require('mini.pairs').setup() end,
    },
    {
        'nvim-mini/mini.bracketed',
        version = false,
        event = 'VeryLazy',
        config = function() require('mini.bracketed').setup() end,
    },
    {
        'nvim-mini/mini.trailspace',
        version = false,
        event = 'VeryLazy',
        config = function()
            local mini_trailspace = require('mini.trailspace')
            mini_trailspace.setup()
            MapSet('n', '<leader>oc', mini_trailspace.trim, 'Trim all trailspace on file')
        end,
    },
    {
        'nvim-mini/mini.jump',
        version = false,
        event = 'VeryLazy',
        config = function() require('mini.jump').setup() end,
    },
    {
        'nvim-mini/mini.splitjoin',
        version = false,
        event = 'VeryLazy',
        config = function()
            local mini_splitjoin = require('mini.splitjoin')
            mini_splitjoin.setup({
                mappings = { toggle = '' }, -- Disable default bindings
            })

            MapSet({ 'n', 'x' }, 'sj', mini_splitjoin.join, 'Join arguments')
            MapSet({ 'n', 'x' }, 'sk', mini_splitjoin.split, 'Split arguments')
        end,
    },
    -- ┌─────────────────────────┐
    -- │            UI           │
    -- └─────────────────────────┘
    {
        'nvim-mini/mini.starter',
        version = false,
        lazy = false,
        config = function() require('mini.starter').setup() end,
    },
    {
        'nvim-mini/mini.icons',
        version = false,
        lazy = false,
        config = function() require('mini.icons').setup() end,
    },
    {
        'nvim-mini/mini.cursorword',
        version = false,
        event = 'VeryLazy',
        config = function() require('mini.cursorword').setup() end,
    },
    {
        'nvim-mini/mini.hipatterns',
        version = false,
        event = 'VeryLazy',
        config = function()
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
        end,
    },
}

return {
    {
        "nvim-mini/mini.files",
        version = false,
        config = function()
            require("mini.files").setup({
                mappings = {
                    go_in = "<CR>",
                    go_in_plus = "L",
                    go_out = "<BS>",
                    go_out_plus = "H",
                },
            })
        end,
    },
    {
        "nvim-mini/mini.fuzzy",
        version = false,
        event = "VeryLazy",
        config = function() require("mini.fuzzy").setup() end,
    },
    {
        "nvim-mini/mini.clue",
        version = false,
        event = "VeryLazy",
        config = function()
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

            local MiniClue = require("mini.clue")
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
                    { mode = { "n", "x" }, keys = "<Leader>" },
                    -- { mode = 'n', keys = '\\' }, -- mini.basics
                    { mode = { "n", "x" }, keys = "[" },
                    { mode = { "n", "x" }, keys = "]" },
                    { mode = "i", keys = "<C-x>" },
                    { mode = { "n", "x" }, keys = "g" },
                    { mode = { "n", "x" }, keys = "'" },
                    { mode = { "n", "x" }, keys = "`" },
                    { mode = { "n", "x" }, keys = '"' },
                    { mode = { "i", "c" }, keys = "<C-r>" },
                    { mode = "n", keys = "<C-w>" },
                    { mode = { "n", "x" }, keys = "s" },
                    { mode = { "n", "x" }, keys = "z" },
                },
                window = {
                    config = { width = 70, anchor = "SE", row = "auto", col = "auto" },
                    delay = 500,
                    scroll_up = "<C-k>",
                    scroll_down = "<C-j>",
                },
            })
        end,
    },
    {
        "nvim-mini/mini.notify",
        version = false,
        event = "VeryLazy",
        config = function() require("mini.notify").setup() end,
    },
    {
        "nvim-mini/mini.diff",
        version = false,
        event = "VeryLazy",
        config = function() require("mini.diff").setup() end,
    },
    {
        'nvim-mini/mini-git',
        version = false,
        event = "VeryLazy",
        config = function() require("mini.git").setup() end,
    },
    {
        "nvim-mini/mini.sessions",
        version = false,
        config = function() require("mini.sessions").setup() end,
    },
    {
        "nvim-mini/mini.ai",
        version = false,
        event = "VeryLazy",
        config = function() require("mini.ai").setup() end,
    },
    {
        "nvim-mini/mini.surround",
        version = false,
        event = "VeryLazy",
        config = function() require("mini.surround").setup() end,
    },
    {
        "nvim-mini/mini.comment",
        version = false,
        event = "VeryLazy",
        config = function() require("mini.comment").setup() end,
    },
    {
        "nvim-mini/mini.pairs",
        version = false,
        event = "VeryLazy",
        config = function() require("mini.pairs").setup() end,
    },
    {
        "nvim-mini/mini.bracketed",
        version = false,
        event = "VeryLazy",
        config = function() require("mini.bracketed").setup() end,
    },
    {
        "nvim-mini/mini.trailspace",
        version = false,
        event = "VeryLazy",
        config = function() require("mini.trailspace").setup() end,
    },
    {
        "nvim-mini/mini.jump",
        version = false,
        event = "VeryLazy",
        config = function() require("mini.jump").setup() end,
    },
    {
        "nvim-mini/mini.starter",
        version = false,
        lazy = false,
        config = function() require("mini.starter").setup() end,
    },
    {
        "nvim-mini/mini.tabline",
        version = false,
        lazy = false,
        config = function() require("mini.tabline").setup() end,
    },
    {
        "nvim-mini/mini.statusline",
        version = false,
        lazy = false,
        config = function() require("mini.statusline").setup() end,
    },
    {
        "nvim-mini/mini.icons",
        version = false,
        lazy = false,
        config = function() require("mini.icons").setup() end,
    },
    {
        "nvim-mini/mini.cursorword",
        version = false,
        event = "VeryLazy",
        config = function() require("mini.cursorword").setup() end,
    },
    {
        "nvim-mini/mini.hipatterns",
        version = false,
        event = "VeryLazy",
        config = function()
            local MiniHipatterns = require("mini.hipatterns")
            MiniHipatterns.setup({
                highlighters = {
                    fixme = { pattern = "%f[%w]()FIXME()%f[%W]", group = "MiniHipatternsFixme" },
                    hack  = { pattern = "%f[%w]()HACK()%f[%W]",  group = "MiniHipatternsHack"  },
                    todo  = { pattern = "%f[%w]()TODO()%f[%W]",  group = "MiniHipatternsTodo"  },
                    note  = { pattern = "%f[%w]()NOTE()%f[%W]",  group = "MiniHipatternsNote"  },
                    hex_color = MiniHipatterns.gen_highlighter.hex_color(),
                },
            })
        end,
    },
}

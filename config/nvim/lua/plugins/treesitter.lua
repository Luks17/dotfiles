return {
    "nvim-treesitter/nvim-treesitter",
    branch = "main",
    version = false,
    build = ':TSUpdate',
    event = { "VeryLazy" },
    config = function()
        local TS = require('nvim-treesitter')
        local parsers = {
            -- General
            'vim',
            'make',
            'gitcommit',
            'gitignore',

            -- Specs
            'dockerfile',
            'yaml',
            'json',
            'json5',
            'toml',
            'markdown',
            'html',
            'css',
            'scss',

            -- Langs
            'lua',
            'bash',
            'go',
            'rust',
            'php',
            'python',
            'javascript',
            'typescript',
            'tsx',
            'vue',
            'sql',
        }

        for _, parser in ipairs(parsers) do
            TS.install(parser)
        end

        vim.wo[0][0].foldexpr = 'v:lua.vim.treesitter.foldexpr()'
        vim.wo[0][0].foldmethod = 'expr'
        vim.api.nvim_command('set nofoldenable')

        vim.api.nvim_create_autocmd('FileType', {
            pattern = parsers,
            callback = function()
                vim.treesitter.start()
            end,
        })
    end,
    dependencies = {
        {
            'nvim-treesitter/nvim-treesitter-context',
            opts = {
                max_lines = 4,
                multiline_threshold = 2,
            },
        },
    },
}

return {
    {
        'nvim-treesitter/nvim-treesitter',
        branch = 'main',
        version = false,
        build = ':TSUpdate',
        event = { 'BufReadPre', 'BufNewFile' },
        config = function()
            local TS = require('nvim-treesitter')
            local parsers = {
                -- General
                'vim',
                'make',
                'gitcommit',
                'gitignore',
                'latex',
                'bibtex',

                -- Specs
                'dockerfile',
                'yaml',
                'json',
                'json5',
                'toml',
                'gomod',
                'gosum',
                'markdown',
                'css',
                'scss',
                'jsdoc',

                -- templating
                'html',
                'helm',

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
                'jsx',
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
                callback = function() vim.treesitter.start() end,
            })
        end,
        dependencies = {
            {
                'nvim-treesitter/nvim-treesitter-textobjects',
                branch = 'main',
                version = false,
                init = function() vim.g.no_plugin_maps = true end,
            },
            {
                'windwp/nvim-ts-autotag',
                config = function() require('nvim-ts-autotag').setup() end,
            },
            {
                'JoosepAlviste/nvim-ts-context-commentstring',
                config = function()
                    require('ts_context_commentstring').setup({
                        emnable_autocmd = false,
                    })
                end,
            },
        },
    },
}

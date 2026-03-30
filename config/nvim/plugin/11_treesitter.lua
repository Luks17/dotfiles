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

Setup.later(function()
    vim.pack.add({
        'https://github.com/nvim-treesitter/nvim-treesitter',
        'https://github.com/nvim-treesitter/nvim-treesitter-textobjects',
        'https://github.com/windwp/nvim-ts-autotag',
        'https://github.com/JoosepAlviste/nvim-ts-context-commentstring',
    })

    local treesitter = require('nvim-treesitter')
    require('nvim-ts-autotag').setup()
    require('ts_context_commentstring').setup({
        enable_autocmd = false,
    })

    for _, parser in ipairs(parsers) do
        treesitter.install(parser)
    end

    vim.wo[0][0].foldexpr = 'v:lua.vim.treesitter.foldexpr()'
    vim.wo[0][0].foldmethod = 'expr'
    vim.api.nvim_command('set nofoldenable')

    Setup.new_autocmd('FileType', parsers, function() vim.treesitter.start() end, 'Start treesitter')

    Setup.on_packchanged(
        'nvim-treesitter',
        { 'update' },
        function() vim.cmd('TSUpdate') end,
        'Update parsers on treesitter update'
    )
end)

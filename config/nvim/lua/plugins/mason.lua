return {
    'WhoIsSethDaniel/mason-tool-installer.nvim',
    event = 'VeryLazy',
    dependencies = {
        {
            'mason-org/mason.nvim',
            opts = {},
        },
        {
            'mason-org/mason-lspconfig.nvim',
            opts = {},
        },
    },
    config = function()
        require('mason-tool-installer').setup({
            ensure_installed = {
                -- lua
                'lua_ls',
                'stylua',

                -- golang
                'gopls',
                'golangci-lint-langserver',
                'gofumpt',
                'gotestsum',

                -- python
                'pyright',
                'isort',
                'black',

                -- html/css
                'html-lsp',
                'css-lsp',
                'emmet-ls',

                -- typescript/javascript
                'vtsls',
                'eslint',
                'prettierd',

                -- vue
                'vue_ls',
            },
        })

        vim.api.nvim_command('MasonToolsInstall')
    end,
}

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
            config = function()
                local do_not_autostart = {
                    'harper_ls',
                }

                require('mason-lspconfig').setup({
                    automatic_enable = {
                        exclude = do_not_autostart,
                    },
                })

                MapSet('n', '<leader>os', function()
                    local is_enabled = #(vim.lsp.get_clients({ name = 'harper_ls' })) == 1
                    vim.lsp.enable('harper_ls', not is_enabled)
                end, 'Toggle spelling')
            end,
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
                'gotestsum',

                -- python
                'pyright',
                'isort',
                'black',

                -- sql
                'sqlfluff',

                -- html/css
                'html-lsp',
                'css-lsp',
                'emmet-ls',

                -- typescript/javascript
                'vtsls',
                'js-debug-adapter',
                'eslint',
                'prettierd',
                'vue_ls',
                'tailwindcss',

                -- php
                'phpactor',
                'pint',

                -- json
                'json-lsp',

                -- helm
                'helm-ls',

                -- grammar
                'ltex-ls-plus', -- remove when harper starts supporting tex and pt-BR
                'harper_ls',
            },
        })

        vim.api.nvim_command('MasonToolsInstall')
    end,
}

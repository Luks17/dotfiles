local lua_config = {
    settings = {
        Lua = {
            diagnostics = {
                globals = { 'vim' },
            },
            workspace = {
                library = {
                    vim.fn.expand('$VIMRUNTIME/lua'),
                    vim.fn.expand('$XDG_CONFIG_HOME') .. '/nvim/lua',
                },
            },
            hint = { enable = true },
        },
    },
}

local vue_language_server_path = vim.fn.stdpath('data')
    .. '/mason/packages/vue-language-server/node_modules/@vue/language-server'

local vtsls_config = {
    settings = {
        vtsls = {
            tsserver = {
                globalPlugins = {
                    {
                        name = '@vue/typescript-plugin',
                        location = vue_language_server_path,
                        languages = { 'vue' },
                        configNamespace = 'typescript',
                    },
                },
            },
        },
    },
    filetypes = {
        'typescript',
        'javascript',
        'javascriptreact',
        'typescriptreact',
        'vue',
    },
}

local go_pls_config = {
    settings = {
        gopls = {
            codelenses = {
                generate = true,
                regenerate_cgo = true,
                test = false,
                tidy = true,
                upgrade_dependency = true,
                vendor = true,
            },
            completeUnimported = true,
        },
    },
}

return {
    'neovim/nvim-lspconfig',
    lazy = false,
    config = function()
        local lsp_configs = {
            lua_ls = lua_config,
            vtsls = vtsls_config,
            gopls = go_pls_config,
        }

        for server_name, config in pairs(lsp_configs) do
            vim.lsp.config(server_name, config)
        end
    end,
}

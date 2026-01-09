local lsp_configs = {
    lua_ls = {
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
    },
}

return {
    'neovim/nvim-lspconfig',
    lazy = false,
    config = function()
        for server_name, config in pairs(lsp_configs) do
            vim.lsp.config(server_name, config)
        end
    end,
}

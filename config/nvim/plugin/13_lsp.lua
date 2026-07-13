local function auto_enable()
    local tools = require('tools')
    local auto_enable_list = {}

    for _, tool in ipairs(tools.ensure_installed) do
        if tool.kind == 'lsp' then table.insert(auto_enable_list, tool.executable) end
    end

    return auto_enable_list
end

Setup.later(function()
    vim.pack.add({ 'https://github.com/neovim/nvim-lspconfig' })

    local lsp_executables = auto_enable()
    vim.lsp.enable(lsp_executables)

    vim.lsp.codelens.enable()
end)

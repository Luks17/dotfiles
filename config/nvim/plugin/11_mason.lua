Setup.later(function()
    vim.pack.add({
        'https://github.com/mason-org/mason.nvim',
    })

    require('mason').setup()
    local registry = require('mason-registry')
    local tools = require('tools')

    registry.refresh(function()
        for _, tool in ipairs(tools.ensure_installed) do
            local p = registry.get_package(tool.package)
            local is_globally_installed = vim.fn.executable(tool.package) == 1
            if not is_globally_installed and not p:is_installed() then
                vim.notify('Mason: ' .. tool.package .. ' will be installed...', vim.log.levels.INFO)
                p:install()
            end
        end
    end)
end)

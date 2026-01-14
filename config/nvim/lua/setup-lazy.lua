-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not (vim.uv or vim.loop).fs_stat(lazypath) then
    local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
    local out = vim.fn.system({
        'git',
        'clone',
        '--filter=blob:none',
        '--branch=stable',
        lazyrepo,
        lazypath,
    })
    if vim.v.shell_error ~= 0 then
        vim.api.nvim_echo({
            { 'Failed to clone lazy.nvim:\n', 'ErrorMsg' },
            { out, 'WarningMsg' },
            { '\nPress any key to exit...' },
        }, true, {})
        vim.fn.getchar()
        os.exit(1)
    end
end
vim.opt.rtp:prepend(lazypath)

local lazy = require('lazy')

-- Setup lazy.nvim
lazy.setup({
    { import = 'plugins' },
}, {
    checker = {
        enabled = true,
        notify = false,
    },
    change_detection = {
        notify = false,
    },
})

MapSet('n', '<leader>ps', lazy.show, 'Show installed packages')
MapSet('n', '<leader>pu', lazy.update, 'Update all installed packages')
MapSet('n', '<leader>pp', lazy.profile, 'Profile startup time')
MapSet('n', '<leader>pl', lazy.log, 'Show recent updates')
MapSet('n', '<leader>pc', lazy.check, 'Check for package updates and show the changelog')
MapSet('n', '<leader>px', lazy.clean, 'Clean packages not in use')
MapSet('n', '<leader>pr', function()
    local input = vim.fn.input('Packages to reload (comma-separated): ')
    if input == '' then return end

    local packages = vim.split(input, '[,%s]+', { trimempty = true })
    for i, pkg in ipairs(packages) do
        packages[i] = vim.trim(pkg)
    end

    require('lazy').reload({ plugins = packages })
end, 'Reload packages')

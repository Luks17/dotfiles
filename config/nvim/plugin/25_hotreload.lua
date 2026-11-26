-- Refreshes buffers efficiently when changed by agents, can be removed when neovim 0.13 releases
Setup.later(function()
    vim.pack.add({ 'https://github.com/diogo464/hotreload.nvim' })
    require('hotreload').setup()
end)

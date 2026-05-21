vim.pack.add({ 'https://github.com/vuki656/package-info.nvim' })

Setup.on_event('BufReadPost', function()
    local filename = vim.fn.expand('%:t')
    if filename ~= 'package.json' then return end

    require('package-info').setup()
end)

vim.pack.add({ 'https://github.com/vuki656/package-info.nvim' })

Setup.on_filetype('json', function() require('package-info').setup() end)

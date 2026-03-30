vim.pack.add({ 'https://github.com/windwp/nvim-autopairs' })
Setup.on_event('InsertEnter', function() require('nvim-autopairs').setup() end)

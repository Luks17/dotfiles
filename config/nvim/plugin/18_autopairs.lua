Setup.now(function() vim.pack.add({ 'https://github.com/windwp/nvim-autopairs' }) end)
Setup.on_event('InsertEnter', function() require('nvim-autopairs').setup() end)

vim.g.mapleader = ' '
vim.g.maplocalleader = ','

Config = {}

require('config.options')
require('config.filetype')
require('config.diagnostics')
require('config.terminal')
require('config.keymaps')
require('config.autocmd')
require('config.clues')

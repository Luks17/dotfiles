_G.MapSet = function(mode, lhs, rhs, desc)
    vim.keymap.set(mode, lhs, rhs, { silent = true, desc = desc })
end

-- Move blocks in virtual mode using J and K
MapSet('v', 'J', ":m '>+1<CR>gv=gv", 'Moves lines down in visual selection')
MapSet('v', 'K', ":m '<-2<CR>gv=gv", 'Moves lines up in visual selection')

-- Scroll centered
MapSet('n', '<C-d>', '<C-d>zz', 'Move down in buffer with cursor centered')
MapSet('n', '<C-u>', '<C-u>zz', 'Move up in buffer with cursor centered')

-- Next/previous search result centered
MapSet('n', 'n', 'nzzzv', 'Next result with cursor centered')
MapSet('n', 'N', 'Nzzzv', 'Previous result with cursor centered')

-- Change line indentation without needing to re-select
MapSet('v', '<', '<gv', 'Indent to the left')
MapSet('v', '>', '>gv', 'Indent to the right')

-- Blackhole register shortcut, useful for deleting without yanking using '_dd' or '_x'
MapSet({ 'n', 'v' }, '_', '"_', 'Shortcout to blackhole register')

-- Clear highlights
MapSet('n', '<Esc>', ':noh<CR>', 'Clear search highlights')

-- LSP
MapSet('n', '<leader>li', '<cmd>:LspInfo<CR>', 'LSP Info')
MapSet('n', '<leader>la', vim.lsp.buf.code_action, 'Code actions')
-- MapSet('n', '<leader>lA', vim.lsp.codelens, 'Code lens actions')
MapSet('n', '<leader>ll', vim.diagnostic.open_float, 'Get line diagnostics')
MapSet('n', '<leader>lr', vim.lsp.buf.rename, 'Rename symbol')
MapSet('n', '<leader>lb', vim.diagnostic.setloclist, 'List buffer diagnostics')

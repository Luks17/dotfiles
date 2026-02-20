---@param mode string|string[]
---@param lhs string
---@param rhs string|function
---@param desc? string
---@param other_opts? vim.keymap.set.Opts
MapSet = function(mode, lhs, rhs, desc, other_opts)
    vim.keymap.set(mode, lhs, rhs, vim.tbl_extend('force', { silent = true, desc = desc }, other_opts or {}))
end

-- Move blocks in virtual mode using J and K
MapSet('v', 'J', ":m '>+1<CR>gv=gv", 'Moves lines down in visual selection')
MapSet('v', 'K', ":m '<-2<CR>gv=gv", 'Moves lines up in visual selection')

-- Change line indentation without needing to re-select
MapSet('v', '<', '<gv', 'Indent to the left')
MapSet('v', '>', '>gv', 'Indent to the right')

-- Blackhole register shortcut, useful for deleting without yanking using '_dd' or '_x'
MapSet({ 'n', 'v' }, '_', '"_', 'Shortcout to blackhole register')

-- Clear highlights
MapSet('n', '<Esc>', ':noh<CR>', 'Clear search highlights')

-- Terminal
MapSet('t', '<Esc>', '<C-\\><C-n>', 'Exit terminal mode')
MapSet('n', '<leader>ot', require('config.terminal').toggle_terminal, 'Toggle floating terminal')

-- LSP
MapSet('n', '<leader>li', '<cmd>:LspInfo<CR>', 'LSP Info')
MapSet('n', '<leader>la', vim.lsp.buf.code_action, 'Code actions')
MapSet('n', '<leader>lA', vim.lsp.codelens.run, 'Code lens actions')
MapSet('n', '<leader>ll', vim.diagnostic.open_float, 'Get line diagnostics')
MapSet('n', '<leader>lr', vim.lsp.buf.rename, 'Rename symbol')
MapSet('n', '<leader>lb', vim.diagnostic.setloclist, 'List buffer diagnostics')

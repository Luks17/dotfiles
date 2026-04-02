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

-- LSP
MapSet('n', '<leader>li', '<cmd>:LspInfo<CR>', 'LSP Info')
MapSet('n', '<leader>la', vim.lsp.buf.code_action, 'Code actions')
MapSet('n', '<leader>lA', vim.lsp.codelens.run, 'Code lens actions')
MapSet('n', '<leader>ll', vim.diagnostic.open_float, 'Get line diagnostics')
MapSet('n', '<leader>lr', vim.lsp.buf.rename, 'Rename symbol')
MapSet('n', '<leader>lb', vim.diagnostic.setloclist, 'List buffer diagnostics')
MapSet('n', '<leader>lt', function() vim.lsp.codelens.enable(not vim.lsp.codelens.is_enabled()) end, 'Toggle codelens')

-- Incremental selection
MapSet({ 'n', 'x' }, '<enter>', function()
    if vim.treesitter.get_parser(nil, nil, { error = false }) then
        require('vim.treesitter._select').select_parent(vim.v.count1)
    else
        vim.lsp.buf.selection_range(vim.v.count1)
    end
end, 'Select parent treesitter node or outer incremental lsp selections')

MapSet({ 'n', 'x', 'o' }, '<backspace>', function()
    if vim.treesitter.get_parser(nil, nil, { error = false }) then
        require('vim.treesitter._select').select_child(vim.v.count1)
    else
        vim.lsp.buf.selection_range(-vim.v.count1)
    end
end, 'Select child treesitter node or inner incremental lsp selections')

-- Shortcuts for vim.pack
MapSet('n', '<leader>pu', vim.pack.update, 'Update all installed plugins')
MapSet('n', '<leader>pl', function() vim.pack.update(nil, { offline = true }) end, 'List installed plugins')

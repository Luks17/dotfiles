local nmap = function(mode, lhs, rhs, desc)
    vim.keymap.set(mode, lhs, rhs, { silent = true, desc = desc })
end

-- Move blocks in virtual mode using J and K
nmap("v", "J", ":m '>+1<CR>gv=gv", "Moves lines down in visual selection")
nmap("v", "K", ":m '<-2<CR>gv=gv", "Moves lines up in visual selection")

-- Scroll centered
nmap("n", "<C-d>", "<C-d>zz", "Move down in buffer with cursor centered")
nmap("n", "<C-u>", "<C-u>zz", "Move up in buffer with cursor centered")

-- Next/previous search result centered
nmap("n", "n", "nzzzv", "Next result with cursor centered")
nmap("n", "N", "Nzzzv", "Previous result with cursor centered")

-- Change line indentation without needing to re-select
nmap("v", "<", "<gv", "Indent to the left")
nmap("v", ">", ">gv", "Indent to the right")

-- Blackhole register shortcut, useful for deleting without yanking using '_dd' or '_x'
nmap({'n', 'v'}, '_', '"_', "Shortcout to blackhole register")

-- Clear highlights
nmap('n', '<Esc>', ':noh<CR>', "Clear search highlights")

-- Trim trailspace
local MiniTrailspace = require('mini.trailspace')
nmap('n', '<C-t>', MiniTrailspace.trim, "Trim all trailspace on file")

-- Toggle file explorer
local MiniFiles = require('mini.files')
nmap('n', '<leader>ee', MiniFiles.open, "Toggle mini file explorer")

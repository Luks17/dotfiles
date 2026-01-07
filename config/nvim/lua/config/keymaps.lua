local nmap = function(mode, lhs, rhs, desc)
    vim.keymap.set(mode, lhs, rhs, { silent = true, desc = desc })
end

-- Move blocks in virtual mode using J and K
nmap("v", "J", ":m '>+1<CR>gv=gv", "moves lines down in visual selection")
nmap("v", "K", ":m '<-2<CR>gv=gv", "moves lines up in visual selection")

-- Scroll centered
nmap("n", "<C-d>", "<C-d>zz", "move down in buffer with cursor centered")
nmap("n", "<C-u>", "<C-u>zz", "move up in buffer with cursor centered")

-- Next/previous search result centered
nmap("n", "n", "nzzzv", "next result with cursor centered")
nmap("n", "N", "Nzzzv", "previous result with cursor centered")

-- Change line indentation without needing to re-select
nmap("v", "<", "<gv", "indent to the left")
nmap("v", ">", ">gv", "indent to the right")

-- Blackhole register shortcut, useful for deleting without yanking using '_dd' or '_x'
nmap({'n', 'v'}, '_', '"_', "shortcout to blackhole register")

-- Clear highlights
nmap('n', '<Esc>', ':noh<CR>', "clear search highlights")

-- Trim trailspace
local MiniTrailspace = require('mini.trailspace')
nmap('n', '<C-t>', MiniTrailspace.trim, "trim all trailspace on file")

-- Toggle file explorer
local MiniFiles = require('mini.files')
nmap('n', '<leader>ee', MiniFiles.open, "toggle mini file explorer")

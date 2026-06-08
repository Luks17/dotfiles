Config.clues = {
    { mode = 'n', keys = '<Leader>b', desc = '+Buffer' },
    { mode = 'n', keys = '<Leader>e', desc = '+Explore' },
    { mode = 'n', keys = '<Leader>l', desc = '+LSP' },
    { mode = 'n', keys = '<Leader>o', desc = '+Other' },
    { mode = 'n', keys = '<Leader>p', desc = '+Package' },
}

AddClues = function(clues) vim.list_extend(Config.clues, clues) end

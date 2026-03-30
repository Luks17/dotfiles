Config.clues = {
    { mode = { 'n', 'x' }, keys = '<Leader>a', desc = '+AI' },
    { mode = { 'n', 'x' }, keys = '<Leader>ao', desc = '+OpenCode' },
    { mode = 'n', keys = '<Leader>b', desc = '+Buffer' },
    { mode = 'n', keys = '<Leader>bs', desc = '+Scratch' },
    { mode = 'n', keys = '<Leader>e', desc = '+Explore' },
    { mode = 'n', keys = '<Leader>g', desc = '+Git' },
    { mode = 'n', keys = '<Leader>gb', desc = '+Blame' },
    { mode = 'n', keys = '<Leader>d', desc = '+Debug' },
    { mode = 'n', keys = '<Leader>l', desc = '+LSP' },
    { mode = 'n', keys = '<Leader>t', desc = '+Testing' },
    { mode = 'n', keys = '<Leader>tc', desc = '+Coverage' },
    { mode = 'n', keys = '<Leader>o', desc = '+Other' },
    { mode = 'n', keys = '<Leader>ox', desc = '+Quickfix' },
    { mode = 'n', keys = '<Leader>p', desc = '+Package' },
}

AddClues = function(clues) vim.list_extend(Config.clues, clues) end

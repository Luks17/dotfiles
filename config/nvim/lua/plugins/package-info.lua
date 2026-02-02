return {
    'vuki656/package-info.nvim',
    dependencies = { 'MunifTanjim/nui.nvim' },
    event = 'BufEnter package.json',
    opts = {},
    configuration = function() require('package-info').setup() end,
}

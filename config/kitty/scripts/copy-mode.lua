local buf = vim.api.nvim_get_current_buf()

vim.api.nvim_open_term(buf, {})

vim.opt_local.scrollback = 100000
vim.opt_local.showtabline = 0

vim.wo.number = false
vim.wo.relativenumber = false
vim.wo.signcolumn = "no"
vim.wo.wrap = false
vim.wo.list = false

vim.api.nvim_win_set_cursor(0, { vim.api.nvim_buf_line_count(buf), 0 })

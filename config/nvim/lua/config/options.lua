-- General
vim.opt.mouse = 'a' -- Enable mouse
vim.opt.mousescroll = 'ver:2,hor:1' -- Customize mouse scroll
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.undofile = true -- Persist undo
vim.opt.switchbuf = 'useopen,uselast'
vim.opt.backspace = { 'start', 'eol', 'indent' } -- Override default backspace behavior in insert mode
vim.opt.clipboard:append('unnamedplus') -- Allow shared clipboard with system
vim.opt.wrap = true -- Line wrap
vim.opt.autoread = true -- When a file has been changed outside of vim, automatically reload it
vim.opt.swapfile = false

-- Indentation
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.autoindent = true
vim.opt.smartindent = true
vim.opt.breakindent = true -- Indent wrapped lines to match line start

-- Editing
vim.opt.ignorecase = true -- Ignore case during search
vim.opt.incsearch = true -- Show search matches while typing
vim.opt.infercase = true -- Infer case in built-in completion
vim.opt.smartcase = true -- Respect case if search pattern has upper case
vim.opt.spelloptions = 'camel' -- Treat camelCase word parts as separate words
vim.opt.virtualedit = 'block' -- Allows cursor at locations where no actual character exists when in certain modes, such as beyond the end of a line or within a tab.
vim.opt.scrolloff = 10 -- Minimum number of screen lines to keep above and below the cursor
vim.opt.cursorline = true -- Highlight line under cursor
vim.opt.cursorlineopt = 'number' -- Where to hightlight

-- UI
vim.opt.fillchars = { eob = ' ' } -- Replace end of buffer with space instead of ~
vim.opt.signcolumn = 'yes'
vim.opt.splitbelow = true -- Horizontal splits will be below
vim.opt.splitright = true -- Vertical splits will be to the right
vim.opt.splitkeep = 'screen' -- Reduce scroll during window split
vim.opt.showmode = false -- Don't show mode in command line
vim.opt.winborder = 'single' -- Use border in floating windows
vim.opt.hlsearch = true -- Highlight searched text

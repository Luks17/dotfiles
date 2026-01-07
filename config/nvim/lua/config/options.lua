vim.cmd('let g:netrw_banner = 0')

-- General
vim.o.mouse = 'a' -- Enable mouse
vim.o.mousescroll = 'ver:2,hor:1' -- Customize mouse scroll
vim.o.number = true
vim.o.relativenumber = true
vim.o.undofile = true -- Persist undo
vim.o.switchbuf = 'usetab' -- Use already opened buffers when switching
vim.opt.backspace = { 'start', 'eol', 'indent' } -- Override default backspace behavior in insert mode
vim.opt.clipboard:append('unnamedplus') -- Allow shared clipboard with system
vim.o.wrap = true -- Line wrap

-- Indentation
vim.o.tabstop = 4
vim.o.softtabstop = 4
vim.o.shiftwidth = 4
vim.o.expandtab = true
vim.o.autoindent = true
vim.o.smartindent = true
vim.o.breakindent = true -- Indent wrapped lines to match line start

-- Editing
vim.o.ignorecase = true -- Ignore case during search
vim.o.incsearch = true -- Show search matches while typing
vim.o.infercase = true -- Infer case in built-in completion
vim.o.smartcase = true -- Respect case if search pattern has upper case
vim.o.spelloptions = 'camel' -- Treat camelCase word parts as separate words
vim.o.virtualedit = 'block' -- Allows cursor at locations where no actual character exists when in certain modes, such as beyond the end of a line or within a tab.

-- UI
vim.opt.fillchars = { eob = ' ' }
vim.o.signcolumn = 'yes'
vim.o.splitbelow = true -- Horizontal splits will be below
vim.o.splitright = true -- Vertical splits will be to the right
vim.o.splitkeep = 'screen' -- Reduce scroll during window split
vim.o.showmode = false -- Don't show mode in command line
vim.o.winborder = 'single' -- Use border in floating windows
vim.o.hlsearch = true -- Highlight searched text

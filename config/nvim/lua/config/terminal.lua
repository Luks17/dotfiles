local util = require('config.util')

local terminal_state = {
    buf = nil,
    win = nil,
}

local function is_open() return terminal_state.win and vim.api.nvim_win_is_valid(terminal_state.win) end

local function hide() vim.api.nvim_win_hide(terminal_state.win) end

local function toggle_terminal()
    if not is_open() then
        terminal_state = util.create_floating_window({ buf = terminal_state.buf })
        if vim.bo[terminal_state.buf].buftype ~= 'terminal' then
            vim.fn.jobstart(vim.o.shell, { term = true })
            vim.cmd('startinsert')

            vim.api.nvim_create_autocmd('TermClose', {
                buffer = terminal_state.buf,
                once = true,
                callback = function()
                    if is_open() then
                        hide()
                        vim.api.nvim_buf_delete(terminal_state.buf, { force = true })
                    end
                end,
            })
        end
    else
        hide()
    end
end

vim.api.nvim_create_user_command('ToggleTerminal', toggle_terminal, {})

return { toggle_terminal = toggle_terminal }

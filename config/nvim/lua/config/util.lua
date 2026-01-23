local function create_floating_window(opts)
    opts = opts or {}
    local buf = opts.buf or -1
    local width = opts.width or math.floor(vim.o.columns * 0.8)
    local height = opts.height or math.floor(vim.o.lines * 0.8)

    local col = math.floor((vim.o.columns - width) / 2)
    local row = math.floor((vim.o.lines - height) / 2)

    if buf < 0 or not vim.api.nvim_buf_is_valid(buf) then
        buf = vim.api.nvim_create_buf(false, true) -- Create scratch buffer
    end

    local win_config = {
        relative = 'editor',
        width = width,
        height = height,
        col = col,
        row = row,
        style = 'minimal',
        border = 'rounded',
    }

    local win = vim.api.nvim_open_win(buf, true, win_config)

    return { buf = buf, win = win }
end

local function merge_tables(...) return vim.tbl_deep_extend('force', ...) end

return {
    create_floating_window = create_floating_window,
    merge_tables = merge_tables,
}

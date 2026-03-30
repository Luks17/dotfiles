-- Show diagnostics in virtual text if cursor not in line
-- Show diagnostics in virtual lines if cursor in line

vim.diagnostic.config({
    virtual_text = true,
    virtual_lines = { current_line = true },
    underline = true,
    update_in_insert = false,
})

local og_virt_text
local og_virt_line
Setup.new_autocmd({ 'CursorMoved', 'DiagnosticChanged' }, {}, function()
    if og_virt_line == nil then og_virt_line = vim.diagnostic.config().virtual_lines end

    -- ignore if virtual_lines.current_line is disabled
    if not (og_virt_line and og_virt_line.current_line) then
        if og_virt_text then
            vim.diagnostic.config({ virtual_text = og_virt_text })
            og_virt_text = nil
        end
        return
    end

    if og_virt_text == nil then og_virt_text = vim.diagnostic.config().virtual_text end

    local lnum = vim.api.nvim_win_get_cursor(0)[1] - 1

    if vim.tbl_isempty(vim.diagnostic.get(0, { lnum = lnum })) then
        vim.diagnostic.config({ virtual_text = og_virt_text })
    else
        vim.diagnostic.config({ virtual_text = false })
    end
end, 'Show diagnostics virtual text if cursor not in line, else virtual lines')

Setup.new_autocmd('ModeChanged', {}, function() pcall(vim.diagnostic.show) end, 'Redraw diagnostics on mode change')

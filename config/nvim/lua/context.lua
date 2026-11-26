-- Formatting and collectors adapted from opencode.nvim (4851ae5).
-- MIT License
--
-- Copyright (c) 2025 Nick van Dyke
--
-- Permission is hereby granted, free of charge, to any person obtaining a copy
-- of this software and associated documentation files (the "Software"), to deal
-- in the Software without restriction, including without limitation the rights
-- to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
-- copies of the Software, and to permit persons to whom the Software is
-- furnished to do so, subject to the following conditions:
--
-- The above copyright notice and this permission notice shall be included in all
-- copies or substantial portions of the Software.
--
-- THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
-- IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
-- FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
-- AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
-- LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
-- OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
-- SOFTWARE.

-- Locations use one-based rows and byte columns.
local function format_position(pos)
    return 'L' .. pos[1] .. (pos[2] and ':C' .. pos[2] or '')
end

local function format_location(buf, cwd, first, last)
    local path = vim.api.nvim_buf_get_name(buf)
    if path == '' then return nil end

    local stat = vim.uv.fs_stat(path)
    if not stat or stat.type ~= 'file' then
        local start_line = first and first[1] or 1
        local end_line = last and last[1] or first and first[1] or -1
        local lines = vim.api.nvim_buf_get_lines(buf, start_line - 1, end_line, false)
        if #lines == 0 then return nil end
        if last and last[2] then lines[#lines] = lines[#lines]:sub(1, last[2]) end
        if first and first[2] then lines[1] = lines[1]:sub(first[2]) end
        return table.concat(lines, '\n')
    end

    local prefix = vim.endswith(cwd, '/') and cwd or cwd .. '/'
    if vim.startswith(path, prefix) then path = path:sub(#prefix + 1) end
    if first then path = path .. ':' .. format_position(first) end
    if last then path = path .. '-' .. format_position(last) end
    return path
end

local function range_from_marks(start_mark, end_mark, linewise)
    local _, start_line, start_col = unpack(vim.fn.getpos(start_mark))
    local _, end_line, end_col = unpack(vim.fn.getpos(end_mark))
    if start_line == 0 or end_line == 0 then return nil, nil end
    if start_line > end_line or (start_line == end_line and start_col > end_col) then
        start_line, end_line = end_line, start_line
        start_col, end_col = end_col, start_col
    end
    if linewise then return { start_line }, { end_line } end
    return { start_line, math.max(start_col, 1) }, { end_line, math.max(end_col, 1) }
end

local function overlaps(diagnostic, first, last)
    local start_line, end_line = first[1] - 1, last[1] - 1
    if diagnostic.lnum > end_line or diagnostic.end_lnum < start_line then return false end
    if first[2] and diagnostic.end_lnum == start_line and diagnostic.end_col < first[2] - 1 then return false end
    if last[2] and diagnostic.lnum == end_line and diagnostic.col > last[2] - 1 then return false end
    return true
end

local function diagnostics(buf, cwd)
    local mode = vim.fn.mode()
    local first, last
    if mode == 'v' or mode == 'V' or mode == '\22' then
        first, last = range_from_marks('v', '.', mode == 'V')
    end

    local lines = {}
    for _, diagnostic in ipairs(vim.diagnostic.get(buf)) do
        if not first or overlaps(diagnostic, first, last) then
            local start_pos = { diagnostic.lnum + 1, diagnostic.col + 1 }
            local end_pos = { diagnostic.end_lnum + 1, diagnostic.end_col + 1 }
            local location = format_location(buf, cwd, start_pos, end_pos) or format_position(start_pos)
            local message = vim.trim(diagnostic.message:gsub('%s+', ' '))
            table.insert(lines, ('- %s (%s): %s'):format(location, diagnostic.source or 'unknown', message))
        end
    end
    if #lines == 0 then return nil end
    return #lines .. ' diagnostic(s):\n' .. table.concat(lines, '\n')
end

local function buffers(_, cwd)
    local locations = {}
    for _, info in ipairs(vim.fn.getbufinfo({ buflisted = 1 })) do
        local location = format_location(info.bufnr, cwd)
        if location then table.insert(locations, location) end
    end
    return table.concat(locations, ', ')
end

local function quickfix(_, cwd)
    local locations = {}
    for _, entry in ipairs(vim.fn.getqflist()) do
        if entry.bufnr ~= 0 then
            local location = format_location(entry.bufnr, cwd, { entry.lnum, entry.col })
            if location then table.insert(locations, location) end
        end
    end
    return table.concat(locations, ', ')
end

local renderers = {
    buffer = function(buf, cwd) return format_location(buf, cwd) end,
    buffers = buffers,
    diagnostics = diagnostics,
    quickfix = quickfix,
    range = function(buf, cwd, motion_type)
        local first, last = range_from_marks("'[", "']", motion_type == 'line')
        if first then return format_location(buf, cwd, first, last) end
    end,
}

local M = {}

---@param kind 'buffer'|'buffers'|'diagnostics'|'quickfix'|'range'
---@param motion_type? 'char'|'line'|'block' Only used for the operator range.
---@return string?
function M.render(kind, motion_type)
    return renderers[kind](vim.api.nvim_get_current_buf(), vim.fn.getcwd(), motion_type)
end

return M

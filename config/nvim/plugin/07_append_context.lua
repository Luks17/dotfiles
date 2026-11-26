--- Custom config to imitate https://github.com/NickvanDyke/opencode.nvim context appending,
--- but with multiplexers and without all opencode-specific stuff

local herdr = require('herdr')
local context = require('context')

local function with_target_pane(callback)
    local own_id = vim.env.HERDR_PANE_ID
    local panes = herdr.panes() or {}
    local own_pane = vim.iter(panes):find(function(pane) return pane.pane_id == own_id end)
    if not own_pane or not own_pane.tab_id then
        vim.notify('Could not identify the current Herdr pane and tab', vim.log.levels.WARN)
        return
    end

    local matches = {}
    for _, pane in ipairs(panes) do
        if pane.tab_id == own_pane.tab_id and pane.pane_id ~= own_id then table.insert(matches, pane) end
    end

    if #matches == 1 then
        callback(matches[1])
    elseif #matches > 1 then
        vim.ui.select(matches, {
            prompt = 'Append context to Herdr pane:',
            format_item = function(pane)
                local title = pane.terminal_title_stripped or pane.terminal_title
                if not title or title == '' then title = pane.agent end
                return title and title ~= '' and ('%s — %s'):format(pane.pane_id, title) or pane.pane_id
            end,
        }, callback)
    else
        vim.notify('No other panes in this Herdr tab', vim.log.levels.WARN)
    end
end

local function append(kind, motion_type)
    local value = context.render(kind, motion_type)
    if not value or value == '' then
        vim.notify('No ' .. kind .. ' context to append', vim.log.levels.INFO)
        return
    end

    -- Flatten control characters rather than sending keystrokes (such as Enter) to the pane.
    local text = value:gsub('[%z\1-\31\127]+', ' ') .. ' '
    with_target_pane(function(pane)
        if not pane then return end
        if not herdr.pane_send_text(pane.pane_id, text) then
            vim.notify('Could not append context to Herdr pane ' .. pane.pane_id, vim.log.levels.WARN)
        end
    end)
end

local modes = { 'n', 'x' }
MapSet(modes, '<leader>ab', function() append('buffer') end, 'Append buffer')
MapSet(modes, '<leader>aB', function() append('buffers') end, 'Append all listed buffers')
MapSet(modes, '<leader>ad', function() append('diagnostics') end, 'Append current buffer diagnostics')
MapSet(modes, '<leader>aq', function() append('quickfix') end, 'Append quickfix')

_G.AppendContextOperator = function(motion_type) append('range', motion_type) end

local function operator()
    vim.go.operatorfunc = 'v:lua.AppendContextOperator'
    return 'g@'
end
MapSet(modes, '<leader>ar', operator, 'Append range', { expr = true })
MapSet('n', '<leader>al', function() return operator() .. '_' end, 'Append line', { expr = true })

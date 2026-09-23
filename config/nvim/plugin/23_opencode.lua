Setup.later(function()
    vim.pack.add({ 'https://github.com/NickvanDyke/opencode.nvim' })

    AddClues({ { mode = { 'n', 'x' }, keys = '<Leader>ao', desc = '+OpenCode' } })

    local herdr = require('herdr')
    local builtins = require('opencode.context.builtins')
    local Context = require('opencode.context')

    local function with_target_pane(callback)
        local panes = herdr.panes() or {}
        local matches = {}
        for _, pane in ipairs(panes) do
            if pane.tab_id == vim.env.HERDR_TAB_ID and pane.agent == 'opencode' then
                table.insert(matches, pane.pane_id)
            end
        end

        if #matches == 1 then return callback(matches[1]) end
        if #matches > 1 then
            vim.ui.select(matches, { prompt = 'OpenCode pane:' }, callback)
        else
            vim.notify('No OpenCode pane in this Herdr tab', vim.log.levels.WARN)
        end
    end

    local function range_from_marks(first, last, kind)
        local from = vim.fn.getpos(first)
        local to = vim.fn.getpos(last)
        if from[2] == 0 or to[2] == 0 then return nil end
        local start = { from[2], math.max(from[3] - 1, 0) }
        local finish = { to[2], math.max(to[3] - 1, 0) }
        if start[1] > finish[1] or (start[1] == finish[1] and start[2] > finish[2]) then
            start, finish = finish, start
        end
        return { from = start, to = finish, kind = kind }
    end

    local function context(range)
        return {
            buf = vim.api.nvim_get_current_buf(),
            cursor = vim.api.nvim_win_get_cursor(0),
            range = range,
            format = Context.format,
        }
    end

    local function append(kind, range)
        local value = builtins[kind](context(range))
        if not value or value == '' then
            vim.notify('No ' .. kind .. ' context to add', vim.log.levels.INFO)
            return
        end
        with_target_pane(function(pane_id)
            if not pane_id then return end
            -- Newlines sent as terminal input could submit the draft prompt.
            if not herdr.pane_send_text(pane_id, value:gsub('[\r\n]+', ' ') .. ' ') then
                vim.notify('Could not append to OpenCode pane ' .. pane_id, vim.log.levels.WARN)
            end
        end)
    end

    local function visual_range()
        local mode = vim.fn.mode()
        local kind = mode == 'V' and 'line' or mode == '\22' and 'block' or 'char'
        return range_from_marks('v', '.', kind)
    end

    local function append_context(kind)
        local mode = vim.fn.mode()
        append(kind, (mode == 'v' or mode == 'V' or mode == '\22') and visual_range() or nil)
    end

    MapSet({ 'n', 'x' }, '<leader>aoe', function() require('opencode').select() end, 'Execute action')
    MapSet({ 'n', 'x' }, '<leader>aob', function() append_context('buffer') end, 'Add buffer to opencode')
    MapSet({ 'n', 'x' }, '<leader>aoB', function() append_context('buffers') end, 'Add all open buffers to opencode')
    MapSet(
        { 'n', 'x' },
        '<leader>aod',
        function() append_context('diagnostics') end,
        'Add current buffer diagnostics to opencode'
    )
    MapSet({ 'n', 'x' }, '<leader>aoq', function() append_context('quickfix') end, 'Add quickfix to opencode')

    _G.OpencodeAppendOperator = function(type)
        local kind = type == 'line' and 'line' or type == 'block' and 'block' or 'char'
        append('this', range_from_marks("'[", "']", kind))
    end

    local function operator()
        vim.go.operatorfunc = 'v:lua.OpencodeAppendOperator'
        return 'g@'
    end
    MapSet({ 'n', 'x' }, '<leader>aor', operator, 'Add range to opencode', { expr = true })
    MapSet('n', '<leader>aol', function() return operator() .. '_' end, 'Add line to opencode', { expr = true })
end)

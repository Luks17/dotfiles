local herdr_args = { 'herdr', 'pane' }

---@param args string[]
---@return boolean ok
---@return table|nil result
---@return string output
local function herdr_command(args)
    local output = vim.fn.system(vim.list_extend(vim.deepcopy(herdr_args), args))
    if vim.v.shell_error ~= 0 then return false, nil, output end
    if vim.trim(output) == '' then return true, nil, output end

    local ok, response = pcall(vim.json.decode, output)
    if not ok then return false, nil, output end

    return true, response.result, output
end

---Check if Herdr is available.
---
---@return boolean
local function is_herdr_available()
    if vim.env.HERDR_ENV ~= '1' then return false end
    if vim.fn.executable('herdr') ~= 1 then return false end

    return true
end

---Check if a Herdr pane exists.
---
---@param pane_id string|nil
---@return boolean
local function herdr_pane_exists(pane_id)
    if not pane_id or pane_id == '' then return false end

    local ok = herdr_command({ 'get', pane_id })
    return ok
end

---Send a command to a Herdr pane.
---
---@param pane_id string|nil
---@param cmd string
---@return boolean
local function herdr_pane_cmd(pane_id, cmd)
    if not herdr_pane_exists(pane_id) then return false end

    local ok = herdr_command({ 'run', pane_id, cmd })
    return ok
end

---Create a Herdr pane from Neovim.
---
---If not running inside Herdr or if the `herdr` executable is not available,
---this returns `nil` and does nothing.
---
---@param opts? table Optional settings.
---@param opts.direction? '"vertical"'|'"horizontal"' Split direction.
---  - `"vertical"`: side-by-side panes (default)
---  - `"horizontal"`: top/bottom panes
---@param opts.ratio? number Fraction of the current pane allocated to the new pane (default: `0.33`).
---@param opts.focus? boolean Focus the new pane. If omitted, defaults to `true`.
---@param opts.cwd? string Working directory for the new pane. If omitted, uses `vim.fn.getcwd()`.
---@param opts.cmd? string Command to run in the new pane. If omitted, the pane starts the default shell.
---@return string|nil pane_id New Herdr pane id (e.g. `"w1:p2"`), or `nil` on failure.
local function herdr_split(opts)
    opts = opts or {}

    if not is_herdr_available() then return nil end

    local ratio = opts.ratio or 0.33
    ratio = 1 - ratio

    local args = {
        'split',
        '--current',
        '--direction',
        opts.direction == 'horizontal' and 'down' or 'right',
        '--ratio',
        tostring(ratio),
        opts.focus == false and '--no-focus' or '--focus',
    }

    local cwd = opts.cwd or vim.fn.getcwd()
    if cwd and cwd ~= '' then vim.list_extend(args, { '--cwd', cwd }) end

    local ok, result, output = herdr_command(args)
    if not ok then
        vim.notify(('Herdr split failed: %s'):format(output), vim.log.levels.WARN)
        return nil
    end

    local pane_id = result and result.pane and result.pane.pane_id
    if not pane_id or pane_id == '' then return nil end

    if opts.cmd and opts.cmd ~= '' then herdr_pane_cmd(pane_id, opts.cmd) end

    return pane_id
end

---Close a Herdr pane by id.
---
---@param pane_id string
---@return boolean ok
local function herdr_kill_pane(pane_id)
    if not is_herdr_available() then return false end
    if type(pane_id) ~= 'string' or vim.trim(pane_id) == '' then return false end

    local ok = herdr_command({ 'close', vim.trim(pane_id) })
    return ok
end

return {
    split = herdr_split,
    pane_exists = herdr_pane_exists,
    pane_cmd = herdr_pane_cmd,
    kill_pane = herdr_kill_pane,
    is_herdr_available = is_herdr_available,
}

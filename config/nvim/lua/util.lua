local function merge_tables(...) return vim.tbl_deep_extend('force', ...) end

return {
    merge_tables = merge_tables,
}

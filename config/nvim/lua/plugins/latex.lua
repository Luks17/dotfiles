return {
    'lervag/vimtex',
    lazy = false, -- we don't want to lazy load VimTeX
    init = function()
        vim.g.vimtex_view_method = 'zathura'
        vim.g.vimtex_compiler_method = 'latexmk'

        vim.g.tex_flavor = 'latex'
        vim.g.vimtex_mappings_enabled = false
        vim.g.vimtex_view_use_temp_files = true

        local augroup = vim.api.nvim_create_augroup('vimtexConfig', {})
        vim.api.nvim_create_autocmd('FileType', {
            pattern = 'tex',
            group = augroup,
            callback = function()
                AddClues({
                    { mode = { 'n', 'x' }, keys = '<localleader>l', desc = '+LaTeX' },
                })

                MapSet({ 'n' }, '<localleader>ll', '<plug>(vimtex-compile)', 'Vimtex compile')
                MapSet({ 'n', 'x' }, '<localleader>lL', '<plug>(vimtex-compile-selected)', 'Vimtex compile selected')
                MapSet({ 'n' }, '<localleader>li', '<plug>(vimtex-info)', 'Vimtex info')
                MapSet({ 'n' }, '<localleader>lI', '<plug>(vimtex-info-full)', 'Vimtex info full')
                MapSet({ 'n' }, '<localleader>lt', '<plug>(vimtex-toc-open)', 'Vimtex TOC')
                MapSet({ 'n' }, '<localleader>lT', '<plug>(vimtex-toc-toggle)', 'Vimtex toggle TOC')
                MapSet({ 'n' }, '<localleader>lq', '<plug>(vimtex-log)', 'Vimtex log')
                MapSet({ 'n' }, '<localleader>lv', '<plug>(vimtex-view)', 'Vimtex view')
                MapSet({ 'n' }, '<localleader>lr', '<plug>(vimtex-reverse-search)', 'Vimtex reverse search')
                MapSet({ 'n' }, '<localleader>lk', '<plug>(vimtex-stop)', 'Vimtex stop')
                MapSet({ 'n' }, '<localleader>lK', '<plug>(vimtex-stop-all)', 'Vimtex stop all')
                MapSet({ 'n' }, '<localleader>le', '<plug>(vimtex-errors)', 'Vimtex errors')
                MapSet({ 'n' }, '<localleader>lo', '<plug>(vimtex-compile-output)', 'Vimtex compile output')
                MapSet({ 'n' }, '<localleader>lg', '<plug>(vimtex-status)', 'Vimtex status')
                MapSet({ 'n' }, '<localleader>lG', '<plug>(vimtex-status-full)', 'Vimtex full status')
                MapSet({ 'n' }, '<localleader>lc', '<plug>(vimtex-clean)', 'Vimtex clean')
                MapSet({ 'n' }, '<localleader>lC', '<plug>(vimtex-clean-full)', 'Vimtex full clean')
                MapSet({ 'n' }, '<localleader>lx', '<plug>(vimtex-reload)', 'Vimtex reload')
                MapSet({ 'n' }, '<localleader>lX', '<plug>(vimtex-reload-state)', 'Vimtex reload state')
                MapSet({ 'n' }, '<localleader>lm', '<plug>(vimtex-imaps-list)', 'Vimtex input maps list')
                MapSet({ 'n' }, '<localleader>ls', '<plug>(vimtex-toggle-main)', 'Vimtex toggle main')
                MapSet({ 'n' }, '<localleader>la', '<plug>(vimtex-context-menu)', 'Vimtex context menu')
            end,
        })
    end,
}

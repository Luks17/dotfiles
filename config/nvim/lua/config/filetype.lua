local merge_tables = require('config.util').merge_tables

local helm = {
    extension = {
        gotmpl = 'helm',
    },
    pattern = {
        ['helmfile.*%.ya?ml'] = 'helm',
        ['.*/templates/.*%.tpl'] = 'helm',
        ['.*/templates/.*%.tmpl'] = 'helm',
        ['.*/templates/.*%.ya?ml'] = 'helm',
    },
}

local dotenv = {
    filename = {
        ['.env'] = 'bash',
    },
    pattern = {
        ['%.env%.[%w_.-]+'] = 'bash',
    },
}

vim.filetype.add(merge_tables(helm, dotenv))

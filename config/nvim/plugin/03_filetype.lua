local util = require('util')

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

vim.filetype.add(util.merge_tables(helm, dotenv))

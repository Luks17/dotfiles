return {
    settings = {
        gopls = {
            codelenses = {
                generate = true,
                regenerate_cgo = true,
                test = false,
                tidy = true,
                upgrade_dependency = true,
                vendor = true,
            },
            hints = {
                assignVariableTypes = true,
                compositeLiteralFields = true,
                compositeLiteralTypes = true,
                constantValues = true,
                functionTypeParameters = true,
                parameterNames = true,
                rangeVariableTypes = true,
            },
            completeUnimported = true,
        },
    },
}

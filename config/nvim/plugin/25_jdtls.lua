Setup.now(function() vim.pack.add({ 'https://github.com/mfussenegger/nvim-jdtls' }) end)

Setup.on_ft('java', function()
    require('jdtls').setup_dap({ hotcodereplace = 'auto' })

    local bundles = {}
    bundles = vim.fn.glob('$MASON/share/java-debug-adapter/com.microsoft.java.debug.plugin-*jar', false, true)
    vim.list_extend(bundles, vim.fn.glob('$MASON/share/java-test/*.jar', false, true))

    local base_cmd = { vim.fn.exepath('jdtls') }
    local function jvm_arg(arg) table.insert(base_cmd, string.format('--jvm-arg=%s', arg)) end

    jvm_arg('-Djava.import.generatesMetadataFilesAtProjectRoot=false')
    jvm_arg('-Xmx4G')
    jvm_arg('-javaagent:' .. vim.fn.expand('$MASON/share/jdtls/lombok.jar'))

    local function attach_jdtls()
        local cmd = vim.deepcopy(base_cmd)

        local root_dir = vim.fs.root(0, { 'mvnw', 'gradlew', '.git' }) or vim.fn.getcwd()
        local project_name = vim.fs.basename(root_dir)
        local config_dir = vim.fn.stdpath('cache') .. '/jdtls/' .. project_name .. '/config'
        local workspace_dir = vim.fn.stdpath('cache') .. '/jdtls/' .. project_name .. '/workspace'

        vim.list_extend(cmd, {
            '-configuration',
            config_dir,
            '-data',
            workspace_dir,
        })

        require('jdtls').start_or_attach({
            cmd = cmd,
            root_dir = root_dir,
            init_options = {
                bundles = bundles,
            },
            settings = {
                java = {
                    inlayHints = {
                        parameterNames = {
                            enabled = 'all',
                        },
                    },
                },
            },
        })
    end

    Setup.new_autocmd('FileType', 'java', attach_jdtls, 'Attach JDTLS')
    attach_jdtls() -- run for the current buffer as well
end)

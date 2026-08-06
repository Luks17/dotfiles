local function tool(package, executable, opts)
    opts = opts or {}
    if opts.auto_enable == nil then opts.auto_enable = true end

    return {
        package = package,
        executable = executable or package,
        kind = opts.kind or 'other',
        auto_enable = opts.auto_enable,
    }
end

local function lsp(package, executable, opts)
    opts = opts or {}
    opts.kind = 'lsp'

    return tool(package, executable, opts)
end

local ensure_installed = {
    -- lua
    lsp('lua-language-server', 'lua_ls'),
    lsp('stylua'),

    -- c/c++
    lsp('clangd'),

    -- golang
    lsp('gopls'),
    lsp('golangci-lint-langserver', 'golangci_lint_ls'),

    -- rust
    lsp('rust-analyzer', 'rust_analyzer'),

    -- python
    lsp('pyright'),
    tool('isort'),
    tool('black'),

    -- sql
    tool('sqlfluff'),

    -- html/css
    lsp('html-lsp', 'html'),
    lsp('css-lsp', 'cssls'),
    lsp('emmet-ls', 'emmet_ls'),

    -- typescript/javascript
    lsp('vtsls'),
    tool('js-debug-adapter'),
    lsp('eslint-lsp', 'eslint'),
    tool('prettierd'),
    lsp('vue-language-server'),
    lsp('tailwindcss-language-server', 'tailwindcss'),

    -- php
    lsp('phpantom_lsp'),
    tool('pint'),

    -- java
    lsp('jdtls', nil, { auto_enable = false }),
    tool('java-debug-adapter'),
    tool('java-test'),

    -- json
    lsp('json-lsp', 'jsonls'),

    -- helm
    lsp('helm-ls', 'helm_ls'),

    -- grammar
    lsp('ltex-ls-plus', 'ltex_plus'),
}

return { ensure_installed = ensure_installed }

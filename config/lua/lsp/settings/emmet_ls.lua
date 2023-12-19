return {
    filetypes = {
        'html',
        'typescriptreact',
        'javascriptreact',
        'css',
        'sass',
        'scss',
        'less',
    },
    capabilities = {
        textDocument = {
            completion = { completionItem = { snippetSupport = true } },
        },
    },
}

return {
    {
        'MunifTanjim/prettier.nvim',
        opts = {
            bin = 'prettier',
            filetypes = {
                "css",
                "graphql",
                "html",
                "javascript",
                "javascriptreact",
                "json",
                "less",
                "markdown",
                "scss",
                "typescript",
                "typescriptreact",
                "yaml",
            },
            cli_options = {
                arrow_parens = "always",
                semi = false,
                single_quote = true,
                tab_width = 2,
                trailing_comma = "es5",
                use_tabs = false,
            }
        }
    }
}

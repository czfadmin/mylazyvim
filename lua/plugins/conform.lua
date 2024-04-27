return {
    "stevearc/conform.nvim",
    dependencies = {"mason.nvim"},
    lazy = true,
    cmd = "ConformInfo",
    opts = {
        formatters_by_ft = {
            ["javascript"] = {"prettier"},
            ["javascriptreact"] = {"prettier"},
            ["typescript"] = {"prettier"},
            ["typescriptreact"] = {"prettier"},
            ["vue"] = {"prettier"},
            ["css"] = {"prettier"},
            ["scss"] = {"prettier"},
            ["less"] = {"prettier"},
            ["html"] = {"prettier"},
            ["json"] = {"prettier"},
            ["jsonc"] = {"prettier"},
            ["yaml"] = {"prettier"},
            ["markdown"] = {"prettier"},
            ["markdown.mdx"] = {"prettier"},
            ["graphql"] = {"prettier"},
            ["handlebars"] = {"prettier"}
        },
        -- If this is set, Conform will run the formatter on save.
        -- It will pass the table to conform.format().
        -- This can also be a function that returns the table.
        format_on_save = {
            -- I recommend these options. See :help conform.format for details.
            lsp_fallback = true,
            timeout_ms = 500
        },
        -- If this is set, Conform will run the formatter asynchronously after save.
        -- It will pass the table to conform.format().
        -- This can also be a function that returns the table.
        format_after_save = {
            lsp_fallback = true
        },
        -- Set the log level. Use `:ConformInfo` to see the location of the log file.
        log_level = vim.log.levels.ERROR,
        -- Conform will notify you when a formatter errors
        notify_on_error = true
    }
}

local status, nls = pcall(require, "null-ls")

if not status then
    return
end

local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

local fmt = nls.builtins.formatting
local dgn = nls.builtins.diagnostics
local cda = nls.builtins.code_actions

nls.setup({
    sources = {
-- 
        -- -- Formatting
        -- fmt.prettierd,
        -- fmt.eslint_d,
        -- fmt.prettier.with({
            -- filetypes = { 
							-- "html", 
							-- "json", 
							-- "yaml", 
							-- "markdown", 
							-- "javascript", 
							-- "typescript", 
							-- "python", 
							-- "cpp", 
							-- "css", 
							-- "sh",
							-- "docker",
              -- "csharp"
						-- },
        -- }),
        -- fmt.stylua,
        -- fmt.rustfmt,
-- 
        -- Diagnostics
        dgn.eslint_d,
        dgn.shellcheck,
        dgn.pylint.with({
            method = nls.methods.DIAGNOSTICS_ON_SAVE,
            diagnostics_format = "[#{c}] #{m} (#{s})",
            filter = function(diagnostic)
                local ignoreList = {
                    [""]=true,
                    ["too-many-nested-blocks"]=true,
                    ["too-many-branches"]=true,
                    ["too-many-locals"]=true,
                    ["line-too-long"]=true,
                    ["invalid-name"]=true,
                    ["missing-module-docstring"]=true,
                    ["missing-class-docstring"]=true,
                    ["missing-function-docstring"]=true,
                    ["wrong-import-order"]=true,
                    ["multiple-imports"]=true,
                }
                if ignoreList[diagnostic.code] then
                    return false
                else
                    return true
                end
            end,
        }),

        -- Code Actions
        cda.eslint_d,
        cda.shellcheck,
    },
    on_attach = function(client, bufnr)
        if client.supports_method("textDocument/formatting") then
            vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
            vim.api.nvim_create_autocmd("BufWritePre", {
                group = augroup,
                buffer = bufnr,
                callback = function()
                    vim.lsp.buf.format({ bufnr = bufnr })
                end,
            })
        end
    end,
})

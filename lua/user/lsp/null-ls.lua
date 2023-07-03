local null_ls_status_ok, null_ls = pcall(require, "null-ls")
if not null_ls_status_ok then
  return
end

-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/formatting
local formatting = null_ls.builtins.formatting
-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/diagnostics
local diagnostics = null_ls.builtins.diagnostics

local lsp_formatting = function(bufnr)
    vim.lsp.buf.format({
        filter = function(client)
            -- apply whatever logic you want (in this example, we'll only use null-ls)
            return client.name == "null-ls"
        end,
        bufnr = bufnr,
    })
end

local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
-- https://github.com/prettier-solidity/prettier-plugin-solidity
null_ls.setup {
    debug = false,
    sources = {
        formatting.prettier.with {
            extra_filetypes = { "toml" },
            extra_args = { "--no-semi", "--single-quote", "--jsx-single-quote" },
        },
        formatting.black.with { extra_args = { "--fast" } },
        formatting.stylua,
        formatting.google_java_format,
        formatting.gofmt,
        formatting.goimports,
        formatting.clang_format,
        diagnostics.golangci_lint,
        diagnostics.misspell,
        formatting.black,
        formatting.isort,
        formatting.rustfmt,
        -- diagnostics.flake8,
        -- diagnostics.mypy,
        diagnostics.cspell.with({
            filetypes = { "markdown", "text", "gitcommit","go","python","rust"},
		    disabled_filetypes = { "nvimtree", "lua" },
            extra_args = {
				"--config",
				vim.fn.expand("~/.config/nvim/lua/user/lsp/cspell.json"),
				"--show-suggestions",
        "-v"
			},
            diagnostics_postprocess = function(diagnostic)
                diagnostic.severity = vim.diagnostic.severity['INFO']
            end,
        }),
    },
    -- you can reuse a shared lspconfig on_attach callback here
    on_attach = function(client, bufnr)
        if client.supports_method("textDocument/formatting") then
            vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
            vim.api.nvim_create_autocmd("BufWritePre", {
                group = augroup,
                buffer = bufnr,
                callback = function()
                    -- on 0.8, you should use vim.lsp.buf.format({ bufnr = bufnr }) instead
                    lsp_formatting(bufnr)
                    if vim.bo.filetype == 'rust' then
                        local ok, err_msg = pcall(function()
                            os.execute(string.format("rustfmt %s",vim.fn.expand("%:p")))
                            end)
                        if not ok then
                        end
                    end
                    -- vim.lsp.buf.formatting_sync()
                end,
            })
        end
    end,
}


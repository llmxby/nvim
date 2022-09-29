-- Shorten function name
local keymap = vim.keymap.set
-- Telescope
keymap("n", "<leader>ff", ":Telescope find_files<CR>", opts)
keymap("n", "<leader>ft", ":Telescope live_grep<CR>", opts)
keymap("n", "<leader>fe", ":Telescope oldfiles<CR>", opts)
keymap("n", "<leader>fb", ":Telescope buffers<CR>", opts)
keymap("n", "<leader>fc", ":Telescope commands<CR>", opts)


-- DAP
keymap("n", "<leader>db", "<cmd>lua require'dap'.toggle_breakpoint()<cr>", opts)
keymap("n", "<leader>dc", "<cmd>lua require'dap'.continue()<cr>", opts)
keymap("n", "<leader>di", "<cmd>lua require'dap'.step_into()<cr>", opts)
keymap("n", "<leader>do", "<cmd>lua require'dap'.step_over()<cr>", opts)
keymap("n", "<leader>dO", "<cmd>lua require'dap'.step_out()<cr>", opts)
keymap("n", "<leader>dr", "<cmd>lua require'dap'.repl.toggle()<cr>", opts)
keymap("n", "<leader>dl", "<cmd>lua require'dap'.run_last()<cr>", opts)
keymap("n", "<leader>du", "<cmd>lua require'dapui'.toggle()<cr>", opts)
keymap("n", "<leader>dt", "<cmd>lua require'dap'.terminate()<cr>", opts)


-- Comment
keymap("n", "<leader>/", "<cmd>lua require('Comment.api').toggle.linewise.current()<CR>", opts)
keymap("x", "<leader>/", '<ESC><CMD>lua require("Comment.api").toggle.linewise(vim.fn.visualmode())<CR>')

-- Hop
keymap("n", "<leader>jl", ":HopLineMW<CR>", opts)
keymap("n", "<leader>jc", ":HopChar1MW<CR>", opts)
keymap("n", "<leader>jw", ":HopWordMW<CR>", opts)
keymap("n", "<leader>jp", ":HopPatternMW<CR>", opts)
keymap("n", "<leader>ja", ":HopAnywhereMW<CR>", opts)

-- Trouble
keymap("n", "<leader>lq", "<cmd>TroubleToggle quickfix<cr>", opts)
keymap("n", "<leader>ld", "<cmd>TroubleToggle document_diagnostics<cr>", opts)
keymap("n", "<leader>lw", "<cmd>TroubleToggle workspace_diagnostics<cr>", opts)

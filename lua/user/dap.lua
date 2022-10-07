local dap_status_ok, dap = pcall(require, "dap")
if not dap_status_ok then
  return
end

local dap_ui_status_ok, dapui = pcall(require, "dapui")
if not dap_ui_status_ok then
  return
end


local dap_install_status_ok, dap_install = pcall(require, "dap-install")
if not dap_install_status_ok then
  return
end

local dap_go_status_ok, dap_go = pcall(require, "dap-go")
if not dap_go_status_ok then
  return
end

dap_go.setup()

dap_install.config("ccppr_vsc",{})
-- dap_install.config("go",{
-- 	adapters = {
-- 		type = "executable",
-- 		command = "node",
--         args = {os.getenv('HOME') .. '/dev/golang/vscode-go/dist/debugAdapter.js'};
-- 	},
-- 	configurations = {
-- 		{
-- 			type = "go",
-- 			name = "Debug",
-- 			request = "launch",
-- 			showLog = false,
-- 			program = "${file}",
-- 			dlvToolPath = vim.fn.exepath("dlv"), -- Adjust to where delve is installed
-- 		},
-- 	},
-- })
-- add other configs here

dapui.setup {
    layouts = {
    {
      elements = {
      -- Elements can be strings or table with id and size keys.
        { id = "repl", size = 0.25 },
        "console",
        "watches",
      },
      size = 40, -- 40 columns
      position = "left",
    },
    {
      elements = {
        "stacks",
        "breakpoints",
      },
      size = 0.25, -- 25% of total lines
      position = "bottom",
    },
    {
      elements = {
        "scopes",
      },
      size = 0.25, -- 25% of total lines
      position = "right",
    },
  },
}

vim.fn.sign_define("DapBreakpoint", { text = "", texthl = "DiagnosticSignError", linehl = "", numhl = "" })

dap.listeners.after.event_initialized["dapui_config"] = function()
  dapui.open()
end

dap.listeners.before.event_terminated["dapui_config"] = function()
  dapui.close()
end

dap.listeners.before.event_exited["dapui_config"] = function()
  dapui.close()
end

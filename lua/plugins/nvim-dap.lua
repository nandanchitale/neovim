return {
  "mfussenegger/nvim-dap",
  dependencies = {
    "rcarriga/nvim-dap-ui",
    {
      "theHamsta/nvim-dap-virtual-text",
      opts = {},
    },
    "nvim-lua/plenary.nvim", -- Ensure plenary is loaded
  },
  keys = {
    { "<leader>d", "", desc = "+debug", mode = { "n", "v" } },
    {
      "<leader>dB",
      function()
        require("dap").set_breakpoint(vim.fn.input("Breakpoint condition: "))
      end,
      desc = "Breakpoint Condition",
    },
    {
      "<leader>db",
      function()
        require("dap").toggle_breakpoint()
      end,
      desc = "Toggle Breakpoint",
    },
    {
      "<leader>dc",
      function()
        require("dap").continue()
      end,
      desc = "Continue",
    },
    {
      "<leader>da",
      function()
        require("dap").continue({ before = get_args })
      end,
      desc = "Run with Args",
    },
    {
      "<leader>dC",
      function()
        require("dap").run_to_cursor()
      end,
      desc = "Run to Cursor",
    },
    {
      "<leader>dg",
      function()
        require("dap").goto_()
      end,
      desc = "Go to Line (No Execute)",
    },
    {
      "<leader>di",
      function()
        require("dap").step_into()
      end,
      desc = "Step Into",
    },
    {
      "<leader>dj",
      function()
        require("dap").down()
      end,
      desc = "Down",
    },
    {
      "<leader>dk",
      function()
        require("dap").up()
      end,
      desc = "Up",
    },
    {
      "<leader>dl",
      function()
        require("dap").run_last()
      end,
      desc = "Run Last",
    },
    {
      "<leader>do",
      function()
        require("dap").step_out()
      end,
      desc = "Step Out",
    },
    {
      "<leader>dO",
      function()
        require("dap").step_over()
      end,
      desc = "Step Over",
    },
    {
      "<leader>dp",
      function()
        require("dap").pause()
      end,
      desc = "Pause",
    },
    {
      "<leader>dr",
      function()
        require("dap").repl.toggle()
      end,
      desc = "Toggle REPL",
    },
    {
      "<leader>ds",
      function()
        require("dap").session()
      end,
      desc = "Session",
    },
    {
      "<leader>dt",
      function()
        require("dap").terminate()
      end,
      desc = "Terminate",
    },
    {
      "<leader>dw",
      function()
        require("dap.ui.widgets").hover()
      end,
      desc = "Widgets",
    },
  },
  config = function()
    -- load mason-nvim-dap here, after all adapters have been setup
    if LazyVim.has("mason-nvim-dap.nvim") then
      require("mason-nvim-dap").setup(LazyVim.opts("mason-nvim-dap.nvim"))
    end

    vim.api.nvim_set_hl(0, "DapStoppedLine", { default = true, link = "Visual" })

    for name, sign in pairs(LazyVim.config.icons.dap) do
      sign = type(sign) == "table" and sign or { sign }
      vim.fn.sign_define(
        "Dap" .. name,
        { text = sign[1], texthl = sign[2] or "DiagnosticInfo", linehl = sign[3], numhl = sign[3] }
      )
    end

    -- setup dap config by VsCode launch.json file
    local vscode = require("dap.ext.vscode")
    print("Launch.json file Loaded")

    -- Function to strip comments from JSON
    local function strip_comments(str)
      local lines = vim.split(str, "\n")
      local clean_lines = {}
      for _, line in ipairs(lines) do
        local clean_line = line:gsub("//.*", ""):gsub("%s*$", "")
        if clean_line ~= "" then
          table.insert(clean_lines, clean_line)
        end
      end
      return table.concat(clean_lines, "\n")
    end

    -- Custom JSON decoder to handle comments
    vscode.json_decode = function(str)
      local clean_json_str = strip_comments(str)
      print("Launch.json Cleaned")
      return vim.fn.json_decode(clean_json_str)
    end

    -- Load the launch.json file
    local launch_json_path = vim.fn.getcwd() .. "/.vscode/launch.json"
    if vim.fn.filereadable(launch_json_path) == 1 then
      local launch_json = vim.fn.readfile(launch_json_path)
      local launch_json_str = table.concat(launch_json, "\n")
      local parsed_launch_json = vscode.json_decode(launch_json_str)
      vscode.load_launchjs(parsed_launch_json)
    else
      vim.notify("launch.json not found", vim.log.levels.ERROR)
    end
  end,
}

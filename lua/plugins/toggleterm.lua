return {
  {
    "akinsho/toggleterm.nvim",
    version = "*",
    config = function()
      require("toggleterm").setup({
        -- You can add configuration options here
        direction = "horizontal", -- Default direction for new terminals
        open_mapping = "<C-\\>", -- Key mapping to open/close terminal
        hide_numbers = true, -- Hide the number column in terminals
        start_in_insert = true, -- Start terminal in insert mode
        insert_mappings = true, -- Allow key mappings in insert mode
        persist_size = true, -- Persist terminal size
        persist_mode = true, -- Persist terminal mode (insert/normal)
        close_on_exit = false, -- Keep terminal buffers open on exit
        shell = "pwsh.exe", -- Use the default shell
        float_opts = {
          border = "single", -- Terminal border style
          highlights = {
            border = "Normal",
            background = "Normal",
          },
        },
      })

      -- Keybindings for ToggleTerm
      vim.api.nvim_set_keymap(
        "n",
        "<leader>th",
        "<cmd>ToggleTerm direction=horizontal<CR>",
        { noremap = true, silent = true }
      )
      vim.api.nvim_set_keymap(
        "n",
        "<leader>tv",
        "<cmd>ToggleTerm direction=vertical<CR>",
        { noremap = true, silent = true }
      )
      vim.api.nvim_set_keymap("n", "<leader>tt", "<cmd>ToggleTerm direction=tab<CR>", { noremap = true, silent = true })

      -- Keybindings for multiple terminals
      vim.api.nvim_set_keymap("n", "<leader>tn", "<cmd>ToggleTerm<CR>", { noremap = true, silent = true }) -- New terminal
      vim.api.nvim_set_keymap("n", "<leader>t1", "<cmd>1ToggleTerm<CR>", { noremap = true, silent = true }) -- Terminal 1
      vim.api.nvim_set_keymap("n", "<leader>t2", "<cmd>2ToggleTerm<CR>", { noremap = true, silent = true }) -- Terminal 2
      vim.api.nvim_set_keymap("n", "<leader>t3", "<cmd>3ToggleTerm<CR>", { noremap = true, silent = true }) -- Terminal 3
    end,
  },
}

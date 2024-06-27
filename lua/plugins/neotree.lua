return {
  "nvim-neo-tree/neo-tree.nvim",
  branch = "v2.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "kyazdani42/nvim-web-devicons", -- not strictly required, but recommended
    "MunifTanjim/nui.nvim",
  },
  config = function()
    require("neo-tree").setup({
      close_if_last_window = true, -- Close Neo-tree if it is the last window left in the tab
      filesystem = {
        follow_current_file = true, -- Automatically expand the tree when a file is opened
        filtered_items = {
          visible = true, -- Make hidden files visible
          hide_dotfiles = false, -- Show dotfiles
          hide_gitignored = false, -- Show git ignored files
        },
        hijack_netrw_behavior = "open_default", -- netrw disabled, opening a directory opens neo-tree
      },
    })
  end,
}

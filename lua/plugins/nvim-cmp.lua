-- Add lazydev source to cmp
return {
  "hrsh7th/nvim-cmp",
  opts = function(_, opts)
    table.insert(opts.sources, { name = "lazydev", group_index = 0 })
  end,
  -- codeium cmp source
  "nvim-cmp",
  dependencies = {
    -- codeium
    {
      "Exafunction/codeium.nvim",
      cmd = "Codeium",
      build = ":Codeium Auth",
      opts = {},
    },
  },
  ---@param opts cmp.ConfigSchema
  opts = function(_, opts)
    table.insert(opts.sources, 1, {
      name = "codeium",
      group_index = 1,
      priority = 100,
    })
  end,
}

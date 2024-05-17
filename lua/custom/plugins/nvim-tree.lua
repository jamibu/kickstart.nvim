-- return {
--     "nvim-neo-tree/neo-tree.nvim",
--     branch = "v3.x",
--     dependencies = {
--       "nvim-lua/plenary.nvim",
--       "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
--       "MunifTanjim/nui.nvim",
--     }
-- }

local Plugin = { 'nvim-tree/nvim-tree.lua' }

vim.keymap.set('n', '<Leader>tt', '<Cmd>NvimTreeToggle<CR>')

Plugin.name = 'nvim-tree'
Plugin.cmd = { 'NvimTreeToggle' }
Plugin.dependencies = {
  'nvim-tree/nvim-web-devicons',
}

-- See :help nvim-tree-setup
Plugin.opts = {
  sort_by = 'case_sensitive',
  renderer = {
    group_empty = true,
  },
  filters = {
    dotfiles = true,
  },
}

return Plugin

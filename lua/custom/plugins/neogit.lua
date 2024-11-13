local Plugin = { 'NeogitOrg/neogit' }
Plugin.dependencies = {
  'nvim-lua/plenary.nvim', -- required
  'nvim-telescope/telescope.nvim', -- optional
  'sindrets/diffview.nvim', -- optional
}

function Plugin.config()
  local neogit = require 'neogit'
  neogit:setup()

  vim.keymap.set('n', '<leader>gg', function()
    neogit.open()
  end)
end

return Plugin

return {
  'folke/zen-mode.nvim',
  opts = {
    window = {
      backdrop = 0.95, -- shade the backdrop of the Zen window. Set to 1 to keep the same as Normal
      -- height and width can be:
      -- * an absolute number of cells when > 1
      -- * a percentage of the width / height of the editor when <= 1
      -- * a function that returns the width or the height
    },
    plugins = {
      options = { enabled = true },
      gitsigns = { enabled = false },
    },
    options = {
      colorcolumn = '0',
    },
  },

  config = function()
    vim.keymap.set('n', '<leader>zm', function()
      require('zen-mode').toggle {
        window = {
          width = 100,
        },
      }
    end, { desc = '[Z]en[M]ode' })
  end,
}

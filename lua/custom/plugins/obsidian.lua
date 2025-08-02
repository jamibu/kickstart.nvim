local Plugin = {
  'obsidian-nvim/obsidian.nvim',
  version = '*', -- recommended, use latest release instead of latest commit
  lazy = true,
  ft = 'markdown',
  -- Replace the above line with this if you only want to load obsidian.nvim for markdown files in your vault:
  -- event = {
  --   -- If you want to use the home shortcut '~' here you need to call 'vim.fn.expand'.
  --   -- E.g. "BufReadPre " .. vim.fn.expand "~" .. "/my-vault/*.md"
  --   -- refer to `:h file-pattern` for more examples
  --   "BufReadPre path/to/my-vault/*.md",
  --   "BufNewFile path/to/my-vault/*.md",
  -- },
  dependencies = {
    -- Required.
    'nvim-lua/plenary.nvim',
  },

  -- Optional, completion of wiki links, local markdown links, and tags using nvim-cmp.
  completion = {
    -- Enables completion using blink.cmp
    blink = true,
    -- Trigger completion at 2 chars.
    min_chars = 2,
  },

  opts = {
    legacy_commands = false,
    workspaces = {
      {
        name = 'notes',
        path = '~/notes/Notes',
      },
    },
    templates = {
      subdir = 'meta/templates',
      date_format = '%Y-%m-%d %H:%M:%S',
      substitutions = {
        time = function()
          return os.time(os.date '!*t')
        end,
      },
    },

    new_notes_location = 'notes_subdir',
    notes_subdir = '000-Inbox',
  },
}

function Plugin.config(_, opts)
  require('obsidian').setup(opts)
  vim.keymap.set('n', '<leader>no', '<cmd>Obsidian open<cr>', { desc = 'Open Obsidian App on current note' })
  vim.keymap.set('n', '<leader>nn', '<cmd>Obsidian new<cr>', { desc = 'Open new Obsidian note' })
  vim.keymap.set('n', '<leader>nt', '<cmd>Obsidian new_from_template<cr>', { desc = 'Open new Obsidian note' })
  vim.keymap.set('n', '<leader>ni', '<cmd>Obsidian template<cr>', { desc = 'Insert Obsidian template' })
  vim.keymap.set('n', '<leader>nf', '<cmd>Obsidian quick_switch<cr>', { desc = 'Open Obsidian quick switch' })
  vim.keymap.set('n', '<leader>n#', '<cmd>Obsidian tag<cr>', { desc = 'Obsidian tags in Telescope' })
  vim.keymap.set('n', '<leader>ng', '<cmd>Obsidian search<cr>', { desc = 'Grep through notes' })
  vim.keymap.set('n', '<leader>nb', '<cmd>Obsidian backlink<cr>', { desc = 'Obsidian backlinks in Telescope' })
  vim.keymap.set('n', '<leader>nw', '<cmd>Obsidian workspace<cr>', { desc = 'Obsidian workplaces' })
  vim.keymap.set('n', '<leader>nc', '<cmd>Obsidian check<cr>', { desc = 'Check that notes are in good state' })
end

return Plugin

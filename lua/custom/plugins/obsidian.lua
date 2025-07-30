return {
  'epwalsh/obsidian.nvim',
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

    -- see below for full list of optional dependencies 👇
  },

  -- Optional, completion of wiki links, local markdown links, and tags using nvim-cmp.
  completion = {
    -- Enables completion using blink.cmp
    blink = true,
    -- Trigger completion at 2 chars.
    min_chars = 2,
    -- Set to false to disable new note creation in the picker
    create_new = true,
  },

  opts = {
    workspaces = {
      {
        name = 'notes',
        path = '~/notes/Notes',
      },
      {
        name = 'work',
        path = '~/notes/Notes',
      },
    },
    templates = {
      subdir = 'Meta/Templates',
    },

    new_notes_location = 'notes_subdir',
    notes_subdir = '000-Inbox',

    ui = {
      checkboxes = {
        -- NOTE: the 'char' value has to be a single character, and the highlight groups are defined below.
        [' '] = { char = '󰄱', hl_group = 'ObsidianTodo' },
        ['x'] = { char = '', hl_group = 'ObsidianDone' },
        ['>'] = { char = '', hl_group = 'ObsidianRightArrow' },
        ['~'] = { char = '󰰱', hl_group = 'ObsidianTilde' },
        ['/'] = { char = '󱎖', hl_group = 'ObsidianInProgress' },
      },
    },

    -- see below for full list of options 👇
  },
}

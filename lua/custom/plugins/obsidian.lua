local Plugin = {
  'epwalsh/obsidian.nvim',
  dependencies = { 'nvim-lua/plenary.nvim' },
  version = '*',
  lazy = false,
  ft = 'markdown',
  opts = {
    workspaces = {
      {
        name = 'work',
        path = '~/notes/Work',
      },
      {
        name = 'personal',
        path = '~/notes/Personal',
      },
    },

    new_notes_location = 'notes_subdir',
    notes_subdir = 'pages',

    daily_notes = {
      folder = 'journals',
      template = 'Daily.md',
    },

    templates = {
      subdir = 'templates',
    },

    disable_frontmatter = true,

    note_id_func = function(title)
      return title
    end,

    callbacks = {
      enter_note = function(client, note)
        vim.opt_local.tabstop = 4
        vim.opt_local.shiftwidth = 4
        vim.opt_local.expandtab = false
      end,
    },

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
  },
}

function Plugin.config(_, opts)
  local obsidian = require('obsidian').setup(opts)

  vim.keymap.set('n', '<leader>nd', '<cmd>ObsidianToday<cr>', { desc = 'Open Obsidian Daily Note' })
  vim.keymap.set('n', '<leader>ny', '<cmd>ObsidianYesterday<cr>', { desc = "Open yesterday's Obsidian Daily Note" })
  vim.keymap.set('n', '<leader>nm', '<cmd>ObsidianTomorrow<cr>', { desc = "Open tomorrow's Obsidian Daily Note" })
  vim.keymap.set('n', '<leader>no', '<cmd>ObsidianOpen<cr>', { desc = 'Open Obsidian App on current note' })
  vim.keymap.set('n', '<leader>nn', '<cmd>ObsidianNew<cr>', { desc = 'Open new Obsidian note' })
  vim.keymap.set('n', '<leader>nt', '<cmd>ObsidianTemplate<cr>', { desc = 'Insert Obsidian template' })
  vim.keymap.set('n', '<leader>nf', '<cmd>ObsidianQuickSwitch<cr>', { desc = 'Open Obsidian quick switch' })
  vim.keymap.set('n', '<leader>n#', '<cmd>ObsidianTag<cr>', { desc = 'Obsidian tags in Telescope' })
  vim.keymap.set('n', '<leader>ng', '<cmd>ObsidianSearch<cr>', { desc = 'Grep through notes' })
  vim.keymap.set('n', '<leader>nb', '<cmd>ObsidianBacklink<cr>', { desc = 'Obsidian backlinks in Telescope' })
  vim.keymap.set('n', '<leader>nw', '<cmd>ObsidianWorkspace<cr>', { desc = 'Obsidian workplaces' })

  vim.keymap.set('n', '<leader>np', function()
    local dirname = vim.loop.cwd()
    local foldername = vim.fs.basename(dirname)

    local note = obsidian:create_note { title = foldername, no_write = true }

    local existing_note = note:exists()
    -- obsidian:open_note(note)
    vim.cmd('e ' .. tostring(note.path))

    if not existing_note then
      vim.cmd 'ObsidianTemplate Project.md'
      -- Templates in obsidian.nvim currently paste below the current line
      -- This means that there is a empty line at the top of a new file.
      vim.cmd 'norm dd'
    end
  end, { desc = 'Create or go to [n]ote for current [p]roject.' })
end

return Plugin

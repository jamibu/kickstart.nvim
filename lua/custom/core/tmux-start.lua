vim.keymap.set('n', '<leader>tp', function()
  if vim.env.TMUX ~= nil then
    vim.fn.system 'tmux neww tmux-start'
  else
    vim.notify('Not in a tmux session', vim.log.levels.WARN)
  end
end, { desc = 'Pick and switch tmux project session' })

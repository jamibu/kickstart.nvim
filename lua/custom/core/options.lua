vim.opt.wrap = false

-- Nice undos (goes great with undotree)
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv 'HOME' .. '/.vim/undodir'

-- Tabs and indents
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.smartindent = true

vim.opt.colorcolumn = '80'
vim.o.relativenumber = true
vim.opt.nu = true

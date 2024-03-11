local ls = require 'luasnip'

local t = ls.text_node
local f = ls.function_node
local i = ls.insert_node
local c = ls.choice_node
local fmt = require('luasnip.extras.fmt').fmt

WEEKDAYS = {
  ['sunday'] = 0,
  ['monday'] = 1,
  ['tuesday'] = 2,
  ['wednesday'] = 3,
  ['thursday'] = 4,
  ['friday'] = 5,
  ['saturday'] = 6,
}

local function date_plus(days)
  local time = os.time() + days * 24 * 60 * 60
  return os.date('%Y-%m-%d', time)
end

local function parse_natural_time(time_str)
  local parts = vim.split(time_str, ' ', { plain = true })

  if #parts < 2 then
    return time_str
  end

  local number = parts[1]
  local unit = parts[2]

  local date
  if unit == 'day' or unit == 'days' then
    date = date_plus(number)
  elseif unit == 'week' or unit == 'weeks' then
    date = date_plus(number * 7)
  else
    return time_str
  end

  return date
end

local function natural_date(prompt)
  local input = vim.fn.input(prompt .. ': ')
  input = string.lower(input)

  local date
  if input == 'today' then
    date = date_plus(0)
  elseif input == 'tomorrow' then
    date = date_plus(1)
  elseif input == 'next week' then
    date = date_plus(7)
  elseif input == 'yesterday' then
    date = date_plus(-1)
  elseif WEEKDAYS[input] ~= nil then
    local add = WEEKDAYS[input] - os.date '%w'
    if add <= 0 then
      add = add + 7
    end
    date = date_plus(add)
  else
    date = parse_natural_time(input)
  end

  return date
end

ls.add_snippets('markdown', {
  ls.s('-checkbox', fmt('- [ ] {}', { i(1, 'name') })),
  ls.s('-task', { t '- [ ] ', i(1, 'task'), t ' #task', i(2) }),
  ls.s('-fulltask', {
    t '- [ ] ',
    i(1, 'task'),
    t ' #task',
    t ' ',
    t '📅 ',
    c(2, {
      f(function()
        return os.date '%Y-%m-%d'
      end),
      f(function()
        return natural_date 'due'
      end),
    }),
    t ' ',
    t '⏳ ',
    c(3, {
      f(function()
        return os.date '%Y-%m-%d'
      end),
      f(function()
        return natural_date 'due'
      end),
    }),
    t ' ',
    c(4, { t '⏬', t '🔽', t '🔼', t '⏫', t '🔺' }),
  }),
  ls.s('s::', {
    t '⏳ ',
    c(1, {
      f(function()
        return os.date '%Y-%m-%d'
      end),
      f(function()
        return natural_date 'due'
      end),
    }),
    i(),
  }),
  ls.s('d::', {
    t '📅 ',
    c(1, {
      f(function()
        return os.date '%Y-%m-%d'
      end),
      f(function()
        return natural_date 'due'
      end),
    }),
    i(),
  }),
  ls.s('p::', { c(1, { t '⏬', t '🔽', t '🔼', t '⏫', t '🔺' }) }),
})

vim.keymap.set({ 'i' }, '<c-k>', function()
  ls.expand()
end, { silent = true })
vim.keymap.set({ 'i', 's' }, '<c-l>', function()
  ls.jump(1)
end, { silent = true })
vim.keymap.set({ 'i', 's' }, '<C-h>', function()
  ls.jump(-1)
end, { silent = true })

vim.keymap.set('i', '<c-e>', function()
  if ls.choice_active() then
    ls.change_choice(1)
  end
end)

vim.keymap.set('i', '<c-u>', require 'luasnip.extras.select_choice')

-- shorcut to source my luasnips file again, which will reload my snippets
vim.keymap.set('n', '<leader>ll', '<cmd>source ~/.config/nvim/after/plugin/luasnip.lua<CR>')

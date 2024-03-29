local M = {}

local cmd = vim.cmd
local o = vim.o
local wo = vim.wo
-- local bo = vim.bo
-- local indent = 4
local opt = vim.opt

function M.setup()
  cmd "syntax enable"
  cmd "filetype plugin indent on"

  -- bo.shiftwidth = indent
  -- bo.tabstop = indent
  -- bo.softtabstop = indent
  -- bo.expandtab = true

  o.termguicolors = true
  o.hidden = true
  o.ignorecase = true
  o.breakindent = true
  o.scrolloff = 8
  o.splitbelow = true
  o.splitright = true
  o.clipboard = "unnamed,unnamedplus"
  o.timeoutlen = 500
  o.updatetime = 300
  o.inccommand = "split"
  o.cmdheight = 1
  o.sidescrolloff = 8
  o.sessionoptions = "blank,buffers,curdir,folds,help,options,tabpages,winsize,resize,winpos,terminal"
  o.history = 100
  o.lazyredraw = true
  o.synmaxcol = 240
  o.textwidth = 80
  o.colorcolumn = "81"

  wo.number = true
  wo.relativenumber = true
  wo.scrolloff = 8
  wo.cursorline = true
  opt.pumblend = 17

  opt.formatoptions = opt.formatoptions
    - "a" -- Auto formatting is BAD.
    - "t" -- Don't auto format my code. I got linters for that.
    + "c" -- In general, I like it when comments respect textwidth
    + "q" -- Allow formatting comments w/ gq
    - "o" -- O and o, don't continue comments
    - "r" -- Don't insert comment after <Enter>
    + "n" -- Indent past the formatlistpat, not underneath it.
    + "j" -- Auto-remove comments if possible.
    - "2" -- I'm not in gradeschool anymore
end

return M

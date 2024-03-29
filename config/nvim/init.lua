-- Map leader to space
vim.g.mapleader = " "
vim.g.maplocalleader = ","

local fn = vim.fn
local execute = vim.api.nvim_command

local function packer_init()
  local install_path = fn.stdpath "data" .. "/site/pack/packer/opt/packer.nvim"
  if fn.empty(fn.glob(install_path)) > 0 then
    execute("!git clone https://github.com/wbthomason/packer.nvim " .. install_path)
  end
  vim.cmd [[packadd packer.nvim]]
  vim.cmd "autocmd BufWritePost plugins.lua PackerCompile"
end

local function sys_init()
  -- Performance
  require "impatient"
end

----- Start loading ----------

packer_init()

require("plugins").setup()

sys_init()

require("defaults").setup()

require("keymappings").setup()

require("settings").setup()

require("config.lsp").setup()

-- require("config.dap").setup()

require("colorizer").setup()

----- End loading ----------

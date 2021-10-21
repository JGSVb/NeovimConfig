vim.o.mouse = "a"

-- quebra de linha
vim.o.wrap = false

vim.o.relativenumber = true
vim.o.number = true

-- tirar "-- %mode --"
vim.o.showmode = false

-- Mudar para o diretório do ficheiro que foi aberto
vim.o.autochdir = true

-- Tabs e indentação
vim.o.tabstop	 = 4
vim.o.shiftwidth = 4
vim.o.smartindent = true
vim.o.expandtab = false

vim.o.list = true
vim.opt.listchars = { tab = "│ " }
vim.opt.fillchars = { vert = " " }

vim.o.scrolloff = 10

-- Netrw
vim.g.netrw_banner	= 0
vim.g.netrw_winsize = 15


require("plugins")
require("nightfox").load("nightfox")

require("plugin_config")

local colors = require("nightfox.colors").load()
local hi_cmd = string.format("hi VertSplit guibg=%s", colors.bg_alt)
vim.cmd("autocmd WinNew * "..hi_cmd)

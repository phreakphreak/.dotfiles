local map = require("core.utils").map

local data = require("custom.mappings")

vim.g.mapleader = ","
vim.o.list = true
vim.o.mouse = "a"
vim.o.errorbells = false
vim.o.shiftwidth = 2
vim.o.smartindent = true
vim.o.smarttab = true
vim.o.tabstop = 2
vim.o.relativenumber = true
vim.o.number = true
vim.o.numberwidth = 1
vim.o.incsearch = true
vim.o.ignorecase = true
vim.o.showmatch = true
vim.o.cursorline = true
vim.o.termguicolors = true
vim.o.clipboard = "unnamedplus"
vim.o.ai = true
vim.o.background = "dark"
vim.o.colorcolumn = "120"
vim.o.encoding = "utf8"
vim.o.linespace = 3
vim.o.swapfile = false
vim.o.backup = false
vim.o.expandtab = true
vim.o.wrap = false
vim.o.undofile = true
vim.o.splitbelow = true
vim.o.splitright = true

vim.cmd("highlight IndentBlanklineIndent1 guifg=#E06C75 gui=nocombine")
vim.cmd("highlight IndentBlanklineIndent2 guifg=#E5C07B gui=nocombine")
vim.cmd("highlight IndentBlanklineIndent3 guifg=#98C379 gui=nocombine")
vim.cmd("highlight IndentBlanklineIndent4 guifg=#56B6C2 gui=nocombine")
vim.cmd("highlight IndentBlanklineIndent5 guifg=#61AFEF gui=nocombine")
vim.cmd("highlight IndentBlanklineIndent6 guifg=#C678DD gui=nocombine")

vim.cmd("highlight ColoColumn ctermbg=0 guibg=lightgrey")

for i = 1, #data do
	map(data[i][1], data[i][2], data[i][3])
end



local mappings = {
  {"v","<A-j>",":m '>+1<CR>gv=gv"},
  {"v","<A-k>",":m '<-2<CR>gv=gv"},

  {"i","<C-s>","<Esc>:w<CR>"},
  {"i","<A-j>","<Esc>:m .+1<CR>==gi"},
  {"i","<A-k>","<Esc>:m .-2<CR>==gi"},

  {"n", "<leader>cc", ":Telescope <CR>"},
  {"n", "<leader>q", ":q<CR>"},
  {"n", "<leader>Q", ":q!<CR>"},
  {"n", "<leader>a", "gg_<S-v>G"},
  {"n","<A-j>", ":m .+1<CR>=="},
  {"n","<A-k>", ":m .-2<CR>=="},
  {"n","sv",":vsp<Return><C-w>w"},
  {"n","ss",":sp<Return><C-w>w"},
  {"n","<right>",":vertical resize +5<CR>"},
  {"n","<left>",":vertical resize -5<CR>"},
  {"n","<up>",":resize -5<CR>"},
  {"n","<down>",":resize +5<CR>"},
  {"n","<leader>zz",":let &scrolloff=999-&scrolloff<CR>"},
  {"n","<leader>zx",":let &scrolloff=0<CR>"},
  {"n","<C-[>","10<C-e>"},
  {"n","<C-]>","10<C-y>"},
}



return mappings

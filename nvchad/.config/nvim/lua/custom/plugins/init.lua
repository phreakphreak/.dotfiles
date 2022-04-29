-- /lua/custom/plugins/init.lua
return {
  { 'easymotion/vim-easymotion' },
  { 'andweeb/presence.nvim' },
  { 'editorconfig/editorconfig-vim' },
  { 'junegunn/fzf' },
  { 'williamboman/nvim-lsp-installer' },
  { "DougBeney/pickachu" },
  {
    "jose-elias-alvarez/null-ls.nvim",
    after = "nvim-lspconfig",
    config = function()
      require("custom.plugins.null-ls")
    end,
  },
  { 'wakatime/vim-wakatime' },
  { 'github/copilot.vim' },
  {
    "hrsh7th/nvim-cmp",
    requires = {
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-nvim-lua",
      "hrsh7th/cmp-nvim-lsp",
      "saadparwaiz1/cmp_luasnip",
      "onsails/lspkind-nvim",
      "L3MON4D3/LuaSnip",
      "windwp/nvim-autopairs",
    },
  },
  { 'p00f/nvim-ts-rainbow' }
}

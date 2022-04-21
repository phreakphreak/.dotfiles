-- /lua/custom/plugins/init.lua
return {
  {'easymotion/vim-easymotion'},
  {'andweeb/presence.nvim'},
  {'editorconfig/editorconfig-vim'},
  {'junegunn/fzf'},
  {'williamboman/nvim-lsp-installer'},
  {
      "jose-elias-alvarez/null-ls.nvim",
      after = "nvim-lspconfig",
      config = function()
         require("custom.plugins.null-ls")
      end,
   },


}

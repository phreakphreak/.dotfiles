-- custom/plugins/init.lua

return {
   ["easymotion/vim-easymotion"] = {},
   ["andweeb/presence.nvim"] = {},
   ["editorconfig/editorconfig-vim"] = {},
   ["junegunn/fzf"] = {},
   ["DougBeney/pickachu"] = {},
   ["wakatime/vim-wakatime"] = {},
   ["github/copilot.vim"] = {},
   ["p00f/nvim-ts-rainbow"] = {},
   ["jose-elias-alvarez/null-ls.nvim"] = {
      after = "nvim-lspconfig",
      config = function()
         require("custom.config.null-ls").setup()
      end,
   },
}

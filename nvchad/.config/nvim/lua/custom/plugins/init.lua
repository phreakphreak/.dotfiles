-- custom/plugins/init.lua

return {
   ["lukas-reineke/indent-blankline.nvim"] = {
      config = function()
         require("indent_blankline").setup {
            -- for example, context is off by default, use this to turn it on
            -- show_current_context = true,
            show_current_context = true,
            show_current_context_start = true,
         }
      end,
   },
   ["easymotion/vim-easymotion"] = {},
   ["andweeb/presence.nvim"] = {},
   ["editorconfig/editorconfig-vim"] = {},
   ["junegunn/fzf"] = {},
   ["williamboman/nvim-lsp-installer"] = {},
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

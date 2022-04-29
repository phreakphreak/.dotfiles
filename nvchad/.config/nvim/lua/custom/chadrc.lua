local M = {}

local options = require("custom.options")
local user_plugins = require("custom.plugins")



M.options = options

M.mappings = {
  plugins = {
    lspconfig = {
      set_loclist = "<leader>wq",
    }
  }
}


M.ui = {
  theme = "tokyonight",
  transparency = 0.9
}


M.plugins = {
  install = user_plugins,

  default_plugin_config_replace = {
    nvim_treesitter = require("custom.plugins.nvimtreesitter")
  },

  options = {
    lspconfig = {
      setup_lspconf = "custom.plugins.lspconfig",
    }
  }

}


return M

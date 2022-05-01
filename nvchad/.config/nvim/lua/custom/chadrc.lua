-- Just an example, supposed to be placed in /lua/custom/

local M = {}
-- chadrc.lua

 local user_plugins = require "custom.plugins"


-- make sure you maintain the structure of `core/default_config.lua` here,
-- example of changing theme:

M.ui = {
  theme = "tokyonight",
  transparency = 0.9
}

M.plugins = {
  user = user_plugins,
 override = {
      ["nvim-treesitter/nvim-treesitter"] = require("custom.config.treesitter"),
     },

  options = {
    lspconfig = {
      setup_lspconf = "custom.config.lspconfig",
    }
  }

}


return M

local M = {}

local user_plugins = require("custom.plugins")

M.ui = {
	theme = "tokyonight",
	transparency = 0.9,
}

M.plugins = {
	user = user_plugins,
	override = {
		["nvim-treesitter/nvim-treesitter"] = require("custom.config.treesitter"),
	},
}

return M

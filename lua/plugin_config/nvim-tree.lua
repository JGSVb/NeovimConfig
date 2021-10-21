local api = vim.api

local tree = require("nvim-tree")
local view = require("nvim-tree.view")

tree.setup({
	auto_close = true,
	view = {
		mappings = {
			custom_only = false,
			list = {
				{ mode = 'n', key = "<Right>", cb = view.nvim_tree_callback("cd") },
				{ mode = 'n', key = "<Left>",  cb = view.nvim_tree_callback("dir_up") },
			}
		}
	}
})

local _open = tree.open

tree.open = function()
	_open()
	api.nvim_command("hi! NvimTreeRootFolder gui=italic")
end

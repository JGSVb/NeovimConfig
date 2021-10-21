local modules = {
	"lualine",
	"nvim-tree",
	"nvim-treesitter",
}

for i=1,#modules do
	local modname = modules[i]
	local mod = "plugin_config."..modname
	require(mod)
end

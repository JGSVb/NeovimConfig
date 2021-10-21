local function filetype()
	local filetype = vim.o.filetype
	local icon = filetype_icons[filetype]

	if icon == nil then
		return filetype
	else
		return icon
	end
end

local function modified()
	if vim.o.modified then
		return "[+]"
	else
		return ""
	end
end

local function readonly()
	if vim.o.readonly or vim.o.write == false or vim.o.modifiable == false then
		return ""
	else
		return ""
	end
end

local function filename()
	local result = vim.fn.expand("%")..modified()
	local ronly = readonly()

	if #ronly > 0 then
		result = result.." "..ronly
	end
	return result
end


require("lualine").setup({
	options = {
		theme = "nightfox",
		component_separators = "",
		section_separators =   {"", ""},
	},

	sections = {
		lualine_a = {"mode"},
		lualine_b = {filename},
		lualine_c = {},

		lualine_x = {"location"},
		lualine_y = {},
		lualine_z = {},
	},
})

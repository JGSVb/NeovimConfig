local api = vim.api
local PLUGID = "StartLua"

local M = {}

M.View = {

	bufopts = {
		buftype    = "nofile",
		filetype   = "Start",
		bufhidden  = "wipe",
		buflisted  = false,
		swapfile   = false,
		modifiable = false,
		readonly   = true
	},
	
	winopts = {
		wrap		   = false,
		linebreak	   = false,
		fillchars	   = "",
		conceallevel   = 0,
		concealcursor  = "",
		cursorcolumn   = false,
		cursorline	   = false,
		spell		   = false,
		relativenumber = false,
		number		   = false,
		list		   = false,
		foldenable	   = false
	},

	bufhandle = nil,
	winhandle = nil,
	nshandle = nil
}

M.Layout = {
	groups = {
		Title = {
			gui = "bold",
			guifg = "red"
		},

		Desc = {
			gui = "NONE",
			guifg = "gray"
		},

		Normal = {
			link = "Normal"
		}
	},

	components = {
		name = {
		  text = "Open",
		  group = "Title"
		},

		desc = {
			text = "Opens a file to edit",
			group = "Desc"
		}
	},

	rows = {
		{ },
		{ "name", "desc", spacing = " " },
	}
}


function M.create_buffer()
	M.View.bufhandle = api.nvim_create_buf(false, false)

	for opt,val in pairs(M.View.bufopts) do
		api.nvim_buf_set_option(M.View.bufhandle, opt, val)
	end

	-- check if there's already a buffer with name in `PLUGID`
	-- and deletes it
	do
		local buffers = api.nvim_list_bufs()
		for _,buf in ipairs(buffers) do
			if api.nvim_buf_get_name(buf) == PLUGID then
				api.nvim_buf_delete(buf, { force = true })
				break
			end
		end
	end

	api.nvim_buf_set_name(M.View.bufhandle, PLUGID)
end

function M.lock_buffer(lock)
	api.nvim_buf_set_option(M.View.bufhandle, "modifiable", not lock)
	api.nvim_buf_set_option(M.View.bufhandle, "readonly", lock)
end

function M.open_window()
	vim.cmd("tabnew")

	M.View.winhandle = api.nvim_get_current_win()

	for opt,val in pairs(M.View.winopts) do
		api.nvim_win_set_option(M.View.winhandle, opt, val)
	end

	api.nvim_win_set_buf(M.View.winhandle, M.View.bufhandle)
end


function M.create_groups()
	for group,options in pairs(M.Layout.groups) do
		local higroup = PLUGID..group
		local cmd = "hi def "..higroup
		for opt,val in pairs(options) do
			if opt == "link" then
				cmd = string.format("hi link %s %s", higroup, val)
				break
			end
			cmd = string.format("%s %s=%s", cmd, opt, val)
		end
		vim.cmd(cmd)
	end
end

function M.view_init()
	M.create_buffer()
	M.open_window()

	if not M.View.nshandle then
		M.View.nshandle = api.nvim_create_namespace(PLUGID)
	end
end

function M.clean()
	if M.View.bufhandle then
		api.nvim_buf_delete(M.View.bufhandle, { force = true })
	end
	if M.View.winhandle then
		api.nvim_win_close(M.View.winhandle, true)
	end
end

function M.render()
	local comp_dict = {}
	for comp,_ in pairs(M.Layout.components) do
		comp_dict[comp] = {}
	end

	local lines = {}

	for _,row in ipairs(M.Layout.rows) do
		local curr_line = ""
		for _,comp in ipairs(row) do
			local comp_opts = M.Layout.components[comp]
			local comp_text = nil

			if type(comp_opts.text) == "function" then
				comp_text = comp_opts.text()
			else
				comp_text = comp_opts.text
			end

			local col_start = #curr_line
			curr_line = curr_line..comp_text
			local col_end = #curr_line
			table.insert(comp_dict[comp], { comp_opts.group, #lines, col_start, col_end })

			if row.spacing then
				curr_line = curr_line..row.spacing
			end

		end
		table.insert(lines, curr_line)
	end

	return { lines, comp_dict }
end

function M.draw()
	local lines, comp_dict = unpack(M.render())
	
	M.lock_buffer(false)
	api.nvim_buf_set_lines(M.View.bufhandle, 0, #lines, false, lines)
	M.lock_buffer(true)
	
	-- paint
	for compname,locations in pairs(comp_dict) do
		for _,loc in ipairs(locations) do
			-- { group, line, col_start, col_end }
			api.nvim_buf_add_highlight(M.View.bufhandle, M.View.nshandle, PLUGID..loc[1],
				loc[2], loc[3], loc[4])
		end
	end

end

M.view_init()
M.draw()

return M

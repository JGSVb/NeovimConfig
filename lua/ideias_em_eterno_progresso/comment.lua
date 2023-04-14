local function apply_comment(left, right)
	local applied = left..string.format(vim.o.commentstring, right)
	return applied
end

local function get_left_space_wid(content)
	local wid = 0

	for i=1,#content do
		local c = content:sub(i,i)
		if c == ' ' then -- space
			wid = wid + 1
		elseif c == '	' then -- tab
			wid = wid + vim.o.tabstop
		else
			break
		end
	end

	return wid

end

function strip_left(content)

	local len = #content
	local s = 1

	for i=1,len do
		local c = content:sub(i,i)
		s = i
		if c ~= ' ' and c ~= '	' then
			break
		end
	end

	return content:sub(s, len)
end

local function split_spaces_at_pos(content, p)
	local s = get_left_space_wid(content)
	local right = s-p

	return {p, right}
end

local function size_to_spaces(size)
	local res = ""
	local remaining = size

	while remaining >= vim.o.tabstop do
		res = res..'	'
		remaining = remaining - vim.o.tabstop
	end
	
	res = res..string.rep(" ", remaining)

	return res
end

function Comment(lstart, lend)
	
	local min = nil 
	local lines = vim.api.nvim_buf_get_lines(0, lstart, lend, false)

	for _, v in pairs(lines) do
		local s = get_left_space_wid(v)
		print(v, s)
		if not min or s < min then
			min = s
		end
	end

	for _, v in pairs(lines) do
		local splited = split_spaces_at_pos(v, min)
		local commented = apply_comment(size_to_spaces(min), size_to_spaces(splited[2])..strip_left(v))
		print(commented)

	end

end


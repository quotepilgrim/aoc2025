local t = {}
local result
local data = {}

local function p1()
	print(table.concat(data, "\n"))
end

local function p2()
	print(table.concat(data, "\n"))
end

function t.load(part, filename)
	local file = assert(io.open(filename))

	for line in file:lines() do
		table.insert(data, line)
	end

	if part == 1 then
		p1()
	elseif part == 2 then
		p2()
	end

	return result
end

function t.draw()
	love.graphics.print(result or "")
end

return t

local t = {}
local result

local function p1(data)
	local result = 0

	for y = 1, #data - 1 do
		for x = 1, #data[1] do
			if data[y][x] == "|" or data[y][x] == "S" then
				if data[y + 1][x] == "^" then
					data[y + 1][x + 1] = "|"
					data[y + 1][x - 1] = "|"
					result = result + 1
				else
					data[y + 1][x] = "|"
				end
			end
		end
	end

	return result
end

local function p2(data)
	local result = 0
	return result
end

function t.load(part, filename)
	local file = assert(io.open(filename))
	local data = {}

	for line in file:lines() do
		local row = {}
		for i = 1, #line do
			local c = line:sub(i, i)
			table.insert(row, c)
		end
		table.insert(data, row)
	end

	if part == 1 then
		result = p1(data)
	elseif part == 2 then
		result = p2(data)
	end

	return result
end

function t.draw()
	love.graphics.print(result or "")
end

return t

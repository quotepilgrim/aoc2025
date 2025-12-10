local t = {}
local result
local sqrt = math.sqrt

local function get_distance(a, b)
	return sqrt((a[1] - b[1]) ^ 2 + (a[2] - b[2]) ^ 2 + (a[3] - b[3]) ^ 2)
end

local function p1(data)
	local result = 0
	local box_pairs = {}

	for i = 1, #data do
		for j = i + 1, #data do
			local a, b = data[i], data[j]
			table.insert(box_pairs, { a, b, get_distance(a, b) })
		end
	end

	table.sort(box_pairs, function(a, b)
		return a[3] < b[3]
	end)

	return result
end

local function p2(data)
	local result = 0
	print(table.concat(data, "\n"))
	return result
end

function t.load(part, filename)
	local file = assert(io.open(filename))
	local data = {}

	for line in file:lines() do
		local row = {}
		local matches = line:gmatch("[^,]+")
		for match in matches do
			table.insert(row, match)
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

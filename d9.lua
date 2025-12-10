local t = {}
local result
local abs = math.abs

local function p1(data)
	local result = 0
	for i = 1, #data do
		local a = data[i]
		for j = i + 1, #data do
			local b = data[j]
			local w = abs(a[1] - b[1]) + 1
			local h = abs(a[2] - b[2]) + 1
			local area = w * h

			if area > result then
				result = area
			end
		end
	end
	return result
end

local function p2(data)
	print(table.concat(data, "\n"))
end

function t.load(part, filename)
	local file = assert(io.open(filename))
	local data = {}

	for line in file:lines() do
		local row = {}
		for match in line:gmatch("[^,]+") do
			table.insert(row, tonumber(match))
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

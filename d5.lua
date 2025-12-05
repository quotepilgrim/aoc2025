local t = {}
local result
local max, min = math.max, math.min

local function p1(data)
	local result = 0
	local ranges, ids = data.ranges, data.ids
	for _, i in ipairs(ids) do
		for _, r in ipairs(ranges) do
			if i >= r[1] and i <= r[2] then
				result = result + 1
				break
			end
		end
	end
	return result
end

local function p2(data)
	local result = 0
	local ranges = data.ranges

	--[[removing my attempt at part 2 for now because it's clearly the wrong thing
	to do even though I can only be off from the correct answer by at most 9.]]

	return string.format("%0.15d", result)
end

function t.load(part, filename)
	local file = assert(io.open(filename))
	local data = {}
	local line

	data.ranges = {}
	data.ids = {}

	line = file:read()

	while line and line ~= "" do
		local row = {}
		local matches = line:gmatch("[^-]+")
		for match in matches do
			table.insert(row, tonumber(match))
		end
		table.insert(data.ranges, row)
		line = file:read()
	end

	line = file:read()

	while line and line ~= "" do
		table.insert(data.ids, tonumber(line))
		line = file:read()
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

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

	local function is_inside(r1, r2)
		if r1[1] >= r2[1] and r1[2] <= r2[2] then
			return true
		end
	end

	local function intersect_right(r1, r2)
		if r1[1] < r2[2] and r1[2] > r2[2] then
			return true
		end
	end

	for i = #ranges, 1, -1 do
		for j = #ranges, 1, -1 do
			if j ~= i then
				local r1 = ranges[i]
				local r2 = ranges[j]
				if is_inside(r1, r2) then
					table.remove(ranges, i)
				elseif intersect_right(r1, r2) then
					r1[1] = r2[2] + 1
				elseif intersect_right(r2, r1) then
					r2[1] = r1[2] + 1
				end
			end
		end
	end

	for _, r in ipairs(ranges) do
		result = result + (r[2] - r[1] + 1)
	end

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

local t = {}
local result
local floor = math.floor

local function p1(data)
	local sizes, sums = {}, {}

	local function get_sum(tbl)
		local result = 0
		for i = 3, #tbl do
			result = result + tbl[i]
		end
		return result
	end

	for _, v in ipairs(data[#data]) do
		local matches = v:gmatch("[%d]+")
		local nums = {}
		for match in matches do
			table.insert(nums, tonumber(match))
		end
		table.insert(sizes, { nums[1], nums[2] })
		table.insert(sums, get_sum(nums))
	end

	local result = 0
	for i = 1, #sizes do
		local w, h = unpack(sizes[i])
		w, h = floor(w / 3), floor(h / 3)

		local area = w * h

		if sums[i] <= area then
			result = result + 1
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
	data[1] = {}

	for line in file:lines() do
		if line == "" then
			table.insert(data, {})
		else
			table.insert(data[#data], line)
		end
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

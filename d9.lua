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
	return
end

local points = {}
function t.load(part, filename)
	local file = assert(io.open(filename))
	local data = {}

	love.window.setMode(1000, 1000)
	love.graphics.setPointSize(2)

	for line in file:lines() do
		local row = {}
		for match in line:gmatch("[^,]+") do
			table.insert(row, tonumber(match))
			table.insert(points, tonumber(match) / 100)
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
	love.graphics.setColor(0.5, 1, 0.5, 1)
	love.graphics.polygon("line", unpack(points))
	love.graphics.setColor(1, 0.25, 0.25, 1)
	love.graphics.points(unpack(points))
	love.graphics.setColor(1, 1, 1, 1)
end

return t

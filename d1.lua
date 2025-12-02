local t = {}
local result

local function p1(dial, data)
	result = 0
	for _, v in ipairs(data) do
		dial = (dial + v) % 100
		if dial == 0 then
			result = result + 1
		end
	end
	return result
end

local function p2(dial, data)
	result = 0
	for _, v in ipairs(data) do
		local dir
		if v < 0 then
			dir = -1
		else
			dir = 1
		end

		for _ = 1, math.abs(v) do
			dial = (dial + dir) % 100
			if dial == 0 then
				result = result + 1
			end
		end
	end
	return result
end

local function sign(n)
	if n > 0 then
		return 1
	elseif n < 0 then
		return -1
	end
end

function t.load(part, filename)
	local data = {}
	local file = io.open(filename)

	if not file then
		return
	end

	for line in file:lines() do
		local dir, num = line:sub(1, 1), tonumber(line:sub(2, #line))
		if dir == "L" then
			table.insert(data, -num)
		else
			table.insert(data, num)
		end
	end

	if part == 1 then
		result = p1(50, data)
	elseif part == 2 then
		result = p2(50, data)
	end

	return result
end

function t.draw()
	love.graphics.print(result or "")
end

return t

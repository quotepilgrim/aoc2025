local t = {}
local result

math.randomseed(os.time())

local function p1(data)
	local patterns = {}
	for i = 1, 2 ^ 16 - 1 do
		table.insert(patterns, i)
	end

	local function count_bits(n)
		local count = 0
		while n > 0 do
			n = bit.band(n, n - 1)
			count = count + 1
		end
		return count
	end

	table.sort(patterns, function(a, b)
		return count_bits(a) < count_bits(b)
	end)

	local result = 0
	for _, machine in ipairs(data) do
		local target, buttons = machine.target, machine.buttons

		for _, pattern in ipairs(patterns) do
			local lights = 0
			for j = 0, 15 do
				if bit.band(pattern, bit.lshift(1, j)) > 0 then
					if buttons[j + 1] then
						lights = bit.bxor(lights, buttons[j + 1])
					end
				end
			end
			if lights == target then
				result = result + count_bits(pattern)
				break
			end
		end
	end
	return result
end

local function p2(data)
	-- print(table.concat(data, "\n"))
end

function t.load(part, filename)
	local file = assert(io.open(filename))
	local data = {}

	for line in file:lines() do
		local matches = line:gmatch("[^%s]+")
		local row = {}
		for match in matches do
			table.insert(row, match:sub(2, #match - 1))
		end
		local target = row[1]:gsub("%.", "0"):gsub("#", "1"):reverse()
		local buttons = {}

		for i = 2, #row - 1 do
			local button = 0
			matches = row[i]:gmatch("[^,]+")
			for match in matches do
				button = button + 2 ^ match
			end
			table.insert(buttons, button)
		end

		table.insert(data, { target = tonumber(target, 2), buttons = buttons })
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

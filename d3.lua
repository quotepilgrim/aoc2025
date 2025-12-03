local t = {}
local result

local function p1(data)
	local result = 0
	for _, s in ipairs(data) do
		local max = 0
		local max_pos = 1
		local jolts = ""

		for i = 1, #s - 1 do
			local digit = assert(tonumber(string.sub(s, i, i)))
			if digit > max then
				max = digit
				max_pos = i
			end
		end

		jolts = jolts .. tostring(max)
		max = 0

		for i = max_pos + 1, #s do
			local digit = assert(tonumber(string.sub(s, i, i)))
			if digit > max then
				max = digit
				max_pos = i
			end
		end

		jolts = jolts .. tostring(max)
		result = result + tonumber(jolts)
	end
	return result
end

local function p2(data)
	local result = 0
	for _, s in ipairs(data) do
		local offset = -11
		local max = 0
		local max_pos = 0
		local jolts = ""

		while offset <= 0 do
			max = 0
			for i = max_pos + 1, #s + offset do
				local digit = assert(tonumber(string.sub(s, i, i)))
				if digit > max then
					max = digit
					max_pos = i
				end
			end
			jolts = jolts .. tostring(max)
			offset = offset + 1
		end

		result = result + tonumber(jolts)
	end
	return string.format("%18.0f", result)
end

function t.load(part, filename)
	local file = assert(io.open(filename))
	local data = {}

	for line in file:lines() do
		table.insert(data, line)
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

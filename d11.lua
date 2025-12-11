local t = {}
local result

local function p1(data)
	local stack = { data.you }

	local result = 0
	while #stack > 0 do
		local node = table.remove(stack)

		for _, v in ipairs(node) do
			table.insert(stack, data[v])
			if v == "out" then
				result = result + 1
			end
		end
	end

	return result
end

local function p2(data)
	return nil
end

function t.load(part, filename)
	local file = assert(io.open(filename))
	local data = {}

	for line in file:lines() do
		local row = {}
		local matches = line:gmatch("[^%s]+")
		for match in matches do
			table.insert(row, match)
		end
		local name = table.remove(row, 1)
		data[name:sub(1, #name - 1)] = row
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

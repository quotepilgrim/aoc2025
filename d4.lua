local t = {}
local result

local neighbors = {
	{ -1, -1 },
	{ -1, 0 },
	{ -1, 1 },
	{ 0, -1 },
	{ 0, 1 },
	{ 1, -1 },
	{ 1, 0 },
	{ 1, 1 },
}

local function count_neighbors(tbl, i, j)
	if tbl[i][j] == "." then
		return
	end
	local count = 0
	for _, n in ipairs(neighbors) do
		local dy, dx = unpack(n)
		local neighbor = tbl[i + dy] and tbl[i + dy][j + dx]
		if neighbor == "@" then
			count = count + 1
		end
	end
	return count
end

local function p1(data)
	local result = 0
	for i, row in ipairs(data) do
		for j = 1, #row do
			local count = count_neighbors(data, i, j)
			if count and count < 4 then
				result = result + 1
			end
		end
	end
	return result
end

local function p2(data)
	local result = 0
	local to_remove = {}
	local removed

	repeat
		removed = false
		for i, row in ipairs(data) do
			for j = 1, #row do
				local count = count_neighbors(data, i, j)
				to_remove[i] = to_remove[i] or {}
				if count and count < 4 then
					to_remove[i][j] = true
					removed = true
					result = result + 1
				else
					to_remove[i][j] = false
				end
			end
		end
		for i, row in ipairs(to_remove) do
			for j, rem in ipairs(row) do
				if rem then
					data[i][j] = "."
				end
			end
		end
	until not removed

	return result
end

function t.load(part, filename)
	local file = assert(io.open(filename))
	local data = {}

	for line in file:lines() do
		local row = {}
		for i = 1, #line do
			table.insert(row, line:sub(i, i))
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

local t = {}
local result

local function p1(data)
	local result = 0
	for i = 1, #data[1] do
		local problem = {}
		for j = 1, #data do
			table.insert(problem, data[j][i])
		end
		if problem[#problem] == "+" then
			for n = 1, #problem - 1 do
				result = result + problem[n]
			end
		else
			local prod = 1
			for n = 1, #problem - 1 do
				prod = prod * problem[n]
			end
			result = result + prod
		end
	end
	return result
end

local function p2(data)
	local result = 0
	local transform = {}

	local function add(tbl)
		local sum = 0
		for _, v in ipairs(tbl) do
			sum = sum + v
		end
		return sum
	end

	local function multiply(tbl)
		local prod = 1
		for _, v in ipairs(tbl) do
			prod = prod * v
		end
		return prod
	end

	for i = 1, #data[1] do
		local col = ""
		for j = 1, #data do
			local v, _ = data[j]:sub(i, i):gsub(" ", "")
			col = col .. v
		end
		if col ~= "" then
			table.insert(transform, col)
		end
	end

	local problem = {}
	for i = #transform, 1, -1 do
		local s = transform[i]
		if s:sub(#s, #s) == "*" then
			table.insert(problem, tonumber(s:sub(1, #s - 1)))
			result = result + multiply(problem)
			problem = {}
		elseif s:sub(#s, #s) == "+" then
			table.insert(problem, tonumber(s:sub(1, #s - 1)))
			result = result + add(problem)
			problem = {}
		else
			table.insert(problem, tonumber(s))
		end
	end
	return result
end

function t.load(part, filename)
	local file = assert(io.open(filename))
	local data = {}

	if part == 1 then
		for line in file:lines() do
			local row = {}
			local matches = line:gmatch("[^%s]+")
			for match in matches do
				table.insert(row, match)
			end
			table.insert(data, row)
		end
		result = p1(data)
	elseif part == 2 then
		for line in file:lines() do
			table.insert(data, line)
		end
		result = p2(data)
	end

	return result
end

function t.draw()
	love.graphics.print(result or "")
end

return t

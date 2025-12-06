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
	return result
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

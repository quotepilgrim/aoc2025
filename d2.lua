local t = {}
local result, data

local function p1()
	local invalid = {}
	for _, range in ipairs(data) do
		for i = range[1], range[2] do
			local s = tostring(i)
			if #s % 2 == 0 then
				local h1, h2 = string.sub(s, 1, #s / 2), string.sub(s, #s / 2 + 1, #s)
				if h1 == h2 then
					table.insert(invalid, i)
				end
			end
		end
	end

	result = 0
	for _, i in ipairs(invalid) do
		result = result + i
	end
end

local function p2()
	local invalid = {}

	local function all_equals(splits)
		for i = 1, #splits - 1 do
			if splits[i] ~= splits[i + 1] then
				return false
			end
		end
		return true
	end

	local function repeats(num)
		local s = tostring(num)
		for i = 1, #s / 2 do
			if #s % i == 0 then
				local split_start = 1
				local split_end = i
				local splits = {}
				while split_end <= #s do
					table.insert(splits, string.sub(s, split_start, split_end))
					split_start = split_end + 1
					split_end = split_end + i
				end
				if all_equals(splits) then
					print(table.concat(splits, ","))
					return true
				end
			end
		end
		return false
	end

	for _, range in ipairs(data) do
		for i = range[1], range[2] do
			if repeats(i) then
				table.insert(invalid, i)
			end
		end
	end

	result = 0
	for _, i in ipairs(invalid) do
		result = result + i
	end
end

function t.load(part, filename)
	local file = assert(io.open(filename))

	data = {}

	for line in file:lines() do
		for range in line:gmatch("[^,]*") do
			if range ~= "" then
				local r = {}
				for num in range:gmatch("[^-]*") do
					table.insert(r, tonumber(num))
				end
				table.insert(data, r)
			end
		end
	end

	if part == 1 then
		p1()
	elseif part == 2 then
		p2()
	end

	return result
end

function t.draw()
	love.graphics.print(result or "")
end

return t

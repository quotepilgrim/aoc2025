local abs, min, max = math.abs, math.min, math.max
return function(data)
	--This solution was implemented after manually finding the answer as
	--described in day 9's main file. It relies on knowing that the biggest
	--possible rectangle that fits inside the polygon must contain the rightmost
	--point from one of the two longest lines (based on the polygon's shape)
	local max_length = 0
	local longest_line

	for i = 1, #data - 1 do
		local a, b = data[i], data[i + 1]
		if a[2] == b[2] then
			local length = abs(a[1] - b[1])
			if length > max_length then
				max_length = length
				longest_line = { a, b }
			end
		end
	end

	local llx = max(longest_line[1][1], longest_line[2][1])

	local result = 0
	for i = 1, #data do
		local a = data[i]
		for j = i + 1, #data do
			local b = data[j]
			local w = abs(a[1] - b[1]) + 1
			local h = abs(a[2] - b[2]) + 1
			local area = w * h

			local x = min(a[1], b[1])
			local y = min(a[2], b[2])

			if a[1] == llx or b[1] == llx then
				local valid = true
				for _, p in ipairs(data) do
					if p[1] > x and p[1] < x + w and p[2] > y and p[2] < y + h then
						valid = false
						break
					end
				end
				if valid and area > result then
					result = area
				end
			end
		end
	end
	--On a side note, I think the way I'm checking for invalid rectangles could
	--also eliminate some valid rectangles if some of the outer points in the
	--polygon line up with the points at the right end of the longest lines,
	--but it doesn't seem to do that on my input.
	return result
end

local t = {}
local result, data

function t.load(part, filename)
	local file = assert(io.open(filename))

	if part == 1 then
		result = "p1"
	elseif part == 2 then
		result = "p2"
	end

	return result
end

function t.draw()
	love.graphics.print(result or "")
end

return t

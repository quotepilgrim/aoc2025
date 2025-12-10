local t = {}
local result
local abs, min, max = math.abs, math.min, math.max
local rect, ri
local p2a = require("alt.d9p2a")

local function p1(data)
	local result = 0
	for i = 1, #data do
		local a = data[i]
		for j = i + 1, #data do
			local b = data[j]
			local w = abs(a[1] - b[1]) + 1
			local h = abs(a[2] - b[2]) + 1
			local area = w * h

			if area > result then
				result = area
			end
		end
	end
	return result
end

local function p2(data)
	local rects = {}
	for i = 1, #data do
		local a = data[i]
		for j = i + 1, #data do
			local b = data[j]
			local w = abs(a[1] - b[1]) + 1
			local h = abs(a[2] - b[2]) + 1
			local area = w * h

			local x = min(a[1], b[1])
			local y = min(a[2], b[2])

			if a[1] == 94671 or b[1] == 94671 then
				--This is the x coordinate of the red tiles that are in the
				--two longest green lines. I found it by hand but in hindsight
				--I could have written code to measure the length of all lines
				--and find it that way.
				table.insert(rects, { x, y, w, h, area })
			end
		end
	end

	table.sort(rects, function(a, b)
		return a[5] < b[5]
	end)

	return rects
end

local points = {}
local rects

function t.load(part, filename)
	local file = assert(io.open(filename))
	local data = {}

	love.window.setMode(1000, 1000)
	love.graphics.setPointSize(2)

	for line in file:lines() do
		local row = {}
		for match in line:gmatch("[^,]+") do
			table.insert(row, tonumber(match))
			table.insert(points, tonumber(match) / 100)
		end
		table.insert(data, row)
	end

	if part == 1 then
		result = p1(data)
	elseif part == 2 then
		rects = p2(data)
		ri = #rects
		rect = rects[ri]
		result = rect[5]
	elseif part == 201 then
		result = p2a(data)
	end

	return result
end

function t.draw()
	love.graphics.print(result or "")
	love.graphics.setColor(0.5, 1, 0.5, 1)
	love.graphics.polygon("line", unpack(points))
	love.graphics.setColor(1, 0.25, 0.25, 1)
	love.graphics.points(unpack(points))
	love.graphics.setColor(1, 1, 1, 1)
	if rect then
		love.graphics.rectangle("line", rect[1] / 100, rect[2] / 100, rect[3] / 100, rect[4] / 100)
	end
end

love.keyboard.setKeyRepeat(true)

function t.keypressed(k)
	--Checking each rectangle manually LOL.
	--I could probably have tested line intersections between all four sides
	--of each rectangle and the lines that make up the large polygon but just
	--looking at the rectangles was faster than coding that so here we are.
	if not rects then
		return
	end
	if k == "pagedown" then
		if love.keyboard.isDown("lshift") then
			ri = max(ri - 100, 1)
		else
			ri = max(ri - 1, 1)
		end
		rect = rects[ri]
		result = rect[5]
		love.system.setClipboardText(result)
	elseif k == "pageup" then
		if love.keyboard.isDown("lshift") then
			ri = min(ri + 100, #rects)
		else
			ri = min(ri + 1, #rects)
		end
		rect = rects[ri]
		result = rect[5]
		love.system.setClipboardText(result)
	elseif k == "f1" then
		print(rect[1] .. "," .. rect[2])
		print(rect[1] + rect[3] - 1 .. "," .. rect[2] + rect[4] - 1)
	end
	print(ri)
end

return t

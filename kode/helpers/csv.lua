-- load data from a .csv file
local function loadFile(path)
	local nums = 0
	local lines = {}
	for line in io.lines(path) do
		nums = nums + 1
		lines[nums] = line
	end

	return nums, lines
end

-- make line string to table
local function makeLine(line_text)
	local nums = 0
	local values = {}
	if line_text ~= nil then
		while string.find(line_text, ",") ~= nil do
			nums = nums + 1
			i, j = string.find(line_text, ",")
			values[nums] = string.sub(line_text, 1, j-1)
			line_text = string.sub(line_text, j+1, string.len(line_text))
		end
		nums = nums + 1
		values[nums] = line_text
	end

	return nums, values
end

function kode.loadcsv(path)
	if path == nil then return nil, nil, nil end

	local data = {}
	nums, lines = loadFile(path)

	labelNum, labels = makeLine(lines[1])
	for i=2, nums do
		tmpNum, data[i-1] = makeLine(lines[i])
	end

	return nums-1, data, labels
end
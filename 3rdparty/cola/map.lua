local string, table, type, pairs, ipairs, tostring, print = 
	string, table, type, pairs, ipairs, tostring, print

module(...)

function Haskey(tbl, key)
	return type(tbl) == "table" and tbl[key] ~= nil
end

function Keys(tbl)
	local keys = {}
	for k, v in pairs(tbl) do
		keys[#keys + 1] = k
	end
	return keys
end

function Values(tbl)
	local values = {}
	for k, v in pairs(tbl) do
		values[#values + 1] = v
	end
	return values
end

function Len(tbl)
	if type(tbl) ~= "table" then return nil end
	local nums = 0
	for k, v in pairs(tbl) do
		nums = nums + 1
	end
	return nums
end

function Tostring(tbl, indent, done)
	local done = done or {}
	local indent = indent or 0
	local space = string.rep(" ", indent)

	if type(tbl) == "table" then
		local sb = {}

		for key, value in pairs(tbl) do
			table.insert(sb, space)	-- indent it

			if type(value) == "table" and not done[value] then
				done[value] = true
				table.insert(sb, key .. " = {\n")
				table.insert(sb, Tostring(value, indent + 2, done))
				table.insert(sb, space)	-- indent it
				table.insert(sb, "}\n")
			elseif "number" == type then
				table.insert(sb, string.format("\"%s\" ", tostring(value)))
			else
				table.insert(sb, string.format("%s = \"%s\"\n", tostring(key), 
							tostring(value)))
			end
		end
		return table.concat(sb)
	else
		return tbl .. "\n"
	end
end

-- Update target table with source table
function Update(target, source, keys)
	if keys then
		for _, key in ipairs(keys) do
			target[key] = source[key]
		end
	else
		for k, v in pairs(source) do
			target[k] = v
		end
	end
end

function Clone(source, keys)
	local target = {}
	Update(target, source, keys)

	return target
end

-- Recursively print a table.
function TablePrint(tbl)
	local print, type, pairs = print, type, pairs
	for _, v in pairs(tbl) do
		if type(v) == [[table]] then
			TablePrint(v)
		else
			print(v)
		end
	end
end

-- Recursively concat a table
function TableConcat(tbl)
	local table, output = table, {}
	local function table_concat_(tbl, output)
		local insert, type, pairs = table.insert, type, pairs
		local v
		for k, v in pairs(tbl) do
		if type(v) == [[table]] then
				table_concat_(v, output)
			else
				insert(output, v)
			end
		end
	end
	table_concat_(tbl, output)
	return table.concat(output)
end
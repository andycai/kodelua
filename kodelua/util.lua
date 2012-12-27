local util
util = {
	Round = function(num)
		return math.floor(num + 0.5)
	end;

	Tostring = function(data)
		if "nil" == type(data) then
			return tostring(nil)
		elseif "table" == type(data) then
			return map.Tostring(data)
		elseif "string" == type(data) then
			return data
		else
			return tostring(data)
		end
	end;

	Dump = function(data, name)
		print(map.Tostring{name or "*", data})
	end;

	Vardump = function(...)
		local count = select("#", ...)
		if count < 1 then return end

		fmt.Printf("Vardump:")
		for i = 1, count do
			local v = select(i, ...)
			local t = type(v)
			if t == "string" then
				fmt.Printf("  %02d: [string] %s", i, v)
			elseif t == "boolean" then
				fmt.Printf("  %02d: [boolean] %s", i, tostring(v))
			elseif t == "number" then
				fmt.Printf("  %02d: [number] %0.2f", i, v)
			else
				fmt.Printf("  %02d: [%s] %s", i, t, tostring(v))
			end
		end
	end;

	Escape = function(str)
		if str == nil then return '' end
		local esc, i = str:gsub('&', '&amp'):gsub('<', '&lt'):gsub('>', '&gt')

		return esc
	end;

	URLEncode = function(data)
		return data:gsub("\n", "\r\n"):gsub("([^%-%-%/])", 
			function(c) return ("%%%02X"):format(string.byte(c)) 
		end)
	end;

	URLParse = function(data, sep)
		local result = {}
		sep = sep or '&'
		data = data .. sep

		for piece in data:gmatch("(.-)" .. sep) do
			local k,v = piece:match("%s*(.-)%s*=(.*)")

			if k then
				result[url_decode(k)] = url_decode(v)
			else
				result[#result + 1] = url_decode(piece)
			end
		end

		return result
	end
}

return util
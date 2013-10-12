function string.unescape(url)
	url = string.gsub(url, "+", " ")
	url = string.gsub(url, "%%(%x%x)", function(hex)
		return string.char(tonumber(hex, 16))
	end)  

	return url
end

function string.split(s, sep)
	local t = {}
	for o in string.gmatch(s, "([^" .. (sep or " ") .. "]+)") do 
		table.insert(t, o) 
	end

	return t
end

-- Split a string by another string
-- Copied and adapted from http://luanet.net/lua/function/explode
function string.explode(s, sep)
	local pos, arr = 0, {}
	for st, sp in function() return string.find(s, sep, pos, true) end do -- for each divider found
		table.insert(arr, string.sub(s, pos, st-1)) -- Attach chars left of current divider
		pos = sp + 1 -- Jump past current divider
	end
	table.insert(arr, s:sub(pos)) -- Attach chars right of last divider
	return arr
end

function string.replace(search, replace, subject, count)
	count = count or {['v'] = 0}

	local s
	local c = 0

	local str_replace_ = function(search, replace, subject, count)
		subject = subject or ''
		count = count or {['v'] = 0}

		local  pos, buf, len = 0, {}, 0
		count.v = 0
		len = #search
		for st, sp in function() return string.find(subject, search, pos, true) end do -- for each match found
			table.insert(buf, string.sub(subject, pos, st - len)) -- Attach chars left of match
			table.insert(buf, replace) -- Attach replacement string
			pos = sp + len -- Jumb past current match
			count.v = count.v + 1
		end
		table.insert(buf, subject:sub(pos)) -- Attach chars right of last match
		return table.concat(buf), count.v
	end

	if type(search) ~= "table" then search = {search} end
	count.v = 0

	for _, s in pairs(search) do
		subject, c = str_replace_(s, replace, subject, count)
		count.v = count.v + c
	end

	return subject, count.v
end

-- string.strtr("My name is $name. I am $age years old.", {"$name"="Andy", "$age"=10})
-- string.strtr("My name is $name", "$name", "Andy")
function string.strtr(...)
	local str, from, to, replace_pairs
	str = select(1, ...) or ''
	replace_pairs = select(2, ...)
	if type(replace_pairs) == "table" then
		for from, to in pairs(replace_pairs) do
			str = string.strtr(s, from, to)
		end
		return str
	else
		from = select(2, ...)
		to = select(3, ...)
		return string.gsub(str, from, to)
	end
end

-- find position of first occurrence of a string
function string.strpos(haystack, needle, offset)
	offset = offset or 1
	local start_, end_ = nil, nil
	start_, end_ = string.find(haystack, needle, offset)
	return start_ and start_ - 1 or false
end

function string.indexOf(haystack, needle, offset)
	local v = string.strpos(haystack, needle, offset)
	if v == false then v = -1 end
	return v
end

function string.strip_(s, pattern)
	pattern = pattern or "%s+"
	s = s:gsub("^" .. pattern, "")
	s = s:gsub(pattern .. "$", "")
	return s
end

function string.strip(s, ...)
	local count = select("#", ...)
	for i = 1, count do
		local v = select(i, ...)
		s = string.strip_(s, v)
	end
	return s
end

function string.trim(s, pattern)
	pattern = pattern or "%s"
	return s:gsub("^" .. pattern .. "*(.-)" .. pattern .. "*$", "%1")
end

function string.ltrim(s, pattern)
	pattern = pattern or "%s"
	return s:gsub("^[" .. pattern .. "]*", "")
end

function string.rtrim(s, pattern)
	pattern = pattern or "%s"
	local n = #s
	while n > 0 and s:find("^" .. pattern, n) do n = n -1 end
	return s:sub(1, n)
end

function string.camelCase(s)
	local splitTable = s:split("_-")
	local result = table.remove(splitTable, 1)
	for i, chunk in ipairs(splitTable) do
		result = result .. chunk:sub(1,1):upper() .. chunk:sub(2)
	end

	return result
end

function string.escape(s)
	s = string.gsub(s, "([!%*'%(%);:@&=%+%$,/%?#%[%]<>~%.\"{}|\\%-`_%^%%%c])",
				function (c)
					return string.format("%%%02X", string.byte(c))
				end)
	s = string.gsub(s, " ", "+")

	return s
end

function string.decodeEntities(s)
	local entities = {
		amp = "&",
		lt = "<",
		gt = ">",
		quot = "\"",
		apos = "'", 
		nbsp = " ",
		iexcl = "¡",
		cent = "¢",
		pound = "£",
		curren = "¤",
		yen = "¥",
		brvbar = "¦",
		sect = "§",
		uml = "¨",
		copy = "©",
		ordf = "ª",
		laquo = "«",
		--    not = "¬",
		shy = "­",
		reg = "®",
		macr = "¯",
		deg = "°",
		plusmn = "±",
		sup2 = "²",
		sup3 = "³",
		acute = "´",
		micro = "µ",
		para = "¶",
		middot = "·",
		cedil = "¸",
		sup1 = "¹",
		ordm = "º",
		raquo = "»",
		frac14 = "¼",
		frac12 = "½",
		frac34 = "¾",
		iquest = "¿",
		times = "×",
		divide = "÷",   
	}

	return string.gsub(s, "&(%w+);", entities)
end

function string.caseInsensitive(s)
	s = string.gsub(s, "%a", function (c)
		return string.format("[%s%s]", string.lower(c), string.upper(c))
	end)
	return s
end
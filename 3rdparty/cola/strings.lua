local table, string = table, string

module(...)

function Split(str, separator, maxNb)
	if str:find(separator) == nil then
		return { str }
	end
	
	if maxNb == nil or maxNb < 1 then
		maxNb = 0
	end
	
	local result = {}
	local pat = "(.-)" .. separator .. "()"
	local nb = 0
	local lastPos
	for part, pos in str:gfind(pat) do
		nb = nb + 1
		result[nb] = part
		lastPos = pos
		if nb == maxNb then break end
	end

	if nb ~= maxNb then
		result[nb + 1] = str:sub(lastPos)
	end
	
	return result
end

function PushBuffer(tbl, str)
	if tbl and str then
		table.insert(tbl, str)
	end
end

function PullBuffer(tbl)
	if tbl then
		return table.concat(tbl)
	end
end

-- Split a string by another string
-- Copied and adapted from http://luanet.net/lua/function/explode
function Explode (str, separator) 
	local pos, arr = 0, {}
	for st, sp in function() return string.find( str, separator, pos, true ) end do -- for each divider found
		table.insert( arr, string.sub( str, pos, st-1 ) ) -- Attach chars left of current divider
		pos = sp + 1 -- Jump past current divider
	end
		table.insert( arr, str:sub(pos) ) -- Attach chars right of last divider
	return arr
end

-- Strip whitespace (or other characters) from the end of a string
-- Copied and adapted from http://lua-users.org/wiki/CommonFunctions
function Ltrim(str, charlist)
	charlist = charlist or '%s'

	return str:gsub('^['.. charlist ..']*', '')
end

-- Strip whitespace (or other characters) from the beginning of a string
-- Copied and adapted from http://lua-users.org/wiki/CommonFunctions
function Rtrim(s, pattern)
	pattern = pattern or '%s'
	local n = #s
	while n > 0 and s:find('^'.. pattern, n) do n = n - 1 end
	return s:sub(1, n)
end

-- Remove leading and/or trailing spaces
-- Copied and adapted from http://www.lua.org/pil/20.3.html
function Trim (s, pattern)
	pattern = pattern or '%s'
	return s:gsub('^'.. pattern ..'*(.-)'.. pattern ..'*$', '%1')
end

-- Return part of a string
-- by Fernando P. García
function Substr(string_, start, length)
	return string.sub(string_, start, length)
end

-- Replace all occurrences of the search string with the replacement string
-- by Fernando P. García
function Replace(search, replace, subject, count)
	count = count or {['v'] = 0}

	local s
	local c = 0

	local str_replace_ = function (search, replace, subject, count)
		subject = subject or ''
		count = count or {['v'] = 0}

		local pos, buf, len = 0, {}, 0
		count.v = 0
		len = #search
		for st, sp in function() return string.find(subject, search, pos, true) end do -- for each match found
			table.insert(buf, string.sub(subject, pos, st - len)) -- Attach chars left of match
			table.insert(buf, replace) -- Attach replacement string
			pos = sp + len -- Jump past current match
			count.v = count.v + 1
		end
		table.insert(buf, subject:sub(pos)) -- Attach chars right of last match
		return table.concat(buf), count.v
	end

	if type(search) ~= 'table' then search = {search} end
	count.v = 0

	for _, s in pairs(search) do
		subject, c = str_replace_(s, replace, subject, count)
		count.v = count.v + c
	end

	return subject, count.v
end

-- Translate certain characters
-- by Fernando P. García
function Strtr(...)
	local str, from, to, replace_pairs
	str = select(1, ...) or ''
	replace_pairs = select(2, ...)
	if type(replace_pairs) == [[table]] then
		for from, to in pairs(replace_pairs) do
			str = Strtr(str, from, to)
		end
		return str
	else
		from = select(2, ...)
		to = select(3, ...)
		return string.gsub(str, from, to)
	end
end

-- Find position of first occurrence of a string
-- by Fernando P. García
function Strpos(haystack, needle, offset)
	offset = offset or nil
	local start, end_ = nil, nil
	start, end_ = string.find(haystack, needle)
	return start and start - 1 or false
end
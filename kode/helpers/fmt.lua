fmt = {}

function fmt.print(...)
	io.write()
end

function fmt.println(...)
	print(...)
end

function fmt.printf(str, ...)
	if str then print(str:format(...)) end
end

function fmt.sprintf(str, ...)
	if str then return str:format(...) end
end

function fmt.fprintf(f, ...)
	if f then return f:write(string.format(...)) end
end

function fmt.assert(expr, str, ...)
	if expr then return expr end
	local result = str:fomart(...)
	error(result)
end
local print, string, select, io, error = print, string, select, io, error

module(...)

function Print(...)
	io.write(...)
end

-- output with new line
function Println(...)
	print(...)
end

function Printf(str, ...)
	if str then print(str:format(...)) end
end

function Sprintf(str, ...)
	if str then return str:format(...) end
end

function Fprintf(f, ...) 
	if f then return f:write(string.format(...)) end
end

function Assert(expr, str, ...)
	if expr then return expr end
	local result = str:fomart(...)
	error(result)
end
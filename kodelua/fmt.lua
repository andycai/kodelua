local fmt
fmt = {
	Print = function(...)
		io.write()
	end;

	Println = function(...)
		print(...)
	end;

	Printf = function(str, ...)
		if str then print(str:format(...)) end
	end;

	Sprintf = function(str, ...)
		if str then return str:format(...) end
	end;

	Fprintf = function(f, ...)
		if f then return f:write(string.format(...)) end
	end;

	Asert = function(expr, str, ...)
		if expr then return expr end
		local result = str:fomart(...)
		error(result)
	end
}

return fmt
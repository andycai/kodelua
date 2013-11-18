-- In other words, it will return true if the variable is an empty string, false, array(), NULL, "0", 0, and an unset variable
function isempty(value)
	return value == nil or value == false or value == "" or value == 0 or value == "0" or (type(value) == "table" and table.len(value) == 0)
end

function istable(value)
	return type(value) == "table"
end

function isfunction(value)
	return type(value) == "function"
end

function isnumber(value)
	return type(value) == "number"
end

function isstring(value)
	return type(value) == "string"
end

function isbool(value)
	return type(value) == "boolean"
end

function isset(value)
	return type(value) ~= nil
end

function format(...)
	return string.format(...)
end

function checkvalue(value, msg)
	if not msg then msg = "value is nil" end
	if not value then
		error(msg)
	end
end
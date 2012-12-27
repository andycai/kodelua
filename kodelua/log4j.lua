local log4j
log4j = {
	Info = function(msg, ...)
		local str = "[Info] " .. msg
		print(str:format(...))
	end;

	Debug = function(msg, ...)
		local str = "[Debug] " .. msg
		print(str:format(...))
	end;
	
	Error = function(msg, ...)
		local str = "[Error] " .. msg
		print(str:format(...))
	end
}

return log4j
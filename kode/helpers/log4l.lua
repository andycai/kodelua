log4l = {}

function log4l.info(msg, ...)
	local str = "[Info] " .. msg
	print(str:format(...))
end

function log4l.debug(msg, ...)
	local str = "[Debug] " .. msg
	print(str:format(...))
end

function log4l.error(msg, ...)
	local str = "[Error] " .. msg
	print(str:format(...))
end
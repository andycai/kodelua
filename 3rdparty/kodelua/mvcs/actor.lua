local Object = require "kodelua.object"
local Notifier = require "kodelua.mvc.notifier"

local Actor = Object:Extend{
	Name = "Actor"
}

function Actor:Dispatch(eventObj)
	Notifier:Dispatch(eventObj)
end

function Actor:model(name)
	local fullModel = "model." .. name
	if pcall(require, fullModel) then
		return require(fullModel)
	else
		error(fullModel .. " not found")
	end
end

function Actor:service(name)
	local fullService= "model." .. name
	if pcall(require, fullService) then
		return require(fullService)
	else
		error(fullService .. " not found")
	end
end

return Actor
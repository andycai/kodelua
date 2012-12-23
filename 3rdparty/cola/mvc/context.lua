local Object = require "cola.object".Class
local Notifier = require "cola.mvc.notifier".Class

module(..., package.seeall)

local Context = Object:Extend{
	controllers = {}
}
Class = Context

function Context:ToString()
	print("hello, Context")
end

function Context:mapController(viewClass, controllerClass)
	assert(viewClass ~= nil, "viewClass cannot be nil.")
	assert(controllerClass ~= nil, "controllerClass cannot be nil.")

	require("cola." .. viewClass)
	require("cola." .. controllerClass)

	local className = assert(self:getClassName(viewClass), "Could not parse the class name")
	self.controllers[className] = controllerClass
	
	return true
end

function Context:unmapController(viewClass)
	assert(viewClass ~= nil, "viewClass cannot be nil.")

	local className = assert(self:getClassName(viewClass), "Could not parse the class name")
	self.controllers[className] = nil
	
	return true
end

function Context:Dispatch(eventObj)
	Notifier:Dispatch(eventObj)
end

function Context:getClassName(classType)
	assert(classType ~= nil, "You cannot pass a null classType")
	local testStartIndex, testEndIndex = classType:find(".", 1, true)

	if testStartIndex == nil then
		return classType
	end

	local startIndex = 1
	local endIndex = 1
	local lastStartIndex = 1
	local lastEndIndex = 1

	while startIndex do
		startIndex, endIndex = classType:find(".", startIndex, true)
		if startIndex ~= nil and endIndex ~= nil then
			lastStartIndex = startIndex
			lastEndIndex = endIndex
			startIndex = startIndex + 1
			endIndex = endIndex + 1
		end
	end
end
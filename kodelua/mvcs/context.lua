local Object = require "kodelua.object"
local Notifier = require "kodelua.mvc.notifier"

local Context = Object:Extend{
	Name = "Context";
	controllers = {}
}

function Context:mapController(viewClass, controllerClass)
	assert(viewClass ~= nil, "viewClass cannot be nil.")
	assert(controllerClass ~= nil, "controllerClass cannot be nil.")

	local viewObj
	local controllerObj
	local fullView = "view." .. viewClass
	local fullCtrl = "controller." .. controllerClass

	viewObj = require(fullView)
	controllerObj = require(fullCtrl)

	-- if pcall(require, fullView) then
	-- 	viewObj = require(fullView)
	-- else
	-- 	error(fullView .. " not found")
	-- end

	-- if pcall(require, fullCtrl) then
	-- 	controllerObj = require(fullCtrl)
	-- else
	-- 	error(fullCtrl .. " not found")
	-- end

	local ctrlInstance = controllerObj:New(viewObj:New())
	self.controllers[controllerClass] = ctrlInstance

	local register = function()
		ctrlInstance:onRegister()
	end
	pcall(register)
	
	return true
end

function Context:unmapController(controllerClass)
	assert(controllerClass ~= nil, "controllerClass cannot be nil.")
	self.controllers[controllerClass] = nil
	
	return true
end

function Context:Dispatch(eventObj)
	Notifier:Dispatch(eventObj)
end

function Context:Initialize()
	-- local uitl = require "kodelua.util"
	-- uitl.Dump(self.controllers)
	-- local i
	-- local ctrl
	-- for i=1, num do
	-- 	ctrl = self.controllers[i]
	-- 	pcall(ctrl:onRegister)
	-- end
end

return Context
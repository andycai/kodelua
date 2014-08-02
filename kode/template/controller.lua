if kode == nil then return end

local {{name}}Controller = BaseController:extend{
	name = "{{name}}Controller{{time}}";
}
local meta = {{name}}Controller

function meta:onRegister()
	-- body
end

-- private action method

function meta:action_module_get_something_(notification)
	-- body
end

return meta
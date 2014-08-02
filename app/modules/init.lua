if kode == nil then return end

local modules_init_ = {
	"role",
	nil,
}

local facade_ = kode.facade

for i, v in ipairs(modules_init_) do
	if v then
		facade_:registerModule(v)
	end
end

--[[
Usage:
local roleModel = _m("role") 					-- "app.modules.role.role_m"
local talentModel = _m("role", "talent") 		-- "app.modules.role.talent_m"
--]]
function loadModel(module, model)
	return facade_:loadModel(module, model)
end
_m = loadModel

--[[
Usage:
local roleService = _s("role") 					-- "app.modules.role.role_s"
local talentService = _s("role", "talent") 		-- "app.modules.role.talent_s"
--]]
function loadService(module, service)
	return facade_:loadService(module, service)
end
_s = loadService

--[[
Usage:
local rolePane = loadView("role") 				-- "app.modules.role.view.rolepane"
local talentPane = loadView("role", "talent") 	-- "app.modules.role.view.talentpane"
--]]
function _v(module, view)
	return facade_:loadView(module,view)
end
_v = loadView

--[[
Usage:
local roleVo = _vo("role") 						-- "app.modules.role.role_vo"
local talentVo = _vo("role", "talent") 			-- "app.modules.role.talent_vo"
--]]
function loadvo(module, vo)
	return facade_:loadvo(module, vo)
end
_vo = loadvo

_G.BaseController = facade_:loadController("base")
_G.BaseModel = facade_:loadModel("base")
_G.BaseService = facade_:loadService("base")
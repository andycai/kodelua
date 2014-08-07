if kode == nil then return end

local modules_init_ = {
	"role",
	nil,
}

-- moduleName = {skippedModel, skippedService}
local skip_ = {
	test = {true}
}

local facade_ = kode.facade
facade_:skip(skip_)
facade_:registerModules(modules_init_)

-- Event.checkEvents()

--[[
Usage:
local roleModel = app.m("role") 					-- "app.modules.role.role_m"
local talentModel = app.m("role", "talent") 		-- "app.modules.role.talent_m"
--]]
function loadModel(module, model)
	return facade_:loadModel(module, model)
end
r_m = loadModel

--[[
Usage:
local roleService = app.s("role") 					-- "app.modules.role.role_s"
local talentService = app.s("role", "talent") 		-- "app.modules.role.talent_s"
--]]
function loadService(module, service)
	return facade_:loadService(module, service)
end
r_s = loadService

--[[
Usage:
local rolePane = app.v("role") 				-- "app.modules.role.view.rolepane"
local talentPane = app.v("role", "talent") 	-- "app.modules.role.view.talentpane"
--]]
function loadView(module, view)
	return facade_:loadView(module,view)
end
r_v = loadView

--[[
Usage:
local roleVo = app.vo("role") 						-- "app.modules.role.role_vo"
local talentVo = app.vo("role", "talent") 			-- "app.modules.role.talent_vo"
--]]
function loadvo(module, vo)
	return facade_:loadvo(module, vo)
end
r_vo = loadvo

_G.BaseController = facade_:loadController("base")
_G.BaseModel = facade_:loadModel("base")
_G.BaseService = facade_:loadService("base")
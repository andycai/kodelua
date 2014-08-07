if kode == nil then return end

local modules_init_ = {
	"farm",
	nil,
}

-- moduleName = {skippedModel, skippedService}
local skip_ = {
	farm = {true, true}
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
function app.m(module, model)
	return facade_:loadModel(module, model)
end

--[[
Usage:
local roleService = app.s("role") 					-- "app.modules.role.role_s"
local talentService = app.s("role", "talent") 		-- "app.modules.role.talent_s"
--]]
function app.s(module, service)
	return facade_:loadService(module, service)
end

--[[
Usage:
local rolePane = app.v("role") 				-- "app.modules.role.view.rolepane"
local talentPane = app.v("role", "talent") 	-- "app.modules.role.view.talentpane"
--]]
function app.v(module, view)
	return facade_:loadView(module,view)
end

--[[
Usage:
local roleVo = app.vo("role") 						-- "app.modules.role.role_vo"
local talentVo = app.vo("role", "talent") 			-- "app.modules.role.talent_vo"
--]]
function app.vo(module, vo)
	return facade_:loadvo(module, vo)
end

_G.BaseController = facade_:loadController("base")
_G.BaseModel = facade_:loadModel("base")
_G.BaseService = facade_:loadService("base")

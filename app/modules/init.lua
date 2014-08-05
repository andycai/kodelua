if kode == nil then return end

local modules_init_ = {
	"role",
	nil,
}

-- moduleName = {skippedModel, skippedService}
local skip_ = {
	maingame = {true}
}

local facade_ = kode.facade

for skip_key, skip_value in pairs(skip_) do
	if skip_value and type(skip_value) == "table" then
		facade_:skip(skip_key, skip_value)
	end
end

for _, v in ipairs(modules_init_) do
	if v then
		facade_:loadEvent(v)
	end
end

for _, v in ipairs(modules_init_) do
	if v then
		facade_:registerModule(v)
	end
end

-- Event.checkEvents()

--[[
Usage:
local roleModel = r_m("role") 					-- "app.modules.role.role_m"
local talentModel = r_m("role", "talent") 		-- "app.modules.role.talent_m"
--]]
function loadModel(module, model)
	return facade_:loadModel(module, model)
end
r_m = loadModel

--[[
Usage:
local roleService = r_s("role") 					-- "app.modules.role.role_s"
local talentService = r_s("role", "talent") 		-- "app.modules.role.talent_s"
--]]
function loadService(module, service)
	return facade_:loadService(module, service)
end
r_s = loadService

--[[
Usage:
local rolePane = r_v("role") 				-- "app.modules.role.view.rolepane"
local talentPane = r_v("role", "talent") 	-- "app.modules.role.view.talentpane"
--]]
function loadView(module, view)
	return facade_:loadView(module,view)
end
r_v = loadView

--[[
Usage:
local roleVo = r_vo("role") 						-- "app.modules.role.role_vo"
local talentVo = r_vo("role", "talent") 			-- "app.modules.role.talent_vo"
--]]
function loadvo(module, vo)
	return facade_:loadvo(module, vo)
end
r_vo = loadvo

_G.BaseController = facade_:loadController("base")
_G.BaseModel = facade_:loadModel("base")
_G.BaseService = facade_:loadService("base")
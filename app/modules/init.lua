if kode == nil then return end

local modules_init_ = {
	"bag"
}

local modules_required_ = {
	nil,
}

local facade_ = kode.facade

BaseController = facade_:loadController("base")
BaseModel = facade_:loadModel("base")
BaseService = facade_:loadService("base")

local format = string.format
local vos_ = {}
local models_ = {}
local services_ = {}
local views_ = {}
local modules_ = {}

function initModule()
	for i, v in ipairs(modules_init_) do
		if v then
			facade_:load(v)
		end
	end

	for i, v in ipairs(modules_required_) do
		if v then
			facade_:load(v)
		end
	end
end

function loadModule(module)
	local obj_ = modules_[module]
	if obj_ == nil then
		facade_:load(module)
		modules_[module] = 1
	end
end

--[[
Usage:
local roleModel = loadModel("role") -- "app.modules.role.role_m"
local talentModel = loadModel("role", "talent") -- "app.modules.role.talent_m"
--]]
function loadModel(module, model)
	local obj_ = models_[module]
	if obj_ == nil then
		obj_ = facade_:loadModel(module, model)
		models_[module] = obj_
	end
	return obj_
end

--[[
Usage:
local roleService = loadService("role") -- "app.modules.role.role_s"
local talentService = loadService("role", "talent") -- "app.modules.role.talent_s"
--]]
function loadService(module, service)
	local obj_ = services_[module]
	if obj_ == nil then
		obj_ = facade_:loadService(module, service)
		services_[module] = obj_
	end
	return obj_
end

--[[
Usage:
local rolePane = loadViewPane("role") -- "app.modules.role.view.rolepane"
local talentPane = loadViewPane("role", "talent") -- "app.modules.role.view.talentpane"
--]]
function loadView(module, view)
	local obj_ = views_[module]
	if obj_ == nil then
		obj_ = facade_:loadView(module,view)
		views_[module] = obj_
	end
	return obj_
end

--[[
Usage:
local roleVo = loadvo("role") -- "app.modules.role.role_vo"
local talentVo = loadvo("role", "talent") -- "app.modules.role.talent_vo"
--]]
function loadvo(module, vo)
	local obj_ = vos_[module]
	if obj_ == nil then
		obj_ = facade_:loadvo(module, vo)
		vos_[module] = obj_
	end
	return obj_
end

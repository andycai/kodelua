local roleService = BaseService:extend()
local meta = roleService

function meta:reqRoleLogin()
	--
end
function meta:onRoleLogin(param)
	roleModel.Token = ""
end

function meta:reqOnline()
	self.action = "role.online"
	self.param.token = roleModel.Token
	self:request()
end
function meta:onOnline(param)
	-- body
end

function meta:reqRoleCreate()
	--
end

return meta
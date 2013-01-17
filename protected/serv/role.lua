local roleService = KService:Extend()

function roleService:reqRoleLogin()
	--
end
function roleService:onRoleLogin(param)
	roleModel.Token = ""
end

function roleService:reqOnline()
	self.action = "role.online"
	self.param.token = roleModel.Token
	self:Request()
end
function roleService:onOnline(param)
	-- body
end

function roleService:reqRoleCreate()
	--
end

return roleService
local maingamescneneService = BaseService:extend()
local meta = maingamescneneService

function meta:reqRoleLogin()
	--
end
function meta:onRoleLogin(param)
	roleModel.Token = ""
end

function meta:onMessageGet()
	self:notify(roleModel.EVENT_BAG_GET, {1, 3, 5}, "common notice")
end


return meta
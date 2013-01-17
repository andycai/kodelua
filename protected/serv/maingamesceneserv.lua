local maingamescneneService = KService:Extend()

function roleService:reqRoleLogin()
	--
end
function maingamescneneService:onRoleLogin(param)
	roleModel.Token = ""
end

function maingamescneneService:onMessageGet()
	self:Notify( roleModel.EVENT_BAG_GET, {1, 3, 5}, "common notice")
end


return maingamescneneService
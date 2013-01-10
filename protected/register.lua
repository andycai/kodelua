local appFacade = require "appfacade"

local controllers = {
	{ctrl=require "ctrl.role"; view=require "view.role.rolepane"};
	{ctrl=require "ctrl.bag"; view=require "view.bag.bagpane"};
}

for i,v in ipairs(controllers) do
	appFacade:Register(v.ctrl, v.view)
	-- appFacade:RemoveController(v.ctrl.name)
end
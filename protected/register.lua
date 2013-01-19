local appFacade = require "appfacade"

local controllers = {
	{ctrl=require "ctrl.role"; view=require "view.role.rolepane"};
	{ctrl=require "ctrl.bag"; view=require "view.bag.bagpane"};
	{ctrl=require "ctrl.maingame";view=require "view.maingame.maingame"};
}

for i,v in ipairs(controllers) do
	appFacade:register(v.ctrl, v.view)
	-- appFacade:RemoveController(v.ctrl.name)
end
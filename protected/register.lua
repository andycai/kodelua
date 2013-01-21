if kode == nil then return end

local appFacade = require "appfacade"

local controllers = {
	{ctrl=require "controller.role"; view=require "view.role.rolepane"};
	{ctrl=require "controller.bag"; view=require "view.bag.bagpane"};
	{ctrl=require "controller.maingame";view=require "view.maingame.maingame"};
}

for i,v in ipairs(controllers) do
	appFacade:register(v.ctrl, v.view)
	-- appFacade:RemoveController(v.ctrl.name)
end
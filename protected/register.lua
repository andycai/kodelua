-- local Context = require "kodelua.mvcs.context"
-- local bagCtrl = require "controllers.bagcontroller"
-- Context:mapController("bag.bagpane", "bagcontroller")

local appFacade = require "appfacade"

local bagCtrl = require "ctrl.bag"
local bagPane = require "view.bag.bagpane"
appFacade:Register(bagCtrl, bagPane)
-- appFacade:RemoveController(bagCtrl.name)
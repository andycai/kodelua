if kode == nil then return end

if kode.getglobal("RequestServer") == nil then
    function RequestServer( ... )
        -- nothing to do
    end
end

kode.appendPkgPath("./thirdparty/quick-cocos2d-x/")
-- require "lang.zh"
require("util.resconfig")   
require("util.global")
-- require("framework.init")
-- require("framework.client.init")

-- some interfaces for application
BaseController = require "controller.base"
BaseService = require "service.base"
BaseModel = require "model.base"

roleModel = require "model.role"
roleService = require "service.role"
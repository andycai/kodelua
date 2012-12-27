local BaseModel = require "model.base"
local bagmodel = BaseModel:Extend{
	EVENT_BAG_GET = "EVENT_BAG_GET";
	EVENT_BAG_TIDY = "EVENT_BAG_TIDY"
}

return bagmodel
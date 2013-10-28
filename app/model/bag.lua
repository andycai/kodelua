local Event = require "app.config.events"

local bagmodel = BaseModel:extend{
}
local meta = bagmodel

Event.EVENT_BAG_GET = "EVENT_BAG_GET";
Event.EVENT_BAG_TIDY = "EVENT_BAG_TIDY"

function meta:getBagData()
    -- body
end
function meta:setBagData(param)
    -- body
end

return meta
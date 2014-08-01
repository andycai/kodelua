local bagmodel = BaseModel:extend{
}
local meta = bagmodel

Event.EVENT_BAG_GET_SIZE = "bag_get_size";

local size_ = 16

function meta:getBagSize()
    return size_
end
function meta:setBagSize(v)
    size_ = v
end

return meta
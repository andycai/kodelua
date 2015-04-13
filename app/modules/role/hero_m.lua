if kode == nil then return end

local roleModel = BaseModel:extend()
local meta = roleModel

local size_ = 16

function meta:getBagSize()
    return size_
end
function meta:setBagSize(v)
    size_ = v
end

return meta
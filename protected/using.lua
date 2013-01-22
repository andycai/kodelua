if kode == nil then return end

using.quick_cocos2d_x = nil

if using.quick_cocos2d_x ~= nil then
	kode.appendPkgPath("./thirdparty/quick-cocos2d-x/")
	require("framework.init")
	require("framework.client.init")
end
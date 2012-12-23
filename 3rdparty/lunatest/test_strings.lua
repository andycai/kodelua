local p = "E:/DropBox/Everbox/lua/coro/lunatest/"  
local m_package_path = package.path  
package.path = string.format("%s;%s?.lua;%s?/init.lua",  
    m_package_path, p, p) 

require "lunatest"

function test_fail()
end

lunatest.run()
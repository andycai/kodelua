if kode == nil then return end

-- C++(network) interface for lua 
if kode.getglobal("RequestServer") == nil then
    function RequestServer( ... )
        -- nothing to do
    end
end

-- public interface for C++
-- response: may be a json string or other you want
-- parse reponse and dispatch to real module
function Route(response)
	xpcall(function()
		if response then
			local resp = kode.json.decode(response)
			local act = string.explode(resp.act, ".")
			local service = kode.getglobal(act[1].."Service")
			local action = act[2]
			if service ~= nil then
				if service[action] then
					service[action](service, resp.param)
				else
					log4l.debug("need a function [%s] in service [%s]", action, act[1])
				end
			else
				log4l.debug("Wrong aciton: %s", response)
			end
		end
	end, __G__TRACKBACK__)
end

-- require "lang.zh"
require "app.config.init"
require "app.util.init"
require "app.using" 
require "app.export"
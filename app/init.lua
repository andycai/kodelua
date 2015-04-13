if kode == nil then return end

app = app or {}

require "app.lang.zh"
require "app.config.init"
require "app.modules.init"

ns = kode.namespace.app

function requestServer( ... )
	-- request to server
end

function route(response)
	xpcall(function()
		if response then
			local resp = kode.json.decode(response)
			local act = string.explode(resp.act, ".")
			local service = app.service(act[1])
			local action = act[2]
			if service ~= nil then
				if service[action] then
					service[action](service, resp.param)
				else
					print(string.format("need a function [%s] in service [%s]", action, act[1]))
				end
			else
				print(string.format("Wrong aciton: %s", response))
			end
		end
	end, __G__TRACKBACK__)
end

kode.facade:send(Event.EVENT_APP_START, {action="startup"})
require "lang.zh"

if Getglobal("RequestServer") == nil then
	function RequestServer( ... )
		--
	end
end

KService = require "serv.base"
KModel = require "model.base"

roleModel = require "model.role"
roleService = require "serv.role"

bagService = require "serv.bag"

gameMessageService = require "serv.gamemessage"
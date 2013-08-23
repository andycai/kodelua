local gameMsgService = BaseService:extend()
local meta = gameMsgService

function meta:onForceError(param)
	if param ~= nil and param.message ~= nil then
		log4l.debug("GameMessage.onForceError:%s", param.message)
	end
end

function meta:onError(param)
	if param ~= nil and param.message ~= nil then
		log4l.debug("GameMessage.onError:%s", param.message)
	end
end

function meta:onMessage(param)
	if param ~= nil and param.message ~= nil then
		log4l.debug("GameMessage.onMessage:%s", param.message)
	end
end

function meta:onUpdateServer(param)
	if param ~= nil and param.message ~= nil then
		log4l.debug("GameMessage.onUpdateServer:%s", param.message)
	end
end

function meta:onError(param)
	if param ~= nil and param.message ~= nil then
		log4l.debug("GameMessage.onNoticeUpdatingServer:%s", param.message)
	end
end

function meta:onServerForum(param)
	if param ~= nil and param.message ~= nil then
		log4l.debug("GameMessage.onServerForum:%s", param.message)
	end
end

return meta
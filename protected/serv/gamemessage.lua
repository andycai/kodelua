local gameMsgService = KService:Extend()

function gameMsgService:onForceError(param)
	if param ~= nil and param.message ~= nil then
		log4j.Debug("GameMessage.onForceError:%s", param.message)
	end
end

function gameMsgService:onError(param)
	if param ~= nil and param.message ~= nil then
		log4j.Debug("GameMessage.onError:%s", param.message)
	end
end

function gameMsgService:onMessage(param)
	if param ~= nil and param.message ~= nil then
		log4j.Debug("GameMessage.onMessage:%s", param.message)
	end
end

function gameMsgService:onUpdateServer(param)
	if param ~= nil and param.message ~= nil then
		log4j.Debug("GameMessage.onUpdateServer:%s", param.message)
	end
end

function gameMsgService:onError(param)
	if param ~= nil and param.message ~= nil then
		log4j.Debug("GameMessage.onNoticeUpdatingServer:%s", param.message)
	end
end

function gameMsgService:onServerForum(param)
	if param ~= nil and param.message ~= nil then
		log4j.Debug("GameMessage.onServerForum:%s", param.message)
	end
end

return gameMsgService
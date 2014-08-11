if kode == nil then return end

local farmController = BaseController:extend{
	name = "farmController2014-08-05";
}
local meta = farmController

function meta:onRegister()
	-- body
end

-- handing touch events
local touchBeginPoint = nil
local function onTouchBegan(touch, event)
	local location = touch:getLocation()
	cclog("onTouchBegan: %0.2f, %0.2f", location.x, location.y)
	touchBeginPoint = {x = location.x, y = location.y}
	meta:getView():getDog().isPaused = true
	-- CCTOUCHBEGAN event must return true
	return true
end

local function onTouchMoved(touch, event)
	local location = touch:getLocation()
	cclog("onTouchMoved: %0.2f, %0.2f", location.x, location.y)
	if touchBeginPoint then
		local cx, cy = meta:getView():getPane():getPosition()
		meta:getView():getPane():setPosition(cx + location.x - touchBeginPoint.x,
							  cy + location.y - touchBeginPoint.y)
		touchBeginPoint = {x = location.x, y = location.y}
	end
end

local function onTouchEnded(touch, event)
	local location = touch:getLocation()
	cclog("onTouchEnded: %0.2f, %0.2f", location.x, location.y)
	touchBeginPoint = nil
	meta:getView():getDog().isPaused = false
end

local function onNodeEvent(event)
   if "exit" == event then
	   cc.Director:getInstance():getScheduler():unscheduleScriptEntry(app.schedulerID)
   end
end

-- private action method

function meta:action_app_start_(notification)
	app.schedulerID = 0

	-- play background music, preload effect
	local bgMusicPath = cc.FileUtils:getInstance():fullPathForFilename("background.mp3") 
	cc.SimpleAudioEngine:getInstance():playMusic(bgMusicPath, true)
	local effectPath = cc.FileUtils:getInstance():fullPathForFilename("effect1.wav")
	cc.SimpleAudioEngine:getInstance():preloadEffect(effectPath)

	-- run
	local sceneGame = cc.Scene:create()
	local FarmView = self:getView()
	FarmView:init()

	local farmPane = FarmView:getPane()
	local Class_FrameMenu = app.view("farm", "menu")

	sceneGame:addChild(farmPane)
	sceneGame:addChild(Class_FrameMenu:new())
	
	if cc.Director:getInstance():getRunningScene() then
		cc.Director:getInstance():replaceScene(sceneGame)
	else
		cc.Director:getInstance():runWithScene(sceneGame)
	end

	local listener = cc.EventListenerTouchOneByOne:create()
	listener:registerScriptHandler(onTouchBegan,cc.Handler.EVENT_TOUCH_BEGAN )
	listener:registerScriptHandler(onTouchMoved,cc.Handler.EVENT_TOUCH_MOVED )
	listener:registerScriptHandler(onTouchEnded,cc.Handler.EVENT_TOUCH_ENDED )
	local eventDispatcher = farmPane:getEventDispatcher()
	eventDispatcher:addEventListenerWithSceneGraphPriority(listener, farmPane)

	farmPane:registerScriptHandler(onNodeEvent)
end

return meta

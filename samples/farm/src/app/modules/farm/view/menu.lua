if kode == nil then return end

local menu_ = {}

function menu_:new()
	local visibleSize = cc.Director:getInstance():getVisibleSize()
    local origin = cc.Director:getInstance():getVisibleOrigin()
    
	local layerMenu = cc.Layer:create()

	local menuPopup, menuTools, effectID

	local function menuCallbackClosePopup()
		-- stop test sound effect
		cc.SimpleAudioEngine:getInstance():stopEffect(effectID)
		menuPopup:setVisible(false)
	end

	local function menuCallbackOpenPopup()
		-- loop test sound effect
		local effectPath = cc.FileUtils:getInstance():fullPathForFilename("effect1.wav")
		effectID = cc.SimpleAudioEngine:getInstance():playEffect(effectPath)
		menuPopup:setVisible(true)
	end

	-- add a popup menu
	local menuPopupItem = cc.MenuItemImage:create("menu2.png", "menu2.png")
	menuPopupItem:setPosition(0, 0)
	menuPopupItem:registerScriptTapHandler(menuCallbackClosePopup)
	menuPopup = cc.Menu:create(menuPopupItem)
	menuPopup:setPosition(origin.x + visibleSize.width / 2, origin.y + visibleSize.height / 2)
	menuPopup:setVisible(false)
	layerMenu:addChild(menuPopup)
	
	-- add the left-bottom "tools" menu to invoke menuPopup
	local menuToolsItem = cc.MenuItemImage:create("menu1.png", "menu1.png")
	menuToolsItem:setPosition(0, 0)
	menuToolsItem:registerScriptTapHandler(menuCallbackOpenPopup)
	menuTools = cc.Menu:create(menuToolsItem)
	local itemWidth = menuToolsItem:getContentSize().width
	local itemHeight = menuToolsItem:getContentSize().height
	menuTools:setPosition(origin.x + itemWidth/2, origin.y + itemHeight/2)
	layerMenu:addChild(menuTools)

	return layerMenu
end

return menu_
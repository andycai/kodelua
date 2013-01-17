local luahelper={}
function luahelper.newMenuItemImage(params)
    local imageNormal   = params.image
    local imageSelected = params.imageSelected
    local imageDisabled = params.imageDisabled
    local listener      = params.listener
    local tag           = params.tag
    local x             = params.x
    local y             = params.y

    if type(imageNormal) == "string" then
        imageNormal = CCSprite:createWithSpriteFrameName(imageNormal)
    end
    if type(imageSelected) == "string" then
        imageSelected = CCSprite:createWithSpriteFrameName(imageSelected)
    end
    if type(imageDisabled) == "string" then
        imageDisabled = CCSprite:createWithSpriteFrameName(imageDisabled)
    end

    local item = CCMenuItemSprite:create(imageNormal, imageSelected, imageDisabled)
    if item then
        display.extendSprite(item)
        if type(listener) == "function" then item:registerScriptTapHandler(listener) end
        if x and y then item:setPosition(x, y) end
        if tag then item:setTag(tag) end
    end

    return item
end
function luahelper.moveTo(target, args)
	
   -- assert(not tolua.isnull(target), "transition.moveTo() - target is not CCNode")
	--print(target:getPosition())
    local tx, ty = target:getPosition()
		
    local x = args.x or tx
    local y = args.y or ty
    local action = CCMoveTo:create(args.time, ccp(x, y))

    return transition.execute(target, action, args)
end
return luahelper
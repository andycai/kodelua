--******************************窗口暂时如下*****************
--使用win=winFrame.new("windown",0,0,500,500,lis)
--				uilayout:addChild(win)
--@parm1:tile的名字
--@parm2:x坐标
--@parm3:y坐标
--@parm4:窗口的width
--@parm5:窗口的height
local winFrame={}

function winFrame.new(title,x,y,width,height)
	local isvisble=true
	local winLayer=display.newLayer()
	winLayer:setPosition(x, y)
	local win= CCScale9Sprite:createWithSpriteFrameName("winframe.png")
	win:setAnchorPoint(ccp(0.5,0.5))
	win:setContentSize(CCSizeMake(width, height))
	win:setPosition(0,0)
	winLayer:addChild(win)
		
	local winTitle=CCScale9Sprite:create(GetUIPath(s_base_winFrameTitle),CCRectMake(0,0,0,0))
	winTitle:setAnchorPoint(ccp(0.5,0.5))
	winTitle:setContentSize(CCSizeMake(width, height/8))
	winTitle:setPosition(0,height/2-height/16)
	winLayer:addChild(winTitle)
	
	
	local wintitle=CCLabelTTF:create(title, "Marker Felt", 30)
	wintitle:setPosition(0,height/2.4)
	winLayer:addChild(wintitle)
	local function winclose()
		winLayer:removeFromParentAndCleanup (true)
	end	
	local wincloseBtn=ui.newMenuItemImage({
	image=GetUIPath(s_base_winFrameClose),
	imageSelected=GetUIPath(s_base_winCloseChoose),
	listener=winclose,
	x=width/2,
	y=height/2,
	})
	
	local closemenu= ui.newMenu({wincloseBtn})
	winLayer:addChild(closemenu)
	
	return winLayer
	
end

--[[function winFrame.winnew(title,x,y,width,height)
	local CCLayer winLayer
	if(winLayer==nil) then 
		return winFrame.new(title,x,y,width,height)
	else
		winLayer:setVisible(true)
		return winLayer
	end
end--]]
return winFrame
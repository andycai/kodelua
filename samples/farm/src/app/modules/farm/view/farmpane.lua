if kode == nil then return end

local farmPane = {}

local layerFarm, spriteDog

function farmPane:init()
	local visibleSize = cc.Director:getInstance():getVisibleSize()
	local origin = cc.Director:getInstance():getVisibleOrigin()
	
	layerFarm = cc.Layer:create()

	-- add in farm background
	local bg = cc.Sprite:create("farm.jpg")
	bg:setPosition(origin.x + visibleSize.width / 2 + 80, origin.y + visibleSize.height / 2)
	layerFarm:addChild(bg)

	-- add land sprite
	for i = 0, 3 do
		for j = 0, 1 do
			local spriteLand = cc.Sprite:create("land.png")
			spriteLand:setPosition(200 + j * 180 - i % 2 * 90, 10 + i * 95 / 2)
			layerFarm:addChild(spriteLand)
		end
	end

	-- add crop
	local frameCrop = cc.SpriteFrame:create("crop.png", cc.rect(0, 0, 105, 95))
	for i = 0, 3 do
		for j = 0, 1 do
			local spriteCrop = cc.Sprite:createWithSpriteFrame(frameCrop);
			spriteCrop:setPosition(10 + 200 + j * 180 - i % 2 * 90, 30 + 10 + i * 95 / 2)
			layerFarm:addChild(spriteCrop)
		end
	end

	-- add moving dog
	local Class_Dog = r_v("farm", "dog")
	spriteDog = Class_Dog:new()
	layerFarm:addChild(spriteDog)

	return layerFarm
end

function farmPane:getPane()
	return layerFarm
end

function farmPane:getDog()
	return spriteDog
end

return farmPane

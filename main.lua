import "CoreLibs/object"
import "CoreLibs/graphics"
import "CoreLibs/sprites"
import "CoreLibs/animation"
import "CoreLibs/timer"

-- Globals
local gfx <const> = playdate.graphics
local startSpriteBlinker = nil
local startSprite = nil
introDrawableLocations = {}

function createIntroScreenItem()
	local x = 400 + math.random(50)
	local y = math.random(240) - 1
	local width = 100 + math.random(50)
	local height = 30 + math.random(30)
	local speed = 3 + math.random(20)

	return { x = x, y = y, width = width, height = height, speed = speed }
end

-- Init
function gameInit()
	-- load images
	local logoImage = gfx.image.new("resources/logo")
	assert(logoImage)
	local logoSprite = gfx.sprite.new(logoImage)
	logoSprite:moveTo(112, 185)
	logoSprite:add()
	
	local startImage = gfx.image.new("resources/start")
	assert(startImage)
	
	startSprite = gfx.sprite.new(startImage)
	startSprite:moveTo(330, 40)
	startSprite:add()
	
	startSpriteBlinker = playdate.graphics.animation.blinker.new()
	startSpriteBlinker:start(500, 500, true)
	
	gfx.setBackgroundColor(gfx.kColorWhite)

	for i = 1, 35 do
		introDrawableLocations[i] = createIntroScreenItem()
	end

	gfx.sprite.setBackgroundDrawingCallback(
		function()

			local bgImage = gfx.image.new(400, 240)
			gfx.pushContext(bgImage)

			for i,loc in ipairs(introDrawableLocations) do
				gfx.fillRect(loc.x, loc.y, loc.width, loc.height)
			end
			
			gfx.fillRect(280, 20, 100, 40)

			gfx.popContext()
			bgImage:draw( 0, 0 )
		end
	)
end

gameInit()

-- Update
function playdate.update()
	introScreenUpdate()
	introScreenDraw()
end

function introScreenUpdate()
	for i,loc in ipairs(introDrawableLocations) do
		loc.x -= loc.speed

		if loc.x + loc.width < 0 then
			introDrawableLocations[i] = createIntroScreenItem()
		end
	end
	
	if startSprite ~= nil then
		startSprite:setVisible(startSpriteBlinker.on)
	end
	
	playdate.graphics.animation.blinker.updateAll()
end

function introScreenDraw()
	gfx.clear()
	gfx.sprite.update()
end
import "CoreLibs/object"
import "CoreLibs/graphics"
import "CoreLibs/sprites"
import "CoreLibs/timer"

-- Globals
local gfx <const> = playdate.graphics
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
	gfx.setBackgroundColor(gfx.kColorWhite)
	
	for i = 1, 30 do
		introDrawableLocations[i] = createIntroScreenItem()
	end
end

gameInit()

-- Updateg
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
end

function introScreenDraw()
	gfx.clear()
	
	for i,loc in ipairs(introDrawableLocations) do
	  gfx.fillRect(loc.x, loc.y, loc.width, loc.height)
	end
end
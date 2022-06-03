
import "game"

local game = Game()
local gfx <const> = playdate.graphics
local font = gfx.font.new('font/Mini Sans 2X') -- DEMO

local function loadGame()
	playdate.display.setRefreshRate(50) -- Sets framerate to 50 fps
	math.randomseed(playdate.getSecondsSinceEpoch()) -- seed for math.random
	gfx.setFont(font) -- DEMO
end


--loadGame()

function playdate.update()
	game:update()
	game:draw()
end

-- functions below control input for the machine
function playdate.cranked(change, acceleratedChange)
	--gt1_inst:cranked(change)

end

function playdate.leftButtonUp()

end

function playdate.leftButtonDown()

end

function playdate.rightButtonUp()

end

function playdate.rightButtonDown()

end
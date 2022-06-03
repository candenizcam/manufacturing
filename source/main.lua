import "dvd" -- DEMO
import "game_test_1"
local dvd = dvd(1, -1) -- DEMO
local gt1_inst = gt1()
local gfx <const> = playdate.graphics
local font = gfx.font.new('font/Mini Sans 2X') -- DEMO

local function loadGame()
	playdate.display.setRefreshRate(50) -- Sets framerate to 50 fps
	math.randomseed(playdate.getSecondsSinceEpoch()) -- seed for math.random
	gfx.setFont(font) -- DEMO
end

local function updateGame()
	--dvd:update() -- DEMO
	gt1_inst:update()
end

local function drawGame()
	gfx.clear() -- Clears the screen
	gt1_inst:draw() -- DEMO
end

loadGame()

function playdate.update()
	updateGame()
	drawGame()

	playdate.drawFPS(0,0) -- FPS widget
	if(gt1_inst.gameOver) then
		gt1_inst =  gt1()
	end
end

function playdate.cranked(change, acceleratedChange)
	gt1_inst:cranked(change)

end

function playdate.leftButtonUp()

end

function playdate.leftButtonDown()

end

function playdate.rightButtonUp()

end

function playdate.rightButtonDown()

end
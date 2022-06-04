
import "game"
import "geometry"
import "levels"

game = Game()
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
	playdate.drawFPS(0,0) -- FPS widget
end

-- functions below control input for the machine
function playdate.cranked(change, acceleratedChange)
	--gt1_inst:cranked(change)
	game:move_tool_y(change)

end

function playdate.leftButtonUp()

end

function playdate.leftButtonDown()
	--game:move_tool_x(1)
end

function playdate.rightButtonUp()

end

function playdate.rightButtonDown()
	--game:move_tool_x(-1)
end

function playdate.BButtonDown()
	game.blueprint_visible = not game.blueprint_visible
end

function playdate.AButtonDown()
	game.tool:swap_tool()
end
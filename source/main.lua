
import "game"
import "geometry"
import "levels"
import "level_select"
game = Game()
--level_select = LevelSelect(24)
appState = 1 -- 0 opening, 1 game, 2 howto, 3 levels
local gfx <const> = playdate.graphics
local font = gfx.font.new('font/Mini Sans 2X') -- DEMO



local function loadGame()
	playdate.display.setRefreshRate(30) -- Sets framerate to 50 fps
	--math.randomseed(playdate.getSecondsSinceEpoch()) -- seed for math.random
	gfx.setFont(font) -- DEMO
	game:load_state()

	local menu = playdate.getSystemMenu()
	menu:addMenuItem("Restart Game", function()
		game:restart()
	end)
	menu:addMenuItem("Game Levels",function()
		-- to game levels
	end

	)
end


loadGame()

function playdate.update()
	playdate.graphics.clear()
	if appState==0 then
		playdate.graphics.setColor(playdate.graphics.kColorWhite)
		game.howto_visual:draw(0,0)
	elseif appState==1 then
		game:update()

		game:draw()
	elseif appState == 3 then
		--level_select:draw()
	end

	playdate.drawFPS(0,0) -- FPS widget
end

-- functions below control input for the machine
function playdate.cranked(change, acceleratedChange)
	--gt1_inst:cranked(change)
	game:move_tool_y(change)

	--level_select:move_drum(change)
end

function playdate.leftButtonUp()
end

function playdate.upButtonDown()
	--level_select:selector_up()
end

function playdate.downButtonDown()
	--level_select:selector_down()
end

function playdate.leftButtonDown()
	--level_select:selector_left()
	--game:move_tool_x(1)
end

function playdate.rightButtonUp()

end

function playdate.rightButtonDown()
	--level_select:selector_right()
	--game:move_tool_x(-1)
end

function playdate.BButtonDown()
	game.blueprint_visible = not game.blueprint_visible
end

function playdate.AButtonDown()
	game.tool:swap_tool()
end


function playdate.gameWillTerminate()
	print("terminate")
	game:save_state()
end

function  playdate.deviceWillSleep()
	print("sleep")
	game:save_state()
end
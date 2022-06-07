
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
	--playdate.datastore.write( properties, "other_data" )
	--local  m = playdate.datastore.read( "other_data555")
	--print("m:"..tostring(m==nil))
	local m = playdate.datastore.read( "other_data")
	if m~=nil then
		if m.active_level ~= nil then
			properties.active_level = m.active_level
		end
		if m.total_level ~= nil then
			properties.total_level = m.total_level
		end
		if m.sound_options ~= nil then
			properties.sound_options = m.sound_options
		end

	end
	game:load_state()

	local menu = playdate.getSystemMenu()
	menu:addMenuItem("Level Options", function()
		game:hammer_time()
	end)
	menu:addMenuItem("Roll the Lathe",function()
		--game:reset_progress()
		game:lets_roll()
	end)

	menu:addOptionsMenuItem("Sound:", {"music+sfx","music","sfx"}, properties.sound_options,
			function (x)
				if x=="music+sfx" then
					properties.sound_options = 1
					tornado_sample:play(0)
				elseif x=="music" then
					tornado_sample:play(0)
					properties.sound_options = 2
					silence_effects()
				else
					properties.sound_options = 3
					tornado_sample:stop()
				end

				playdate.datastore.write( properties, "other_data" )
			end
	)

	if properties.sound_options ~= 3 then
		tornado_sample:play(0)
	end

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
	game.end_level_scene = false
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
	if game.end_level_scene then -- next
		local wat = game.wheels_are_turning
		game:next_level(true)
		game.end_level_scene = false
		if wat then
			game:lets_roll()
		end

	else
		game.blueprint_visible = not game.blueprint_visible
		if game.blueprint_visible then
			if properties.sound_options~= 2 then
				paper_sample:play()
			end

		end
	end


end

function playdate.AButtonDown()
	if game.end_level_scene then -- restart
		local wat = game.wheels_are_turning
		game:restart()
		game.end_level_scene = false
		if wat then
			game:lets_roll()
		end
	else
		game.tool:swap_tool()
	end


end


function playdate.gameWillTerminate()
	game:save_state()
	playdate.datastore.write( properties, "other_data" )

end

function  playdate.deviceWillSleep()
	game:save_state()
	playdate.datastore.write( properties, "other_data" )
end

function playdate.crankDocked()
	game:hammer_time()
end

function playdate.crankUndocked()
	game:lets_roll()

end
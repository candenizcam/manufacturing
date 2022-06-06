---
--- Generated by EmmyLua(https://github.com/EmmyLua)
--- Created by dreadnought.
--- DateTime: 04/06/2022 13:19
---

tool_offset_x = 16
tool_offset_y = 0
game_area_width  = 320
horizontal_button_sensitivity = 1
vertical_button_sensitivity = 4
crank_vertical_sensitivity = 0.2
log_centre = 108
properties = {active_level = 1,total_level = 1, sound_options = 1}


--- sounds
drop_sample  = playdate.sound.sampleplayer.new("sounds/drop.wav")
end_sample  = playdate.sound.sampleplayer.new("sounds/End.wav") --  dock edildiiinde
running_sample  = playdate.sound.sampleplayer.new("sounds/Running.wav") -- docktan çıktığında
start_sample  = playdate.sound.sampleplayer.new("sounds/Start.wav") -- start sesi ile runmaya başliycak yukardai
tornado_sample  = playdate.sound.sampleplayer.new("sounds/Tornado.wav") -- tornado müzik
filing_sample = playdate.sound.sampleplayer.new("sounds/Filing.wav")
paper_sample = playdate.sound.sampleplayer.new("sounds/Paper.wav")

function silence_effects()
    drop_sample:stop()
    end_sample:stop()
    running_sample:stop()
    start_sample:stop()
    filing_sample:stop()
    paper_sample:stop()
end

--- visuals
chisels = playdate.graphics.image.new("image/knifes/chisels.png")
dark_bg = playdate.graphics.image.new("image/dark_bg2.png")

complete = playdate.graphics.image.new("image/complete.png")
incomplete = playdate.graphics.image.new("image/incomplete.png")
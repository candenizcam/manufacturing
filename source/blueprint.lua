---
--- Generated by EmmyLua(https://github.com/EmmyLua)
--- Created by dreadnought.
--- DateTime: 04/06/2022 18:43
---


import "CoreLibs/graphics"
import "CoreLibs/object"


class("Blueprint").extends()

function Blueprint:init(s)
    self.values  =s
    self.tool_offset = Point(tool_offset_x, tool_offset_y)

end


function Blueprint:draw()
    playdate.graphics.setColor(playdate.graphics.kColorXOR)
    for i  = 1,320 do
        if self.values[i]~=nil then
            playdate.graphics.drawLine(self.tool_offset.x + i,self.tool_offset.y + 120 + self.values[i],self.tool_offset.x + i,self.tool_offset.y + 120 - self.values[i])
        else
            break
        end


    end
end
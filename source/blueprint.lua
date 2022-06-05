---
--- Generated by EmmyLua(https://github.com/EmmyLua)
--- Created by dreadnought.
--- DateTime: 04/06/2022 18:43
---


import "CoreLibs/graphics"
import "CoreLibs/object"
import "global"

class("Blueprint").extends()

function Blueprint:init(s)
    self.values  =s
    self.tool_offset = Point(tool_offset_x, tool_offset_y)
    self.grid_visible = false

    self.outer_diff = 0
    self.inner_diff = 0
    for i = 1,320 do
        self.outer_diff = self.outer_diff + 100 - math.min(self.values[i] + 3, 100)
        --self.inner_diff = self.inner_diff + self.values[i] - 3
    end

end


function Blueprint:draw_low_half()
    playdate.graphics.setColor(playdate.graphics.kColorWhite)
    playdate.graphics.fillRect(self.tool_offset.x, self.tool_offset.y + log_centre, 350, 240)

    playdate.graphics.setColor(playdate.graphics.kColorBlack)


    for i  = 1,320 do
        if self.values[i]~=nil then
            if self.values[i]~= 0 then
                playdate.graphics.drawLine(self.tool_offset.x + i,self.tool_offset.y + log_centre + self.values[i],self.tool_offset.x + i,self.tool_offset.y + log_centre)
            end
        else
            break
        end


    end
end

function Blueprint:draw()
    playdate.graphics.setColor(playdate.graphics.kColorBlack)


    for i  = 1,320 do
        if self.values[i]~=nil then
            if self.values[i]~= 0 then
                playdate.graphics.drawLine(self.tool_offset.x + i,self.tool_offset.y + log_centre + self.values[i],self.tool_offset.x + i,self.tool_offset.y + log_centre - self.values[i])
            end

        else
            break
        end


    end

    if self.grid_visible then
        local grid_height = math.ceil(log_centre/10)*10
        for i = 0,10 do
            local y = log_centre + i*10
            playdate.graphics.drawLine(self.tool_offset.x-10 ,y,
                    self.tool_offset.x+330 ,y)
            y = log_centre - i*10
            playdate.graphics.drawLine(self.tool_offset.x-10 ,y,
                    self.tool_offset.x+330 ,y)

        end

        for i = -1,33 do
            playdate.graphics.drawLine(i*10+self.tool_offset.x ,log_centre +100,
                    i*10+self.tool_offset.x ,log_centre-100 )
        end

    end

end

function get_blueprint()
    if properties.total_level < 5 then
        local index = "l" .. tostring(properties.total_level)
        return Blueprint(levels[index])
    end

    local l = List()

    -- 19, 7
    for i= 1,100 do
        if l.size==4 then
            break
        end
        local v = math.random(1,26)
        if not l:contains(v) then
            if v>19 then
                l:append(v)
                break
            else
                l:append(v)
            end
        end

    end

    local l2 = l:map(
            function(x)
                local st = ""
                if x >19 then
                    st = "rnd_end" .. tostring(x-19)
                else
                    st = "rnd" .. tostring(x)
                end
                return levels[st]
            end
    )

    local l3 = List()
    l2:iterate(
            function(x)
                for i = 1,10000 do
                    local a = x[i]
                    if a==nil then
                        break
                    end
                    l3:append(a)
                end

            end
    )


    for i = l3.size,320 do
        l3:append(0)
    end

    l3:iterate(
            function(x) print(x)  end
    )

    return Blueprint(l3.vals)
end
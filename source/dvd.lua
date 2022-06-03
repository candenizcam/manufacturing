import "CoreLibs/graphics"
import "CoreLibs/object"

local gfx <const> = playdate.graphics

class("dvd").extends()

function dvd:init(xspeed, yspeed)
    self.label = {
		x = 155,
		y = 110,
		xspeed = xspeed,
		yspeed = yspeed,
		width = 140,
		height = 24
	}
end

function dvd:swapColors()
	if (gfx.getBackgroundColor() == gfx.kColorWhite) then
		gfx.setBackgroundColor(gfx.kColorBlack)
		gfx.setImageDrawMode("inverted")
	else
		gfx.setBackgroundColor(gfx.kColorWhite)
		gfx.setImageDrawMode("copy")
	end
end

function dvd:update()
    local label = self.label;
    local swap = false
	if (label.x + label.width >= 400 or label.x <= 0) then
        label.xspeed = -label.xspeed;
		swap = true
    end
        
    if (label.y + label.height >= 240 or label.y <= 0) then
        label.yspeed = -label.yspeed;
		swap = true
	end

	if (swap) then
		self:swapColors()
	end

	label.x = label.x + label.xspeed
	label.y = label.y + label.yspeed
end

function dvd:draw()
    local label = self.label;
	if (gfx.getBackgroundColor() == gfx.kColorWhite) then
		--gfx.setBackgroundColor(gfx.kColorBlack)
		gfx.setColor(playdate.graphics.kColorBlack)
		gfx.setImageDrawMode("inverted")
	else
		--gfx.setBackgroundColor(gfx.kColorWhite)
		gfx.setColor(playdate.graphics.kColorWhite)
		gfx.setImageDrawMode("copy")
	end

	--gfx.setColor(gfx.kColorBlack)
	gfx.fillRect(label.x, label.y, label.width, label.height)
	gfx.drawTextInRect("Tempo", label.x+2, label.y+2, label.width, label.height)

end
import "CoreLibs/graphics"
import "CoreLibs/object"
import "CoreLibs/sprites"
import "utility"
import "Enemy"
class("gt1").extends()
-- w: 400, h: 240

function gt1:init()
    playdate.graphics.setBackgroundColor(playdate.graphics.kColorWhite)
    self.char = {
        w = 60,
        h = 60,
        x = 40,
        y = 220-30,
        angle=0,
        fire = 0
	}
    self.counter = 0
    self.ammo = 10

    self.gravity = 80
    self.gameOver = false


    im, error  =playdate.graphics.image.new("images/tank_body_1.png")
    self.im_1 = im
    self.im_2 = playdate.graphics.image.new("images/tank_body_2.png")
    self.sprite_1 = playdate.graphics.sprite.new(self.im_1)
    self.sprite_1:add()
    --38, 46

    self.fly = Fly(300,100)


    self.bullets =self:generateBullets(10)



    self.cannonImages = {}
    for i = 1, 9 do
        self.cannonImages[i] = playdate.graphics.image.new("images/cannon_animation/tank_cannon_"..tostring(i)..".png")
    end
    self.cannon =playdate.graphics.sprite.new(self.cannonImages[1])
    --self.cannon:moveTo(62, 55)
    self.cannon:setRotation(0)
    self.cannon:add()

    --self.im = im:scaledImage(0.5)
end

function gt1:generateBullets(n)
    local bullets= {size=n}

    for i=1, bullets.size do
        local im = playdate.graphics.image.new(3,3 , playdate.graphics.kColorBlack)
        local sp = playdate.graphics.sprite.new(im)
        sp:add()
        sp:setVisible(false)
        bullets[i] = {x = 0, y = 0, vX = 0, vY = 0, sprite = sp, visible = false}
    end



    return bullets
end


function gt1:moveTank(x,y)
    self.sprite_1:moveTo(self.char.x, self.char.y)
    self.cannon:moveTo(self.char.x+14, self.char.y+5)
end

function gt1:addBullet(x,y,angle,speed)
    for i=1, self.bullets.size do
        if(not self.bullets[i].visible) then
            self.bullets[i].x = x+12
            self.bullets[i].y = y+5
            self.bullets[i].vX = math.cos(angle/360*2*3.141)*speed
            self.bullets[i].vY = math.sin(angle/360*2*3.141)*speed
            self.bullets[i].sprite:setVisible(true)
            self.bullets[i].visible = true
            return
        end
    end
end

function gt1:updateBullets()
    for i=1, self.bullets.size do
        if(self.bullets[i].visible) then
            local b = self.bullets[i]
            self.bullets[i].vY = b.vY + self.gravity/50
            self.bullets[i].x = b.x + b.vX/50
            self.bullets[i].y = b.y + self.bullets[i].vY/50
            self.bullets[i].sprite:moveTo(self.bullets[i].x ,self.bullets[i].y )
            if self.bullets[i].x>400 or self.bullets[i].x<0 or self.bullets[i].y>240 or self.bullets[i].y<0  then
                self.bullets[i].visible = false
                self.bullets[i].sprite:setVisible(false)
            end

            self:hitEnemies(self.bullets[i])

        end
    end
end

function gt1:hitEnemies(bullet)
    local flyHit = self.fly:hit(bullet.x,bullet.y)
    if flyHit then
        bullet.visible = false
        bullet.sprite:setVisible(false)
        self.fly:setVisible(false)
        self.ammo = self.ammo + 2
    end
end

function gt1:newEnemy()
    self.fly:enter()
end

function gt1:updateEnemies()
    self.fly:update()
end

function gt1:fireAnimation()
    if(self.char.fire <= 0) then
        return
    end

    if(self.char.fire == 20) then
        playdate.graphics.setBackgroundColor(playdate.graphics.kColorBlack)

    elseif self.char.fire <= 19 then
        playdate.graphics.setBackgroundColor(playdate.graphics.kColorWhite)
        local n =  math.floor(11-self.char.fire/2)
        if n==10 then n = 1 end
        self.cannon:setImage(self.cannonImages[n])
    end


    self.char.fire = self.char.fire - 1

end

function gt1:update()
    local rightDown = playdate.buttonIsPressed(playdate.kButtonRight)
    local leftDown = playdate.buttonIsPressed(playdate.kButtonLeft)
    local deltaX = 0
    if(rightDown)then
        deltaX = 1
    end
    if(leftDown) then
        deltaX = deltaX-1
    end

    self.char.x = self.char.x + horizontalButton()
    self:moveTank(self.char.x, self.char.y)

    local result_raw =  self.char.angle-verticalButton()*0.5
    self.char.angle = math.min(math.max(-60,result_raw),30)
    self.cannon:setRotation(self.char.angle)

    if(playdate.buttonJustPressed(playdate.kButtonB)) then
        if(self.char.fire<=0) then
            self.char.fire = 20
            self.ammo = self.ammo-1
            if self.ammo<=0 then
                self.gameOver = true
                playdate.graphics.sprite.removeAll()
            else
                self:addBullet(self.char.x,self.char.y,self.char.angle,200 )
            end

        end

    end
    self:updateEnemies()
    self:fireAnimation()
    self:updateBullets()
    if not self.fly:getVisible() then
        self:newEnemy()
    end


end

function gt1:draw()
    local char = self.char
    local im  =self.im

    playdate.graphics.sprite.update()

    playdate.graphics.setColor(playdate.graphics.kColorBlack)
    playdate.graphics.drawText("Ammo: "..tostring(self.ammo), 40, 10)
    --gfx.fillRect(a, b, char.w, char.h)
    --im:draw(0,0)
    --self.sprite_1:draw()
end

function gt1:cranked(change)
    local result_raw =  self.char.angle+change*0.05
    self.char.angle = math.min(math.max(-60,result_raw),30)
    self.cannon:setRotation(self.char.angle)
end





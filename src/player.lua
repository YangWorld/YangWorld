player = Class{
    init = function(self)
        self.x = mapImage:getWidth() / 2
        self.y = mapImage:getHeight() / 2
        self.image = love.graphics.newImage("assets/images/yang.png")
        self.g = anim8.newGrid(48, 57, self.image:getWidth(), self.image:getHeight())
        self.frameSpeed = 0.15
        self.frameSpeedIdle = 0.30
        self.anims = {
            down = anim8.newAnimation(self.g('1-4', 1), self.frameSpeed),
            up = anim8.newAnimation(self.g('1-4', 2), self.frameSpeed),
            left = anim8.newAnimation(self.g('1-4', 3), self.frameSpeed),
            right = anim8.newAnimation(self.g('1-4', 4), self.frameSpeed),
            down_idle = anim8.newAnimation(self.g('1-4', 1), self.frameSpeedIdle),
            up_idle = anim8.newAnimation(self.g('1-4', 2), self.frameSpeedIdle),
            left_idle = anim8.newAnimation(self.g('1-4', 3), self.frameSpeedIdle),
            right_idle = anim8.newAnimation(self.g('1-4', 4), self.frameSpeedIdle),
        }
        self:chanim('down_idle')
    end,
    xSpeed = 7,
    ySpeed = 7
}

function player:chanim(row)
    self.anim = self.anims[row]
end

function player:update(dt)
    local x, y = input:get 'move'
    self:move(x*player.xSpeed, y*player.ySpeed)

    if input:down 'up' then
        self:chanim('up')
    elseif input:down 'down' then
        self:chanim('down')
    elseif input:down 'left' then
        self:chanim('left')
    elseif input:down 'right' then
        self:chanim('right')
    elseif input:released 'up' then
        self:chanim('up_idle')
    elseif input:released 'down' then
        self:chanim('down_idle')
    elseif input:released 'left' then
        self:chanim('left_idle')
    elseif input:released 'right' then
        self:chanim('right_idle')
    end

    self.anim:update(dt)
end

function player:move(dx, dy)
    self.x = self.x + (dx or 0)
    self.y = self.y + (dy or 0)
    if dx < 0.0 and self.x - camera.x < love.graphics.getWidth() / 4 then
        camera.x = camera.x + (dx or 0)
    end
    if dx > 0.0 and (camera.x + love.graphics.getWidth()) - self.x < love.graphics.getWidth() / 4 then
        camera.x = camera.x + (dx or 0)
    end
    if dy < 0.0 and self.y - camera.y < love.graphics.getHeight() / 4 then
        camera.y = camera.y + (dy or 0)
    end
    if dy > 0.0 and (camera.y + love.graphics.getHeight()) - self.y < (love.graphics.getHeight() / 4) then
        camera.y = camera.y + (dy or 0)
    end
end

function player:draw()
    self.anim:draw(self.image, self.x, self.y)
end

return player
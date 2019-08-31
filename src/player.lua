local SpriteAnimation = require 'src.spriteAnimation'

function tablelength(T)
    local count = 0
    for _ in pairs(T) do count = count + 1 end
    return count
end

player = Class{
    __includes = SpriteAnimation,
    xSpeed = 5,
    ySpeed = 5
}

function player:init(obj)
    SpriteAnimation.init(self, obj, Animations.character)
end

function player:updateCollisions()
    local collisions = HC.collisions(self.boundary)
    if tablelength(collisions) > 0 then
        for shape, delta in pairs(collisions) do
            self.collision = delta
        end
    else
        self.collision = {}
    end
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

    SpriteAnimation.update(self, dt)
    self:updateCollisions()
end

function player:colliding(dx, dy)
    local colx, coly = false, false
    if self.collision.x == nil then
        return colx, coly
    end

    if dx < 0.0 and self.collision.x > 0.0 then
        colx = true
    elseif dx > 0.0 and self.collision.x < 0.0 then
        colx = true
    end
    if dy > 0.0 and self.collision.y < 0.0 then
        coly = true
    elseif dy < 0.0 and self.collision.y > 0.0 then
        coly = true
    end

    return colx, coly
end

function player:move(dx, dy)
    local xo, yo = self.x + (dx or 0), self.y + (dy or 0)
    -- offset coordinates relative to the camera
    local cx, cy = camera:cameraCoords(xo, yo)
    -- camera offset following the player
    local cxo, cyo = camera.x + (dx or 0), camera.y + (dy or 0)
    -- check collisions
    local colx, coly = self:colliding(dx, dy)

    -- lock the player within the camera
    if xo - (camera.x - WIDTH/2) < 100 or (camera.x + WIDTH/2) - xo < 100 or colx then
        xo = self.x
    end
    if yo - (camera.y - HEIGHT/2) < 100 or (camera.y + HEIGHT/2) - yo < 100 or coly then
        yo = self.y
    end

    -- commit to the offset, player is within bounds
    SpriteAnimation.move(self, xo - self.x, yo - self.y)

    -- keep camera within map

    -- going left and on the border
    if (cxo < camera.x and cxo < 5) or colx then
        cxo = camera.x
    -- going right and on the border
    elseif (cxo > camera.x and cxo > map.w - WIDTH - 5) or colx then
        cxo = camera.x
    end
    -- going up and on the border 
    if (cyo < camera.y and cyo < 5) or coly then
        cyo = camera.y
    -- going down and on the border
    elseif (cyo > camera.y and cyo > map.h - HEIGHT) or coly then
        cyo = camera.y
    end

    -- allow the player to pull the camera along
    if dx < 0.0 and cx < WIDTH / 4 then
        camera.x = cxo
    end
    if dx > 0.0 and cx > WIDTH * 0.75 then
        camera.x = cxo
    end
    if dy < 0.0 and cy < HEIGHT / 4 then 
        camera.y = cyo
    end
    if dy > 0.0 and cy > HEIGHT * 0.75 then
        camera.y = cyo
    end
end

return player
local SpriteAnimation = require 'src.spriteAnimation'

function math:distance(x1, y1, x2, y2)
    local dx = x1 - x2
    local dy = y1 - y2
    return math.sqrt ( dx * dx + dy * dy )
end

Static = Class{
    __includes = SpriteAnimation
}

function Static:init(obj)
    SpriteAnimation.init(self, obj, Animations[obj.properties.type])
end

function Static:updateCollision()
    local collisions = HC.collisions(self.boundary)
    if tablelength(collisions) > 0 then
        for shape, delta in pairs(collisions) do
            if shape.tags.type == 'player' then
                self.collision = delta
            end
        end
    else
        self.collision = {}
    end
end

function Static:playerTryingToEnter()
    local sc = next(self.collision) ~= nil
    local yc = next(yang.collision) ~= nil
    return sc and yc and yang.collision.y > 0.0
end

function Static:playerInside()
    return self.x < yang.x and self.x + self.tw > yang.x and self.y < yang.y and self.y + self.th > yang.y
end

function Static:update(dt)
    SpriteAnimation.update(self, dt)
    self:updateCollision()
    local shouldOpen = self:playerTryingToEnter()
    local shouldClose = not self:playerInside()
    if shouldOpen and self.currentAnim == 'closed' then
        print('opening')
        self:chanim('open')
    elseif shouldClose and self.currentAnim == 'open' then
        print('closing')
        self:chanim('closed')
    end
end

-- function Static:draw()
-- end

return Static
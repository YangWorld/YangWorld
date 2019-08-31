local SpriteAnimation = require 'src.spriteAnimation'

NPC = Class{
    __includes = SpriteAnimation
}

function NPC:init(obj)
    -- n.properties.image, n.x - WIDTH/2, n.y - HEIGHT/2, n.properties.tw, n.properties.th
    SpriteAnimation.init(self, obj, Animations.character)
    self.idle = true
    self.idleSince = 0.0
    self.idleFor = 1.0
    self.walkingSince = 0.0
    self.walkingFor = 2.0
end

function NPC:randomAnim(idle) --Selects a random item from a table
    local keys = {}
    for key, value in pairs(self.anims) do
        if self.idle and string.match(key, "_idle") then
            keys[#keys+1] = key
        elseif not (self.idle or string.match(key, "_idle")) then
            keys[#keys+1] = key
        end
    end
    key = keys[math.random(1, #keys)]
    return key
end

function NPC:updateCollisions()
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

function NPC:update(dt)
    SpriteAnimation.update(self, dt)
    self:updateCollisions()
    if self.idle then
        self.idleSince = self.idleSince + dt
        if self.idleSince > self.idleFor then
            self.idleSince = 0.0
            self.idle = false
            self:chanim(self:randomAnim())
        end
    else
        self.walkingSince = self.walkingSince + dt
        if self.walkingSince > self.walkingFor then
            self.walkingSince = 0.0
            self.idle = true
            self:chanim(self:randomAnim())
        elseif self.currentAnim == 'up' then
            self:move(0, -1)
        elseif self.currentAnim == 'down' then
            self:move(0, 1)
        elseif self.currentAnim == 'left' then
            self:move(-1, 0)
        elseif self.currentAnim == 'right' then
            self:move(1, 0)
        end
    end
end

function NPC:draw()
    SpriteAnimation.draw(self)
end

return NPC
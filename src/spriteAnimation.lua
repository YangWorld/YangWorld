SpriteAnimation = Class{
    init = function(self, obj, anims)
        self.x = obj.x
        self.y = obj.y
        self.tw = obj.properties.tw
        self.th = obj.properties.th
        self.type = obj.properties.type
        self.dynamicBounds = anims.properties.dynamicBounds or false

        if obj.properties.type ~= 'player' then
            self.x = self.x - WIDTH/2
            self.y = self.y - HEIGHT/2
        end
        self.image = love.graphics.newImage("assets/images/"..obj.properties.image)

        -- collision

        self.boundary = nil
        if not anims.properties.dynamicBounds then
            self:setupBoundary()
        end
        self.rectWire = {}
        self.collision = {}

        -- animation

        self.g = anim8.newGrid(self.tw, self.th, self.image:getWidth(), self.image:getHeight())
        self.currentAnim = nil
        self.anim = nil
        self.anims = {}
        for i, anim in ipairs(anims.clips) do
            self.anims[anim.name] = {
                anim = anim8.newAnimation(self.g(anim.range, anim.column), anim.frameSpeed, anim.onLoop),
                boundary = anim.boundary
            }
        end
        self:chanim(obj.properties.defaultAnim)
    end
}

function SpriteAnimation:setupBoundary()
    if self.boundary ~= nil then
        HC.remove(self.boundary)
        self.boundary = nil
    end
    if self.anim ~= nil and self.anim.boundary ~= nil then
        local points = {}
        table.foreach(self.anim.boundary, function(i, n)
            if i % 2 == 0 then
                table.insert(points, n + self.y)
            else
                table.insert(points, n + self.x)
            end
        end)
        self.boundary = HC.polygon(unpack(points))
    else
        self.boundary = HC.rectangle(self.x, self.y, self.tw, self.th)
    end
    self.boundary.tags = { type = self.type }
end

function SpriteAnimation:getRectWireframe()
    local wireframe = {}
    table.foreach(self.boundary._polygon.vertices, function(i, v)
        table.insert(wireframe, v.x)
        table.insert(wireframe, v.y)
    end)
    return wireframe
end

function SpriteAnimation:chanim(name)
    self.anim = self.anims[name]
    if self.dynamicBounds then
        self:setupBoundary()
    end
    self.currentAnim = name
end

function SpriteAnimation:move(dx, dy)
    local xo, yo = self.x + (dx or 0), self.y + (dy or 0)
    self.x = xo
    self.y = yo
    self.boundary:move(dx or 0, dy or 0)
end

function SpriteAnimation:update(dt)
    self.anim.anim:update(dt)
end

function SpriteAnimation:draw()
    self.anim.anim:draw(self.image, self.x, self.y)
    -- love.graphics.polygon('line', self:getRectWireframe())
end

return SpriteAnimation
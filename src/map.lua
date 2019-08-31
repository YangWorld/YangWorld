local NPC = require 'src.npc'
local Static = require 'src.static'

Map = Class{
    init = function(self, filename)
        self.tmx = sti("assets/tmx/"..filename)
        self.w, self.h = 2304, 2304

        local spawnObjects = self.tmx.layers['spawn'].objects
        assert(#spawnObjects == 1, "Only 1 spawn object must be present.")
        self.spawnPoint = spawnObjects[1]

        self.statics = {}
        local statics = self.tmx.layers['statics'].objects
        table.foreach(statics, function(i, s)
            table.insert(self.statics, Static(s))
        end)

        self.npcs = {}
        local npcs = self.tmx.layers['npcs'].objects
        table.foreach(npcs, function(i, n)
            table.insert(self.npcs, NPC(n))
        end)
    end,
}

function Map:update(dt)
    self.tmx:update(dt)
    table.foreach(self.statics, function(i, s)
        s:update(dt)
    end)
    table.foreach(self.npcs, function(i, n)
        n:update(dt)
    end)
end

function Map:draw(ox, oy, before)
    self.tmx:draw(ox, oy)
    before()
    table.foreach(self.statics, function(i, s)
        s:draw()
    end)
    table.foreach(self.npcs, function(i, n)
        n:draw()
    end)
end

return Map
Class = require "libs.vrld.hump.class"
anim8 = require "libs.kikito.anim8.anim8"
baton = require "libs.tesselode.baton.baton"

camera = require "src.camera"
local player = require "src.player"

input = baton.new {
    controls = {
        left = {'key:a'},
        right = {'key:d'},
        up = {'key:w'},
        down = {'key:s'}
    },
    pairs = {
        move = {'left', 'right', 'up', 'down'}
    }
}

WIDTH, HEIGHT = 800, 600

function love.load()
    print('Vote for Yang 2020!!!')
    love.window.setMode(WIDTH, HEIGHT)
    mapImage = love.graphics.newImage("assets/images/map.png")
    yang = player()
    camera:scale(1.2)
    camera:move(yang.x - WIDTH / 2, yang.y - HEIGHT / 2)
end

function love.update(dt)
    input:update()
    yang:update(dt)
end

function love.keypressed(key)
    if key == 'escape' then
        love.window.close()
    end
end

function love.draw()
    camera:set()
    love.graphics.draw(mapImage)
    yang:draw()
    camera:unset()
end
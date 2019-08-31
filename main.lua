Camera = require "libs.vrld.hump.camera"
Class = require "libs.vrld.hump.class"
Gamestate = require "libs.vrld.hump.gamestate"
HC = require "libs.vrld.HC"
anim8 = require "libs.kikito.anim8.anim8"
baton = require "libs.tesselode.baton.baton"
sti = require "libs.karai17.Simple-Tiled-Implementation.sti"
inspect = require "libs.kikito.inspect.inspect"

Animations = require "config.animations"

local player = require "src.player"
local Map = require "src.map"
local SpriteAnimation = require "src.spriteAnimation"

softPause = false

input = baton.new {
    controls = {
        left = {'key:a', 'key:left'},
        right = {'key:d', 'key:right'},
        up = {'key:w', 'key:up'},
        down = {'key:s', 'key:down'},
        action = {'key:return'},
        escape = {'key:escape'}
    },
    pairs = {
        move = {'left', 'right', 'up', 'down'}
    }
}

WIDTH, HEIGHT = love.graphics.getWidth(), love.graphics.getHeight()

local menu = {}
local game = {}
local options = {}

function options:enter()
    bgImage = love.graphics.newImage("assets/images/yang-options.png")
end

function options:update(dt)
    input:update()

    if input:released 'escape' then
        Gamestate.switch(menu)
    end
end

function options:draw()
    love.graphics.draw(bgImage)
end

function menu:enter()
    bgImage = love.graphics.newImage("assets/images/yang-start-menu.png")
    cursor = {
        position = 1,
        positions = {
            {
                x = 180,
                y = 190
            },
            {
                x = 180,
                y = 260
            }
        }
    }
end

function menu:update(dt)
    input:update()
    
    if input:released 'action' then
        if cursor.position == 1 then
            Gamestate.switch(game)
        elseif cursor.position == 2 then
            Gamestate.switch(options)
        end
    elseif input:released 'down' then
        cursor.position = (cursor.position + 1) % 3
        if cursor.position == 0 then
            cursor.position = 1
        end
    elseif input:released 'up' then
        cursor.position = cursor.position - 1
        if cursor.position == 0 then
            cursor.position = 2
        end
    end
end

function menu:draw()
    love.graphics.draw(bgImage)
    love.graphics.setColor(0, 0, 0, 255)
    local pos = cursor.positions[cursor.position]
    love.graphics.rectangle("fill", pos.x, pos.y, 25, 25)
    love.graphics.reset()
end

function game:enter()
    print('Vote for Yang 2020!!!')
    music:play()
    map = Map("test.lua")
    camera = Camera(map.spawnPoint.x, map.spawnPoint.y)
    yang = player(map.spawnPoint)
    local font = love.graphics.newFont("assets/fonts/roboto.black.ttf", 25)
    love.graphics.setFont(font)
end

function game:update(dt)
    input:update()
    if input:released 'escape' then
        Gamestate.switch(menu)
    end

    if not softPause then
        yang:update(dt)
    end
    map:update(dt)
end

function game:draw()
    -- local r, g, b, a = love.graphics.getColor()
    camera:attach()
    map:draw(-camera.x, -camera.y, function()
        yang:draw()
    end)
    camera:detach()
    -- love.graphics.setColor(0, 0, 0, 255)
    -- love.graphics.print(string.format("Colliding: %s", inspect(yang.collision)), 10, 10)
    -- love.graphics.setColor(r, g, b, a)
end

function love.load()
    music = love.audio.newSource("assets/music/burnin-rubber.ogg", "static")
    music:setLooping(true)
    music:setVolume(50)
    Gamestate.registerEvents()
    Gamestate.switch(menu)
end

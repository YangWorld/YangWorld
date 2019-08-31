local Animations = {
    character = {
        properties = {
            dynamicBounds = false
        },
        clips = {}
    },
    hospital = {
        properties = {
            dynamicBounds = true
        },
        clips = {
            {
                name = 'closed',
                range = '1-3',
                column = 1,
                frameSpeed = 0.2
            },
            {
                name = 'open',
                range = '1-3',
                column = 2,
                frameSpeed = 0.2,
                boundary = {
                    0, 0,
                    0, 384,
                    150, 384,
                    150, 290,
                    230, 290,
                    230, 384,
                    384, 384,
                    384, 0
                }
            }
        }
    }
}

-- generate character Animations
table.foreach({
    'down', 'up', 'left', 'right'
}, function(i, name)
    table.insert(Animations.character.clips, {
        name = name,
        range = '1-4',
        column = i,
        frameSpeed = 0.15
    })
    table.insert(Animations.character.clips, {
        name = name..'_idle',
        range = '1-4',
        column = i,
        frameSpeed = 0.3
    })
end)

return Animations
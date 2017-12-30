local Grid = {}
local ObjectGenerator = require('services.ObjectGenerator')
local Screen = require('modules.Screen')
local Tiles = require('game.tiles')

Grid.rows = {}
Grid.horizontalBlocks = 7
Grid.tileSize = Screen.width / Grid.horizontalBlocks
Grid.verticalBlocks = ( Screen.height / Grid.tileSize ) + 3

Grid.create = function (sceneGroup) 
    for i = 0, Grid.verticalBlocks, 1 do
        Grid.rows[i] = {} -- nested array right? :)

        for j = 0, Grid.horizontalBlocks, 1 do
            local x = (j * Grid.tileSize) + (Grid.tileSize*.5)
            local y = Screen.height - ( Grid.tileSize * (i+1) ) + (Grid.tileSize*.5)
            local object = ObjectGenerator.random()

            Grid.rows[i][j] = Tiles.create(object, {
                x = x, 
                y = y, 
                tileSize = Grid.tileSize, 
                tables = object.tables
            })
            sceneGroup:insert( Grid.rows[i][j] )

            -- create MINE enemy based on difficulty OUTSIDE OF GRID
        end
    end
end

return Grid
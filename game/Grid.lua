local Grid = {}
local ObjectGenerator = require('services.ObjectGenerator')
local Screen = require('modules.Screen')
local Tiles = require('game.tiles')
local Config = require('game.config')

Grid.setup = function(columns)
    Grid.columns = columns
    Grid.tileSize = Screen.width / Grid.columns
    Grid.rows = ( Screen.height / Grid.tileSize ) + 3
end

Grid.setup(Config.tiles)

Grid.create = function (sceneGroup) 
    for i = 0, Grid.rows, 1 do
        Grid.rows[i] = {} -- nested array right? :)

        for j = 0, Grid.columns-1, 1 do
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
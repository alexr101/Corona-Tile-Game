local Grid = {}
local ObjectGenerator = require('services.ObjectGenerator')
local Screen = require('modules.Screen')
local Tiles = require('game.tiles')
local Config = require('game.config')

Grid.matrix = {}
Grid.columns = 0
Grid.tileSize = 0
Grid.rows = 0

Grid.setup = function(columns)
    Grid.columns = columns
    Grid.tileSize = Screen.width / Grid.columns
    Grid.rows = math.ceil( ( Screen.height / Grid.tileSize ) + 3 )
    print('grid setup')
end

Grid.setup(Config.tiles)

Grid.create = function (sceneGroup) 
    print('grid create')
    print(Grid.rows)
    for i = 0, Grid.rows, 1 do
        Grid.matrix[i] = {} -- nested array right? :)

        for j = 0, Grid.columns-1, 1 do
            local x = (j * Grid.tileSize) + (Grid.tileSize*.5)
            local y = Screen.height - ( Grid.tileSize * (i+1) ) + (Grid.tileSize*.5)
            local object = ObjectGenerator.random()

            Grid.matrix[i][j] = Tiles.create(object, {
                x = x, 
                y = y, 
                tileSize = Grid.tileSize, 
                tables = object.tables
            })
            sceneGroup:insert( Grid.matrix[i][j] )

            -- create MINE enemy based on difficulty OUTSIDE OF GRID
        end
    end
end

return Grid
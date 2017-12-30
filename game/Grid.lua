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
end

Grid.setup(Config.tiles)

Grid.create = function (sceneGroup) 

    for i = 0, Grid.rows, 1 do
        Grid.matrix[i] = {} -- nested array right? :)

        for j = 0, Grid.columns-1, 1 do
            local x = (j * Grid.tileSize) + (Grid.tileSize*.5)
            local y = Screen.height - ( Grid.tileSize * (i+1) ) + (Grid.tileSize*.5)

            Grid.matrix[i][j] = Grid.fillSpace(x, y)
            sceneGroup:insert( Grid.matrix[i][j] )

            -- create MINE enemy based on difficulty OUTSIDE OF GRID
        end
    end
end

Grid.fillSpace = function(x, y) 

    local object = ObjectGenerator.random()
    local space = 'empty'
    local fillSpaceOdds = math.random(1, 100)

    -- if fillSpaceOdds <= 20 then
        space = Tiles.create(object, {
            x = x, 
            y = y, 
            tileSize = Grid.tileSize, 
            tables = object.tables
        })
    -- end

    return space
end

return Grid
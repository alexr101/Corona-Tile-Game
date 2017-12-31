local Grid = {}
local ObjectGenerator = require('services.ObjectGenerator')
local Screen = require('modules.Screen')
local Tiles = require('game.tiles')
local Config = require('game.config')
local Node = require('game.node')

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
            Grid.matrix[i][j].coordinates = {
                row = i, 
                column = j
            }

            sceneGroup:insert( Grid.matrix[i][j] )
            
            Grid.createOutOfGridObj(x, y, sceneGroup)
        end
    end

    return Grid.matrix
end

Grid.addNodesToMatrix = function(matrix)
    local matrix = Grid.matrix or matrix

    for i = 0, Grid.rows, 1 do
        local row = Grid.matrix[i]

        for j= 0, table.getn(row), 1 do
            local newNode = Node.new()
            row[j].node = newNode

            if matrix[i][j-1] then
                row[j].node.left = row[j-1]
            end
            if matrix[i][j+1] then
                row[j].node.right = row[j+1]
            end
            if matrix[i - 1] then
                row[j].node.down = matrix[i-1][j]
            end
            if matrix[i + 1] then
                row[j].node.up = matrix[i+1][j]
            end
        end
    end

    print('node[1][1]' .. matrix[1][1].info.name)
    print('node[1][1].right ' .. matrix[1][1].node.right.info.name)
    print('node[1][1].right right ' .. matrix[1][1].node.right.node.right.info.name)
end

Grid.createOutOfGridObj = function(x, y, sceneGroup) 
    local object = ObjectGenerator.randomOutOfGrid()
    local outOfGridOdds = math.random(1, 100)
    
    if outOfGridOdds < 2 then
        local tile = Tiles.create(object, {
            x = x, 
            y = y, 
            tileSize = Grid.tileSize, 
            tables = object.tables
        })
        tile.outOfGrid = true
        sceneGroup:insert( tile )
    end
end

Grid.fillSpace = function(x, y) 

    local object = ObjectGenerator.randomInGrid()
    local space = 'empty'

    space = Tiles.create(object, {
        x = x, 
        y = y, 
        tileSize = Grid.tileSize, 
        tables = object.tables
    })

    return space
end

Grid.swap = function(options)
    local direction = options.direction
    local coordinates = options.coordinates

    local row = coordinates.row
    local column = coordinates.column
    local targetRow = row
    local targetColumn = column

    if direction == 'right' then
        targetColumn = targetColumn + 1
    elseif direction == 'left' then
        targetColumn = targetColumn - 1
    elseif direction == 'up' then
        targetRow = targetRow + 1
    elseif direction == 'down' then
        targetRow = targetRow - 1
    end

    local obj1 = Grid.matrix[row][column]
    local obj2 = Grid.matrix[targetRow][targetColumn] 

    if obj1 == nil or obj2 == nil or obj1.transitioning == true or obj2.transitioning == true then
        print('invalid swipe')
        return 
    end

    obj1.transitioning = true
    obj2.transitioning = true

    local transitionSpeed = 200

    if direction == 'right' or direction == 'left' then
        transition.to( obj1, { time=transitionSpeed, alpha=1, x=obj2.x, 
            onComplete = function() 
                obj1.transitioning = false 
            end 
        })
        transition.to( obj2, { time=transitionSpeed, alpha=1, x=obj1.x, 
            onComplete = function() 
                obj2.transitioning = false 
            end 
        })
    else 
        transition.to( obj1, { time=transitionSpeed, alpha=1, y=obj2.y, 
            onComplete = function() 
                obj1.transitioning = false 
            end 
        })
        transition.to( obj2, { time=transitionSpeed, alpha=1, y=obj1.y,
            onComplete = function() 
                obj2.transitioning = false 
            end 
        })
    end

    Grid.matrix[row][column].coordinates = {
        row = targetRow,
        column = targetColumn
    }

    Grid.matrix[targetRow][targetColumn].coordinates = {
        row = row,
        column = column
    }

    local temp = Grid.matrix[row][column]
    Grid.matrix[row][column] = Grid.matrix[targetRow][targetColumn]
    Grid.matrix[targetRow][targetColumn] = temp

end

return Grid
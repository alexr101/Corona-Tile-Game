local Grid = {}
local ObjectGenerator = require('services.ObjectGenerator')
local Screen = require('device.Screen')
local Tiles = require('game.map.tiles')
local Config = require('game.config')
local Node = require('game.map.node')

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
            Grid.matrix[i][j].node = newNode

            if matrix[i][j-1] then
                Grid.matrix[i][j].node.left = row[j-1]
            end
            if matrix[i][j+1] then
                Grid.matrix[i][j].node.right = row[j+1]
            end
            if matrix[i - 1] then
                Grid.matrix[i][j].node.down = matrix[i-1][j]
            end
            if matrix[i + 1] then
                Grid.matrix[i][j].node.up = matrix[i+1][j]
            end
        end
    end
end

Grid.createOutOfGridObj = function(x, y, sceneGroup) 
    local object = ObjectGenerator.randomOutOfGrid()
    local outOfGridOdds = math.random(1, 100)
    
    if outOfGridOdds < 2 then
        local tile = Tiles.create(object, {
            x = x, 
            y = y, 
            tileSize = Grid.tileSize, 
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

    print(targetRow)
    local obj1 = Grid.matrix[row][column]
    local obj2 = Grid.matrix[targetRow][targetColumn] 

    if obj1 == nil or obj2 == nil or obj1.transitioning == true or obj2.transitioning == true then
        print('invalid swipe')
        return 
    end

    -- set direction in case you need to remove in services.ObjectHelpers.remove
    if direction == 'right' or direction == 'left' then
        obj1.moving = 'horizontally'
        obj2.moving = 'horizontally'
    elseif direction == 'up' or direction == 'down' then
        obj1.moving = 'vertically'
        obj2.moving = 'vertically'
    end

    -- get close proximity objects for transition position references
    local objForYReference1
    local objForYReference2

    if (targetColumn > 0) then
        objYReference1 = Grid.matrix[row][column-1]
        objYReference2 = Grid.matrix[targetRow][targetColumn-1] 
    else
        objYReference1 = Grid.matrix[row][column+1]
        objYReference2 = Grid.matrix[targetRow][targetColumn+1]
    end

    -- transition the positions
    obj1.transitioning = true
    obj2.transitioning = true
    local transitionSpeed = 100

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
                obj1.y = objYReference2.y
            end 
        })
        transition.to( obj2, { time=transitionSpeed, alpha=1, y=obj1.y,
            onComplete = function() 
                obj2.transitioning = false 
                obj2.y = objYReference1.y
            end 
        })
    end


    -- take care of internal coordinates
    Grid.matrix[row][column].coordinates = {
        row = targetRow,
        column = targetColumn
    }

    Grid.matrix[targetRow][targetColumn].coordinates = {
        row = row,
        column = column
    }

    print(Grid.matrix[targetRow][targetColumn])

    -- do the actual swap
    local temp = Grid.matrix[row][column]
    Grid.matrix[row][column] = Grid.matrix[targetRow][targetColumn]
    Grid.matrix[targetRow][targetColumn] = temp

    Node.updateSwapPositions({ 
        row = row,
        column = column,
        targetColumn = targetColumn,
        targetRow = targetRow
    })
end

return Grid
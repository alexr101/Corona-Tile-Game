-----------------------------------------------------------------------------------------
--
-- Grid is the highest class to create the game map
-- 
-- The layers below it are
--      Node - handles connecting every piece in the map with Grid.matrix[i][j].node
--      Tiles - this is the actual content inside of each matrix block. Create the corona obj, events, block info, etc
--
-----------------------------------------------------------------------------------------

local Grid = {}
local ObjectGenerator = require('Services.ObjectGenerator')
local Screen = require('Device.Screen')
local Tiles = require('Game.Map.Tiles')
local Config = require('Game.Config')
local Node = require('Game.Map.Node')
local State = require('Game.State')
local File = require('Utils.File')
local json = require('json')
local Table = require('Utils.Table')

Grid.matrix = {}
Grid.topRow = 0 -- row at the top of grid. Changes as we create more
Grid.columnsQty = 0
Grid.tileSize = 0
Grid.rowQty = 0

Grid.setup = function(columns)
    Grid.columnsQty = columns
    Grid.tileSize = Screen.width / Grid.columnsQty
    Grid.rowQty = Config.rows
    -- Grid.rowQty = math.ceil( ( Screen.height / Grid.tileSize ) + 3 )
end
Grid.setup(Config.tiles)

local levelData
if(Config.gridData == 'json') then
    local levelJson = File.read('/LevelData/' .. Config.levelBuilder.file)
    levelData = json.decode( levelJson )
end


local mockData = {
    { 'Rock', 'Rock', 'Rock', 'Rock', 'Rock', 'Rock' },
    { 'EmptySpace', 'EmptySpace', 'EmptySpace', 'EmptySpace', 'EmptySpace', 'EmptySpace' },
    { 'EmptySpace', 'EmptySpace', 'EmptySpace', 'EmptySpace', 'EmptySpace', 'EmptySpace' },
    { 'EmptySpace', 'EmptySpace', 'EmptySpace', 'EmptySpace', 'EmptySpace', 'EmptySpace' },
    { 'EmptySpace', 'EmptySpace', 'EmptySpace', 'EmptySpace', 'EmptySpace', 'EmptySpace' },
    { 'EmptySpace', 'EmptySpace', 'EmptySpace', 'EmptySpace', 'EmptySpace', 'EmptySpace' },
    { 'EmptySpace', 'EmptySpace', 'EmptySpace', 'EmptySpace', 'EmptySpace', 'EmptySpace' },
    { 'EmptySpace', 'EmptySpace', 'EmptySpace', 'EmptySpace', 'EmptySpace', 'EmptySpace' },
    { 'EmptySpace', 'EmptySpace', 'EmptySpace', 'EmptySpace', 'EmptySpace', 'EmptySpace' },
    { 'EmptySpace', 'EmptySpace', 'EmptySpace', 'Rock', 'EmptySpace', 'EmptySpace' }, -- 10
    { 'EmptySpace', 'EmptySpace', 'EmptySpace', 'EmptySpace', 'EmptySpace', 'EmptySpace' },
    { 'EmptySpace', 'EmptySpace', 'EmptySpace', 'EmptySpace', 'EmptySpace', 'EmptySpace' },
    { 'EmptySpace', 'EmptySpace', 'EmptySpace', 'EmptySpace', 'EmptySpace', 'EmptySpace' },
    { 'EmptySpace', 'EmptySpace', 'EmptySpace', 'EmptySpace', 'EmptySpace', 'EmptySpace' },
    { 'EmptySpace', 'EmptySpace', 'EmptySpace', 'EmptySpace', 'EmptySpace', 'EmptySpace' },
    { 'EmptySpace', 'EmptySpace', 'EmptySpace', 'EmptySpace', 'EmptySpace', 'EmptySpace' },
    { 'EmptySpace', 'EmptySpace', 'EmptySpace', 'EmptySpace', 'EmptySpace', 'EmptySpace' },
    { 'EmptySpace', 'EmptySpace', 'EmptySpace', 'EmptySpace', 'EmptySpace', 'EmptySpace' },
    { 'EmptySpace', 'EmptySpace', 'EmptySpace', 'EmptySpace', 'EmptySpace', 'EmptySpace' },
    { 'EmptySpace', 'EmptySpace', 'EmptySpace', 'Rock', 'EmptySpace', 'EmptySpace' }, -- 20
    { 'EmptySpace', 'EmptySpace', 'EmptySpace', 'EmptySpace', 'EmptySpace', 'EmptySpace' },
    { 'EmptySpace', 'EmptySpace', 'EmptySpace', 'EmptySpace', 'EmptySpace', 'EmptySpace' },
    { 'EmptySpace', 'EmptySpace', 'EmptySpace', 'EmptySpace', 'EmptySpace', 'EmptySpace' },
    { 'EmptySpace', 'EmptySpace', 'EmptySpace', 'EmptySpace', 'EmptySpace', 'EmptySpace' },
    { 'EmptySpace', 'EmptySpace', 'EmptySpace', 'Rock', 'EmptySpace', 'EmptySpace' }, -- 25

}


-- Creates a grid row by row.
-- You have to provide it the 'name' of each row
-- dataformat { {'block', 'block', block}, {etc...}, {etc...} }
Grid.create = function (data)

    local data

    if(Config.gridData == 'mock') then
        data = mockData
    elseif(Config.gridData == 'json') then
        data = levelData
    elseif(Config.gridData == 'random') then
        data = nil
    end

    if(data) then
        for i = 1, Grid.rowQty, 1 do
            Grid.newRow(data[i])
        end
    else -- random
        for i = 0, Grid.rowQty, 1 do
            Grid.newRow()
        end
    end

    return Grid.matrix
end

Grid.forEach = function(cb)
    for i = 0, Grid.rowQty-1, 1 do
        for j = 0, Grid.columnsQty-1, 1 do
            cb(Grid.matrix[i][j])
        end
    end
end

Grid.newRow = function(data)
    local i = Grid.topRow -- starts at 0
    Grid.matrix[i] = {} -- nested array right? oh lua :)

    for j = 0, Grid.columnsQty-1, 1 do
        local x = (Grid.tileSize * j) + (Grid.tileSize*.5) -- .5 because x-anchor is in center of Tile
        local y

        -- get position dynamically because once the grid is running you have to reference by topRow.y, wherever that may be
        if(i == 0) then
            y = Screen.height - (Grid.tileSize * .5)
        else
            y = Grid.matrix[i-1][j].y - Grid.tileSize
        end

        -- Fill with content and images
        if(data == nil) then
            Grid.matrix[i][j] = Grid.fillTile(x, y)
        else
            Grid.matrix[i][j] = Grid.fillTile(x, y, data[j+1]) --j+1 because silly lua tables start at 1 
        end

        -- Set up row and column properties
        Grid.matrix[i][j].coordinates = {
            row = i,
            column = j
        }
        -- Create node property and setup its connections
        Grid.newNodeConnection({
            row = i,
            column = j
        })

        State.sceneGroup:insert( Grid.matrix[i][j] )
        -- This MIGHT create an out Of Grid Obj based on set probablities
        Grid.createOutOfGridObj(x, y, State.sceneGroup)
    end

    Grid.topRow = Grid.topRow + 1
    return Grid.topRow-1
end

Grid.newNodeConnection = function(options)
    Grid.matrix[options.row][options.column].node = Node.new()
    Grid.updateNodeConnections({ 
        row = options.row,
        column = options.column,
    })
end

-- Grid.updateNodeConnections({row, column})
-- Update all 4 positions of a node. Create node property if it doesn't exist
-- by reading what's above, below, to its right and left!
-- 1) row and column of the originating tile, and 
-- 2) (optional) the directions to update
Grid.updateNodeConnections = function(options)
    local row = options.row
    local column = options.column
    local directions = options.directions or {'all'}
    local obj = Grid.matrix[row][column]

    -- up
    if (Grid.matrix[row+1] ~= nil and (Table.hasValue(directions, 'all') or Table.hasValue(directions, 'up') ) ) then
        local objAbove = Grid.matrix[row+1][column]
        obj.node.up = objAbove
        objAbove.node.down = obj
    end
    -- down
    if (Grid.matrix[row-1] ~= nil and (Table.hasValue(directions, 'all') or Table.hasValue(directions, 'down') ) ) then
        local objBelow = Grid.matrix[row-1][column]
        obj.node.down = objBelow
        objBelow.node.up = obj
    end
    -- left
    if (Grid.matrix[row][column+1] ~= nil and (Table.hasValue(directions, 'all') or Table.hasValue(directions, 'left') ) ) then
        local objToRight = Grid.matrix[row][column+1]
        obj.node.right = objToRight
        objToRight.node.left = obj
    end
    -- right
    if (Grid.matrix[row][column-1] ~= nil and (Table.hasValue(directions, 'all') or Table.hasValue(directions, 'right') ) ) then
        local objToLeft = Grid.matrix[row][column-1]
        obj.node.left = objToLeft
        objToLeft.node.right = obj
    end
end

Grid.createOutOfGridObj = function(x, y, sceneGroup)
    local object = ObjectGenerator.randomOutOfGrid()
    local outOfGridOdds = math.random(1, 100)

    if outOfGridOdds < 1 then
        local tile = Tiles.create(object, {
            x = x,
            y = y,
            tileSize = Grid.tileSize,
        })
        tile.outOfGrid = true
        sceneGroup:insert( tile )
    end
end

Grid.printMap = function()
    local RowBehavior = require('Game.Behaviors.Row')
    for i = 0, Grid.rowQty-1, 1 do
        RowBehavior.printRow(i)
    end
end

Grid.toJson = function()
    local RowBehavior = require('Game.Behaviors.Row')
    local data = {}

    for i = 0, Grid.rowQty-1, 1 do
        local json = RowBehavior.toJson(i)
        table.insert(data, json)
    end


    return data
end

Grid.toTable = function()
    local RowBehavior = require('Game.Behaviors.Row')
    local data = {}

    for i = 0, Grid.rowQty-1, 1 do
        local rowTable = RowBehavior.toTable(i)
        table.insert(data, rowTable)
    end
    return data
end

Grid.toEmptyTable = function()
    local RowBehavior = require('Game.Behaviors.Row')
    local data = {}

    for i = 0, Grid.rowQty-1, 1 do
        local rowTable = RowBehavior.toEmptyTable(i)
        table.insert(data, rowTable)
    end
    return data
end

Grid.updateUI = function()
    local RowBehavior = require('Game.Behaviors.Row')
    for i = 0, Grid.rowQty-1, 1 do
        RowBehavior.update(i)
    end
end

-- fill space with data from ObjGenerator, and generate a Tile with it
Grid.fillTile = function(x, y, name)
    local object

    -- specified or random
    if(name) then
        object = ObjectGenerator.get(name)
    else
        object = ObjectGenerator.randomInGrid()
    end

    local space = Tiles.create(object, {
        x = x,
        y = y,
        tileSize = Grid.tileSize,
        tables = object.tables
    })

    return space
end

-- Get the coordinates of the tile you want to swap to
-- direction = 'up', 'right', 'down', 'left'
-- coordinates = row, column of target
Grid.getTargetCoordinates = function(direction, coordinates)
    local targetRow = coordinates.row
    local targetColumn = coordinates.column

    if direction == 'right' then
        targetColumn = targetColumn + 1
    elseif direction == 'left' then
        targetColumn = targetColumn - 1
    elseif direction == 'up' then
        targetRow = targetRow + 1
    elseif direction == 'down' then
        targetRow = targetRow - 1
    end

    return {
        row = targetRow,
        column = targetColumn
    }
end

Grid.isSwipeValid = function(obj1, obj2)
    local objNil = obj1 == nil or obj2 == nil
    local objTransitioning = obj1.transitioning == true or obj2.transitioning == true
    local objUnmovable =  obj1.info.unmovable or obj2.info.unmovable

    if objNil or objTransitioning or objUnmovable then
        return false
    else
        return true
    end
end

-- SWAP 2 TILES
-- direction = 'up', 'right', 'down', 'left'
-- coordinates = row, column of target
Grid.swap = function(options)
    local direction = options.direction

    local coordinates = options.coordinates
    local row = coordinates.row
    local column = coordinates.column

    local targetCoordinates = Grid.getTargetCoordinates(direction, { row = row, column = column })
    local targetRow = targetCoordinates.row
    local targetColumn = targetCoordinates.column

    local obj1 = Grid.matrix[row][column]
    local obj2 = Grid.matrix[targetRow][targetColumn]

    if not Grid.isSwipeValid(obj1, obj2) then
        print('invalid swipe')
        return false
    end

    -- set direction in case you need to remove in services.ObjectService.remove
    if direction == 'right' or direction == 'left' then
        obj1.moving = 'horizontally'
        obj2.moving = 'horizontally'
    elseif direction == 'up' or direction == 'down' then
        obj1.moving = 'vertically'
        obj2.moving = 'vertically'
    end

    Grid.swapPerformTransition({
        row = row,
        column = column,
        targetRow = targetRow,
        targetColumn = targetColumn,
        speed = 80,
        direction = direction,
    })

    Grid.swapInternalCoordinates({
        row = row,
        column = column,
        targetRow = targetRow,
        targetColumn = targetColumn
    })

    -- do the actual swap
    local temp = Grid.matrix[row][column]
    Grid.matrix[row][column] = Grid.matrix[targetRow][targetColumn]
    Grid.matrix[targetRow][targetColumn] = temp

    Grid.newNodeConnection({
        row = row,
        column = column,
    })
    Grid.newNodeConnection({
        row = targetRow,
        column = targetColumn,
    })
    return true
end

Grid.getRowNeighbour = function(options)
    if options.column > 1 then 
        return Grid.matrix[options.row][options.column-1].coordinates.row
    else   
        return Grid.matrix[options.row][options.column+1].coordinates.row
    end
end



-- Perform the actual swap transition of objects w Corona transition.to()
Grid.swapPerformTransition = function(options)
    local RowBehavior = require('Game.Behaviors.Row')
    local obj1 = Grid.matrix[options.row][options.column]
    local obj2 = Grid.matrix[options.targetRow][options.targetColumn]
    local direction = options.direction
    local transitionSpeed = options.speed

    -- If vertical swap get neighbord nodes to get their coordinates at the end of transition. Cause transition doesn't account for moving y position
    local obj1RowNeighbour = Grid.getRowNeighbour({
        row = options.row, 
        column = options.column
    })
    local obj2RowNeighbour = Grid.getRowNeighbour({
        row = options.targetRow, 
        column = options.targetColumn
    })

    obj1.transitioning = true
    obj2.transitioning = true

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
                obj1.y = RowBehavior.getYPosition(obj2RowNeighbour)
            end
        })
        transition.to( obj2, { time=transitionSpeed, alpha=1, y=obj1.y,
            onComplete = function()
                obj2.transitioning = false
                obj2.y = RowBehavior.getYPosition(obj1RowNeighbour)
            end
        })
    end
end

Grid.swapInternalCoordinates = function(options)
    Grid.matrix[options.row][options.column].coordinates = {
        row = options.targetRow,
        column = options.targetColumn
    }
    Grid.matrix[options.targetRow][options.targetColumn].coordinates = {
        row = options.row,
        column = options.column
    }
end

return Grid
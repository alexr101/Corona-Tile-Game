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
Grid.topRow = 0
Grid.columns = 0
Grid.tileSize = 0
Grid.rows = 0

Grid.setup = function(columns)
    Grid.columns = columns
    Grid.tileSize = Screen.width / Grid.columns
    Grid.rows = Config.rows
    -- Grid.rows = math.ceil( ( Screen.height / Grid.tileSize ) + 3 )
end

Grid.setup(Config.tiles)

local levelJson = File.read('/LevelData/' .. Config.levelBuilderFile)
local levelData = json.decode( levelJson )

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


Grid.create = function (data)

    local data
    print(Config.gridData)

    if(Config.gridData == 'mock') then
        data = mockData
    elseif(Config.gridData == 'json') then
        data = levelData
    elseif(Config.gridData == 'random') then
        data = nil
    end

    if(data) then
        for i = 1, Grid.rows, 1 do
            Grid.newRow(data[i])
        end
    else
        -- random
        for i = 0, Grid.rows, 1 do
            Grid.newRow()
        end

    end


    return Grid.matrix
end

Grid.forEach = function(cb)
    for i = 0, Grid.rows-1, 1 do
        for j = 0, Grid.columns-1, 1 do
            cb(Grid.matrix[i][j])
        end
    end
end

Grid.newRow = function(data)
    local i = Grid.topRow -- starts at 0
    Grid.matrix[i] = {} -- nested array right? :)

    for j = 0, Grid.columns-1, 1 do
        local x = (j * Grid.tileSize) + (Grid.tileSize*.5)
        local y

        -- get position dynamically
        if(i == 0) then
            y = Screen.height - (Grid.tileSize * .5)
        else
            y = Grid.matrix[i-1][j].y - Grid.tileSize
        end

        -- generated or specified tile type
        if(data == nil) then
            Grid.matrix[i][j] = Grid.fillSpace(x, y)
        else
            Grid.matrix[i][j] = Grid.fillSpace(x, y, data[j+1]) --j+1 because silly lua tables start at 1 :-)
        end

        Grid.matrix[i][j].coordinates = {
            row = i,
            column = j
        }
        Node.updatePositions({
            row = i,
            column = j
        })

        State.sceneGroup:insert( Grid.matrix[i][j] )

        Grid.createOutOfGridObj(x, y, State.sceneGroup)
    end

    Grid.topRow = Grid.topRow + 1
    return Grid.topRow-1
end

Grid.addRowNodes = function(row)


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
    for i = 0, Grid.rows-1, 1 do
        RowBehavior.printRow(i)
    end
end

Grid.toJson = function()
    local RowBehavior = require('Game.Behaviors.Row')
    local data = {}

    for i = 0, Grid.rows-1, 1 do
        local json = RowBehavior.toJson(i)
        table.insert(data, json)
    end


    return data
end

Grid.toTable = function()
    local RowBehavior = require('Game.Behaviors.Row')
    local data = {}

    for i = 0, Grid.rows-1, 1 do
        local rowTable = RowBehavior.toTable(i)
        table.insert(data, rowTable)
    end


    return data
end

Grid.update = function()
    local RowBehavior = require('Game.Behaviors.Row')
    for i = 0, Grid.rows-1, 1 do
        RowBehavior.update(i)
    end
end

Grid.fillSpace = function(x, y, name)
    
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

Grid.swap = function(options)
    local RowBehavior = require('Game.Behaviors.Row')
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

    if (targetColumn > 1) then
        objRowReference1 = Grid.matrix[row][column-1].coordinates.row
        objRowReference2 = Grid.matrix[targetRow][targetColumn-1].coordinates.row
    else
        objRowReference1 = Grid.matrix[row][column+1].coordinates.row
        objRowReference2 = Grid.matrix[targetRow][targetColumn+1].coordinates.row
    end

    -- transition the positions
    obj1.transitioning = true
    obj2.transitioning = true
    local transitionSpeed = 80

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
                obj1.y = RowBehavior.getYPosition(objRowReference2)
            end
        })
        transition.to( obj2, { time=transitionSpeed, alpha=1, y=obj1.y,
            onComplete = function()
                obj2.transitioning = false
                obj2.y = RowBehavior.getYPosition(objRowReference1)
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
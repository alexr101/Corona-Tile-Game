local Row = {}


Row.delete = function(row)
    local ObjectService = require('Services.ObjectService')
    Row.forEach(row, function(obj)
        ObjectService.remove(obj)
    end)
end

Row.newRow = function()
    local Grid = require('Game.Map.Grid')
    local row = Grid.newRow()
    Row.updateElectricity(row)
end

Row.update = function(row)
  Row.removeElectricity({ row = row })
  Row.updateElectricity(row)

end

Row.updateElectricity = function(row)
    local ElectricityGeneratorBehavior = require('Game.Behaviors.ElectricityGenerator')

    Row.forEachElement(row, 'ElectricityGenerator', function(obj)
        ElectricityGeneratorBehavior.updateElectricity({
            row = row,
            column = obj.coordinates.column
        })
    end)
end

Row.forEach = function(row, cb)
    local Config = require('Game.Config')
    local Grid = require('Game.Map.Grid')

    for i = 0, Config.tiles-1, 1 do
        local obj = Grid.matrix[row][i]

        if(obj ~= nil) then
            cb(obj)
        end

    end
end

Row.forEachElement = function(row, elementName, cb)
    Row.forEach(row, function(obj)
        if(obj.info.name == elementName) then
            cb(obj)
        end
    end)
end

Row.toJson = function(row)
    local Config = require('Game.Config')
    local Grid = require('Game.Map.Grid')
    local Table = require('Utils.Table')
    local File = require('Utils.File')

    local rowArr = {}

    for i = 0, Config.tiles-1, 1 do
        local obj = Grid.matrix[row][i]
        table.insert(rowArr, obj.info.name)
    end

    local json = Table.toJson(rowArr)
    -- File.save('LevelData/test.json', json)

    return json

end

Row.toTable = function(row)
    local Config = require('Game.Config')
    local Grid = require('Game.Map.Grid')
    local Table = require('Utils.Table')
    local rowTable = {}
    for i = 0, Config.tiles-1, 1 do
        local obj = Grid.matrix[row][i]
        table.insert(rowTable, obj.info.name)
    end

    return rowTable
end

Row.getYPosition = function(row)
    local Config = require('Game.Config')
    local Grid = require('Game.Map.Grid')
    local hashTable = {}
    local maxCount = 1
    local result

    for i = 0, Config.tiles-1, 1 do
        local y = Grid.matrix[row][i].y

        if(hashTable[y] == nil) then
            hashTable[y] = 1
        else
            hashTable[y] = hashTable[y] + 1
        end

        if(hashTable[y] > maxCount) then
            maxCount = hashTable[y]
            result = y
        end
    end

    return result
end

-- removes electricity that is not coming from an electric conductor
-- will find electricity block and search right and left to see if
-- if it comes from an electric conductor.
-- It will save each block column number so you don't have to check them again
Row.removeElectricity = function(options)
    local ObjectGenerator = require('Services.ObjectGenerator')
    local State = require('Game.State')
    local Tiles = require('Game.Map.Tiles')
    local Table = require('Utils.Table')
    local Grid = require('Game.Map.Grid')
    local Config = require('Game.Config')

    local row = options.row
    local rowLength = Config.tiles
    local verifiedBlocks = options.verifiedBlocks or {}
    local index = 0

    for i = 0, rowLength-1, 1 do

        local gridObj = Grid.matrix[row][index]

        if(gridObj ~= nil and (gridObj.info.name == 'Electricity' or gridObj.info.name == 'ElectricityGenerator')) then

            local result = comesFromConductor({ --results = {verifiedblocks, conductorFound}
                firstObjVerified = false,
                row = row,
                column = index
            })

            index = math.max(unpack(result.verifiedBlocks))

            if(result.conductorFound == false) then

                -- TODO: convert all verified tiles to empty spaces w a for loop :-)
                for j = 1, table.getn(result.verifiedBlocks), 1 do
                  local column = result.verifiedBlocks[j]

                  if(Grid.matrix[row][column].info.name == 'Electricity') then

                    -- print('replace row: ' .. row)
                    -- print('replace column: ' .. column)

                    local replaceOptions = {
                        newObjInfo = ObjectGenerator.EmptySpace,
                        x = State.getColXPosition(column),
                        y = Row.getYPosition(row),
                        row = row,
                        column = column
                    }

                    Tiles.replace(replaceOptions)
                  end
                end
            end
        end
        index = index + 1
        if(index > rowLength-1 ) then
            break
        end
    end
end

-- return a table of indexes searched and whether they come from a conductor
-- results = {verifiedblocks, conductorFound}
function comesFromConductor(options)
    local Table = require('Utils.Table')
    local Grid = require('Game.Map.Grid')
    local row = options.row
    local column = options.column
    local obj = Grid.matrix[row][column]
    local conductorFound = options.conductorFound or false
    local verifiedBlocks = options.verifiedBlocks or {}
    local result = {
        verifiedBlocks = verifiedBlocks,
        conductorFound = conductorFound
    }

    if(obj == nil) then
        return result
    end

    table.insert(verifiedBlocks, obj.coordinates.column)

    if(obj ~= nil and obj.info.name == 'ElectricityGenerator') then
        -- print('continue: ' .. column .. ' ' .. obj.info.name .. ' electricity generator or electricity')
        conductorFound = true
    elseif(obj ~= nil and obj.info.blocksElectricity == true) then
        return {
            verifiedBlocks = verifiedBlocks,
            conductorFound = conductorFound
        }

    elseif(obj ~= nil and obj.node.right == nil)then
        return {
            verifiedBlocks = verifiedBlocks,
            conductorFound = conductorFound
        }
    end

    result = comesFromConductor({
        row = row,
        column = column + 1,
        verifiedBlocks = verifiedBlocks,
        conductorFound = conductorFound
    })

    return result

end




return Row
local Row = {}


Row.update = function(row) 
    local electricityGeneratorBehavior = require('game.behaviors.ElectricityGenerator')
  Row.removeElectricity({ row = row })
  Row.forEachElement(row, 'electricityGenerator', function(el)
    electricityGeneratorBehavior.updateElectricity(el)
  end)

end

Row.forEachElement(row, elementName, cb)
    local Config = require('game.Config')
    local Grid = require('game.map.Grid')

    for i = 0, Config.tiles-1, 1 do
        local obj = Grid.matrix[row][i]

        if(obj.info.name == elementName) then
            cb(obj)
        end

    end

end

Row.printRow = function(row)
    local Config = require('game.Config')
    local Grid = require('game.map.Grid')

    for i = 0, Config.tiles-1, 1 do
        local obj = Grid.matrix[row][i]
        print('row # ' .. i .. ' name: ' .. obj.info.name)
    end 
end

Row.getYPosition = function(row)
    local Config = require('game.Config')
    local Grid = require('game.map.Grid')
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
    local ObjectGenerator = require('services.ObjectGenerator')
    local State = require('game.state')
    local Tiles = require('game.map.Tiles')
    local Table = require('Utils.Table')
    local Grid = require('game.map.Grid')
    local Config = require('game.config')

    local row = options.row
    local rowLength = Config.tiles 
    local verifiedBlocks = options.verifiedBlocks or {}
    local index = 0

    for i = 0, rowLength-1, 1 do
 
        local gridObj = Grid.matrix[row][index]

        if(gridObj ~= nil and (gridObj.info.name == 'electricity' or gridObj.info.name == 'electricityGenerator')) then

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
                  print('trying to replace column num: ' .. column)

                  if(Grid.matrix[row][column].info.name == 'electricity') then
                    
                    -- print('replace row: ' .. row)
                    -- print('replace column: ' .. column)

                    local replaceOptions = {
                        newObjInfo = ObjectGenerator.EmptySpace,
                        x = State.getColXPosition(column),
                        y = Row.getYPosition(row),
                        row = row,
                        column = column
                    }

                    print('y: ' .. Row.getYPosition(row))
                    print(State.getColXPosition(column))
                    print('replace row: ' .. row)
                    print('replace column: ' .. column)
                    
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
    local Grid = require('game.map.Grid')
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

    if(obj ~= nil and obj.info.name == 'electricityGenerator') then
        print('continue: ' .. column .. ' ' .. obj.info.name .. ' electricity generator or electricity')
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
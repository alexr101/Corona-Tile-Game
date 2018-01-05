local Row = {}


Row.update = function(row) 
  Row.removeElectricity({ row = row })
  -- Row.findGeneratorsAndUpdateElectricity({row: row})
end

-- removes electricity that is not coming from an electric conductor
-- will find electricity block and search right and left to see if 
-- if it comes from an electric conductor. 
-- It will save each block column number so you don't have to check them again
Row.removeElectricity = function(options)
    local Config = require('game.Config')
    local ObjectGenerator = require('services.ObjectGenerator')
    local State = require('game.state')
    local Tiles = require('game.map.Tiles')
    local Table = require('Utils.Table')
    local Grid = require('game.map.Grid')

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
                    print('y: ' .. Grid.matrix[row][column].y)
                    print('replace row: ' .. row)
                    print('replace column: ' .. column)
                    Table.forEach(State.colXPositions, function (e)
                        print(e)
                    end)
                    local replaceOptions = {
                        newObjInfo = ObjectGenerator.DebugSpace,
                        x = State.colXPositions[column],
                        y = Grid.matrix[row][column].y,
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
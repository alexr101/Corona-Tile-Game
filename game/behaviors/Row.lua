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
  local Tiles = require('game.map.Tiles')
    local Grid = require('game.map.Grid')

    local row = options.row
    local rowLength = Config.tiles 
    local verifiedBlocks = options.verifiedBlocks or {}

    for i = 0, rowLength-1, 1 do
        local gridObj = Grid.matrix[row][i]

        if(gridObj ~= nil and gridObj.info.name == 'electricity') then
            local result = comesFromConductor({obj = gridObj}) --results = {verifiedblocks, conductorFound}

            i = math.max(unpack(result.verifiedBlocks)) + 1
            if(result.conductorFound == false) then

                -- TODO: convert all verified tiles to empty spaces w a for loop :-)
                for j = 0, table.getn(result.verifiedBlocks), 1 do
                  local column = result.verifiedBlocks[j]
                  print(column)
                  local replaceOptions = {
                      oldObj = nil,
                      newObjInfo = ObjectGenerator.EmptySpace,
                      x = Grid.matrix[row][column].x,
                      y = Grid.matrix[row][column].y,
                      row = row,
                      column = Grid.matrix[row][column].coordinates.column
                  }
                  
                  Tiles.replace(replaceOptions)
                end
            end
        end
    end
end

-- return a table of indexes searched and whether they come from a conductor
-- results = {verifiedblocks, conductorFound}
function comesFromConductor(options)
    local obj = options.obj
    local currentColumn = obj.coordinates.column
    local verifiedBlocks = options.verifiedBlocks or {}
    local conductorFound = options.conductorFound or false
    local result

    table.insert(verifiedBlocks, currentColumn)
    print('comes from conductor')

    if(obj.right ~= nil and obj.right.info.name == 'Electricity') then
        result = comesFromConductor({
            obj = obj,
            verifiedBlocks = verifiedBlocks,
            conductorFound = conductorFound
        })
    end

    -- found a conductor but keep searching right to verify blocks
    if(obj.right ~= nil and obj.right.info.name == 'ElectricityConductor') then
        result = comesFromConductor({
            verifiedBlocks = verifiedBlocks,
            conductorFound = true
        })
    end

    -- end of the line. conductor found = true if we found an electricity conductor along the way
    if(obj.right == nil or obj.right.info.conductsElectricity == false) then
        return {
            verifiedBlocks = verifiedBlocks,
            conductorFound = conductorFound
        } 
    end

end




return Row
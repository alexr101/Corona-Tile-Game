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
    local index = 0

    for i = 0, rowLength-1, 1 do
        local gridObj = Grid.matrix[row][index]
        -- print(i)
        if(Grid.matrix[row][index].node.right ~= nil) then
            -- print(Grid.matrix[row][i].info.name)
            -- print(Grid.matrix[row][i].node.right.coordinates.column)

        end
        if(gridObj ~= nil) then
            print('start conductor search')
            local result = comesFromConductor({ --results = {verifiedblocks, conductorFound}
                firstObjVerified = false, 
                row = row,
                column = i
            }) 

            -- print(result.verifiedBlocks)

            index = math.max(unpack(result.verifiedBlocks)) + 1
            -- print('max i ' .. i)
            if(result.conductorFound == false) then

                -- TODO: convert all verified tiles to empty spaces w a for loop :-)
                for j = 1, table.getn(result.verifiedBlocks), 1 do
                  local column = result.verifiedBlocks[j]
                --   print('column num: ' .. column)

                  if(Grid.matrix[row][column].info.name == 'electricity') then
                    -- print('replace column: ' .. column)
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
        index = index + 1
        if(index > rowLength-1 ) then
            break
        end
    end
end

-- return a table of indexes searched and whether they come from a conductor
-- results = {verifiedblocks, conductorFound}
function comesFromConductor(options)
    local Grid = require('game.map.Grid')

    local row = options.row
    local column = options.column
    local obj = Grid.matrix[row][column]

    local firstObjVerified = options.firstObjVerified 
    if(firstObjVerified == nil) then
        firstObjVerified = true
    end
    local currentColumn = obj.coordinates.column
    local verifiedBlocks = options.verifiedBlocks or {}
    local conductorFound = options.conductorFound or false
    local objsValid = obj ~= nil and Grid.matrix[row][column].node.right ~= nil
    local result = {
        verifiedBlocks = verifiedBlocks,
        conductorFound = conductorFound
    } 

    table.insert(verifiedBlocks, currentColumn)
    print('obj name: ' .. obj.info.name .. ' column: ' .. currentColumn .. ' options.column' .. column .. 'right: ')
    if(obj.node.right ~= nil) then
        print('node right' .. obj.node.right.info.name)
    end
    -- print(firstObjVerified)
    print(objsValid)

    if(firstObjVerified == false and obj.info.name == 'electricityGenerator') then
        print('continue: initial is electricity generator')

        result = comesFromConductor({
            row = row,
            column = column,
            verifiedBlocks = {},
            conductorFound = true
        })
    elseif(objsValid and obj.node.right.info.name == 'electricity') then
        print('continue: is electricity block')

        result = comesFromConductor({
            row = row,
            column = column + 1,
            verifiedBlocks = verifiedBlocks,
            conductorFound = conductorFound
        })
    -- found a conductor but keep searching right to verify blocks
    elseif(objsValid and obj.node.right.info.name == 'electricityGenerator') then
        print('continue: is an electricity generator')

        result = comesFromConductor({
            row = row,
            column = column + 1,
            verifiedBlocks = verifiedBlocks,
            conductorFound = true
        })

    -- conducts electricity but is not generator or elecrticity. ie: empty space
    elseif(objsValid and obj.node.right.info.conductsElecricity == true) then
        print('continue: conducts electricity but is not electricity')

        result = comesFromConductor({
            row = row,
            column = column + 1,
            verifiedBlocks = verifiedBlocks,
            conductorFound = conductorFound
        })
    

    -- end of the line. conductor found = true if we found an electricity conductor along the way
    elseif(objsValid and obj.node.right.info.conductsElectricity == false) then
        
        print('end: found a block' )

        return {
            verifiedBlocks = verifiedBlocks,
            conductorFound = conductorFound
        } 

    elseif(obj ~= nil and obj.node.right == nil) then
        
        print('end: found end of the line')

        return {
            verifiedBlocks = verifiedBlocks,
            conductorFound = conductorFound
        } 
    end

    print('end of conductor search')
    print(result.conductorFound)

    return result

end




return Row
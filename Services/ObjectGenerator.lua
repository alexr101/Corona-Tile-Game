-----------------------------------------------------------------------------------------
--
-- Object Generator Service
--
-- Handles keeping track of all obj metadata types and info for our game
--
-----------------------------------------------------------------------------------------

local ObjectGenerator = {}

ObjectGenerator.MineMagnet = require('Game.CharacterMetaData.MineMagnet')
ObjectGenerator.Star = require('Game.CharacterMetaData.Star')
ObjectGenerator.Electricity = require('Game.CharacterMetaData.Electricity')
ObjectGenerator.ElectricityGenerator = require('Game.CharacterMetaData.ElectricityGenerator')

ObjectGenerator.Rock = require('Game.CharacterMetaData.Rock')
ObjectGenerator.RockCrumbling = require('Game.CharacterMetaData.RockCrumbling')
ObjectGenerator.EmptySpace = require('Game.CharacterMetaData.EmptySpace')
ObjectGenerator.DebugSpace = require('Game.CharacterMetaData.DebugSpace')
ObjectGenerator.UnmovableSpace = require('Game.CharacterMetaData.UnmovableSpace')
ObjectGenerator.BounceRock = require('Game.CharacterMetaData.BounceRock')
ObjectGenerator.Enemy1 = require('Game.CharacterMetaData.Enemy1')

-- TODO: Refactor this mess
ObjectGenerator.objectsInGridArray = {
    ObjectGenerator.EmptySpace,
    ObjectGenerator.Star,
    ObjectGenerator.Rock,
    ObjectGenerator.RockCrumbling,
    ObjectGenerator.ElectricityGenerator,
    ObjectGenerator.UnmovableSpace,
    ObjectGenerator.BounceRock,
}
ObjectGenerator.objectsOutOfGridArray = {
    ObjectGenerator.MineMagnet,
    ObjectGenerator.Enemy1
}
ObjectGenerator.objectsReactive = {
    ObjectGenerator.Electricity
}
ObjectGenerator.allObjects = {
    ObjectGenerator.EmptySpace,
    ObjectGenerator.Star,
    ObjectGenerator.Rock,
    ObjectGenerator.RockCrumbling,
    ObjectGenerator.ElectricityGenerator,
    -- ObjectGenerator.Electricity,
    ObjectGenerator.UnmovableSpace,
    ObjectGenerator.BounceRock,
    -- ObjectGenerator.MineMagnet,
    -- ObjectGenerator.Enemy1
}
ObjectGenerator.names = {
    ObjectGenerator.EmptySpace.name,
    ObjectGenerator.Star.name,
    ObjectGenerator.Rock.name,
    ObjectGenerator.RockCrumbling.name,
    ObjectGenerator.ElectricityGenerator.name,
    
    ObjectGenerator.UnmovableSpace.name,
    ObjectGenerator.BounceRock.name,

    -- ObjectGenerator.Electricity.name,
    -- ObjectGenerator.MineMagnet.name,
    -- ObjectGenerator.Enemy1.name

}

-- Get the next object out of the list of object types
-- Used for levelbuilder
ObjectGenerator.next = function(name)
    print(name)
    local Table = require('Utils.Table')
    local i = Table.getIndex(ObjectGenerator.names, name) + 1
    print(i);
    if(i > table.getn(ObjectGenerator.allObjects) ) then
        i = 1
    end
    print(i)
    print(ObjectGenerator.allObjects[i]);
    return ObjectGenerator.allObjects[i]
end

ObjectGenerator.get = function(name)
    local name = string.upper( string.sub(name, 1, 1) ) .. string.sub(name, 2, string.len(name))
    return Table.deepCopy( ObjectGenerator[name] )
end

ObjectGenerator.randomOutOfGrid = function()
    return ObjectGenerator.objectsOutOfGridArray[ math.random(1, table.getn(ObjectGenerator.objectsOutOfGridArray) ) ]
end

ObjectGenerator.randomInGrid = function() 
    return ObjectGenerator.objectsInGridArray[ math.random(1, table.getn(ObjectGenerator.objectsInGridArray) ) ]
end

return ObjectGenerator
local ObjectGenerator = {}
local MineMagnet = require('game.objects.MineMagnet')
local Star = require('game.objects.Star')
local Electricity = require('game.objects.Electricity')
local Rock = require('game.objects.Rock')




local objectsArray = {
    MineMagnet,
    Star,
    Electricity,
    Rock
}


ObjectGenerator.random = function() 
    return objectsArray[ math.random(1, table.getn(objectsArray) ) ]
end

return ObjectGenerator
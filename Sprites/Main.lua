-----------------------------------------------------------------------------------------
--
-- Handles Sprite Creation
--
-----------------------------------------------------------------------------------------


local sprites = {}
local sequences = require('Sprites.Sequences')

local imageFileFor = {
	star = 'sheet',
	starPic = 'sheet',
	electricity = 'sheet',
	smoke = 'sheet'
}

-- Name must match its lua & png sheet
local function _getImageSheet(name)
	local sheet = require('sprites.' .. imageFileFor[name]).sheet
	return graphics.newImageSheet( 'sprites/' .. imageFileFor[name] .. '.png', sheet )
end

-- Name must match Sequences.lua sequence
local function _getSequence(name)
	return sequences[name]
end

-- An obj with all sprites
sprites = {
	electricity = {
		sheet = _getImageSheet('electricity'),
		sequence = _getSequence('electricity'),
	},
	star = {
		sheet = _getImageSheet('star'),
		sequence = _getSequence('star'),
	},
	starPic = {
		sheet = _getImageSheet('starPic'),
		sequence = _getSequence('starPic'),
	},
	smoke = {
		sheet = _getImageSheet('smoke'),
		sequence = _getSequence('smoke'),
	}
}

return sprites
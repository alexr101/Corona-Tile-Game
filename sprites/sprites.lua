local sprites = {}
local data = require('sprites.data')

local function _getImageSheet(name)
	local sheetFile = require('sprites.' .. data.files[name])
	local sheetData = sheetFile:getSheet()
	return graphics.newImageSheet( 'sprites/' .. data.files[name] .. '.png', sheetData )
end

local function _getSequence(name)
	return data.sequences[name]
end

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
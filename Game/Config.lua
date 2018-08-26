-----------------------------------------------------------------------------------------
--
-- DEV Configurations
--
-----------------------------------------------------------------------------------------

local config = {
  debug = true,
  levelBuilder = {
    activated = false,
    resetLevel = false,
    file = 'level1.json',
    createMode = 'inGrid', -- 'inGrid' or 'outOfGrid' -- TODO: add buttons to add grid objects in or out of grid based on this enumerator
  },
  gridData = 'json', -- json, mock, random
  levelSpeed = -.2,
  tiles = 6,
  rows = 25,
}
return config
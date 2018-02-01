local config = {
  debug = false,
  levelBuilder = {
    activated = false,
    file = 'level1.json',
    createMode = 'inGrid', -- 'inGrid' or 'outOfGrid' -- TODO: add buttons to add grid objects in or out of grid based on this enumerator
  },
  gridData = 'json', -- json, mock, random
  levelSpeed = 0,
  tiles = 6,
  rows = 25,
}



return config
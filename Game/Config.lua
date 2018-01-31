local config = {
  debug = false,
  levelBuilder = {
    activated = false,
    file = 'level1.json',
    createModes = { 'inGrid', 'outOfGrid' },
  },
  gridData = 'json', -- json, mock, random
  levelSpeed = 0,
  tiles = 6,
  rows = 25,
}



return config
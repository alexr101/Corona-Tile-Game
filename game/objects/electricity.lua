local GameTables = require('game.tables')

return {
  name = "electricity",
  tableName = "electricity",
  sprite = true,
  direction = "",
  animation = false,
  object = nil,
  tables = { 
    GameTables.tiles,
    GameTables.enemies
  }
}
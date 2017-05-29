GLOBAL.require("map/terrain")

GLOBAL.terrain.rooms.BGGrass.contents.distributeprefabs.wheat_planted = .035
GLOBAL.terrain.filter.wheat_planted = {GLOBAL.GROUND.ROAD, GLOBAL.GROUND.WOODFLOOR, GLOBAL.GROUND.CARPET, GLOBAL.GROUND.CHECKER, GLOBAL.GROUND.ROCKY, GLOBAL.GROUND.MARSH}

GLOBAL.terrain.rooms.BGMarsh.contents.distributeprefabs.nuttree = .007
GLOBAL.terrain.rooms.Marsh.contents.distributeprefabs.nuttree = .007
GLOBAL.terrain.filter.nuttree = {GLOBAL.GROUND.ROAD, GLOBAL.GROUND.WOODFLOOR, GLOBAL.GROUND.CARPET, GLOBAL.GROUND.CHECKER, GLOBAL.GROUND.ROCKY}

GLOBAL.terrain.rooms.BGRocky.contents.distributeprefabs.rocksalt = 0.7
GLOBAL.terrain.rooms.BGChessRocky.contents.distributeprefabs.rocksalt = 0.7
GLOBAL.terrain.rooms.Rocky.contents.distributeprefabs.rocksalt = 0.7
GLOBAL.terrain.rooms.RockLobsterPlains.contents.distributeprefabs.rocksalt = .07
GLOBAL.terrain.rooms.BatCaveRoomAntichamber.contents.distributeprefabs.rocksalt = .07
GLOBAL.terrain.filter.rocksalt = {GLOBAL.GROUND.ROAD, GLOBAL.GROUND.WOODFLOOR, GLOBAL.GROUND.CARPET, GLOBAL.GROUND.CHECKER, GLOBAL.GROUND.MARSH}

GLOBAL.terrain.rooms.BlueMush.contents.distributeprefabs.bluecrystal = 0.07
GLOBAL.terrain.rooms.RedMush.contents.distributeprefabs.redcrystal = 0.07
GLOBAL.terrain.rooms.RockLobsterPlains.contents.distributeprefabs.bluecrystal = 0.07
GLOBAL.terrain.rooms.RockLobsterPlains.contents.distributeprefabs.redcrystal = 0.07

GLOBAL.terrain.rooms.RuinsCamp.contents.distributeprefabs.truffles_planted = 0.3
GLOBAL.terrain.rooms.BGWilds.contents.distributeprefabs.truffles_planted = 0.3
GLOBAL.terrain.rooms.PondWilds.contents.distributeprefabs.truffles_planted = 0.3
GLOBAL.terrain.rooms.SlurperWilds.contents.distributeprefabs.truffles_planted = 0.3
GLOBAL.terrain.rooms.LushWilds.contents.distributeprefabs.truffles_planted = 0.3
GLOBAL.terrain.rooms.LightWilds.contents.distributeprefabs.truffles_planted = 0.3
GLOBAL.terrain.filter.truffles_planted = {GLOBAL.GROUND.ROAD, GLOBAL.GROUND.WOODFLOOR, GLOBAL.GROUND.CARPET, GLOBAL.GROUND.CHECKER}

GLOBAL.terrain.rooms.RuinsCamp.contents.distributeprefabs.orangecrystal = 0.07
GLOBAL.terrain.rooms.BGWilds.contents.distributeprefabs.orangecrystal = 0.07
GLOBAL.terrain.filter.orangecrystal = {GLOBAL.GROUND.ROAD, GLOBAL.GROUND.WOODFLOOR, GLOBAL.GROUND.CARPET, GLOBAL.GROUND.CHECKER}


GLOBAL.terrain.rooms.PondWilds.contents.distributeprefabs.greencrystal = 0.07
GLOBAL.terrain.rooms.SlurperWilds.contents.distributeprefabs.greencrystal = 0.07
GLOBAL.terrain.filter.greencrystal = {GLOBAL.GROUND.ROAD, GLOBAL.GROUND.WOODFLOOR, GLOBAL.GROUND.CARPET, GLOBAL.GROUND.CHECKER}


GLOBAL.terrain.rooms.LushWilds.contents.distributeprefabs.yellowcrystal = 0.07
GLOBAL.terrain.rooms.LightWilds.contents.distributeprefabs.yellowcrystal = 0.07
GLOBAL.terrain.filter.yellowcrystal = {GLOBAL.GROUND.ROAD, GLOBAL.GROUND.WOODFLOOR, GLOBAL.GROUND.CARPET, GLOBAL.GROUND.CHECKER}

if GLOBAL.IsDLCEnabled(GLOBAL.CAPY_DLC) then 
GLOBAL.terrain.rooms.ToxicTidalMarsh.contents.distributeprefabs.limetree = 0.5
GLOBAL.terrain.rooms.TidalMermMarsh.contents.distributeprefabs.limetree = 0.5
GLOBAL.terrain.rooms.TidalMarsh.contents.distributeprefabs.limetree = 0.5
GLOBAL.terrain.filter.limetree = {GLOBAL.GROUND.ROAD, GLOBAL.GROUND.WOODFLOOR, GLOBAL.GROUND.CARPET, GLOBAL.GROUND.CHECKER, GLOBAL.GROUND.ROCKY}
end
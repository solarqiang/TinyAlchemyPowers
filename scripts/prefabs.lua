if GLOBAL.IsDLCEnabled(GLOBAL.REIGN_OF_GIANTS) or GLOBAL.IsDLCEnabled(GLOBAL.CAPY_DLC) then 

PrefabFiles = {
	"extractor",
	"smokeex",
	"wheat",
	"dug_wheat",
	"cut_wheat",
	"flour",
	"bread",
	"wheat_planted",
	"cheese",
	"fernspinach",
	"houndhead",
	"bonearmor",
	"bonehelm",
	"bananapie",
	"slurtle_shellpieces",
	"shelldust",
	--"foliage",
	"mushroomsoup",
	"nuttree",
	"nuts",
	"nuts_cooked",
	"nutmuffin",
	"rocksalt",
	"saltnugget",
	"salt",
	"oversalt",
	"truffles_planted",
	"truffles",
	"truffles_cooked",
	"transtruffles",
	"spiderhead",
	"spiderhelm",
	"truffleham",
	"truffleegs",
	"cactus_cocktail",
	"ribs",
	"pancakes",
	"queenhelm",
	"gray_crystal",
	"lightingstaff",
	"grayamulet",
	"lemon_cocktail",
	"crystals",
	"minhibitor",
	"mosquito_milk",
	"waterbottle",
	"seaweedflour",
	"limetree",
	"lime",
	"lime_cooked",
	"lime_cocktail",
	"limpetspizza",
}

-- Map Icon -------------------------------------------------
local assets=
{
    Asset("ATLAS", "images/inventoryimages/extractor.xml"),
    Asset("IMAGE", "images/inventoryimages/extractor.tex"),
	Asset("ATLAS", "images/inventoryimages/wheat_map.xml"),
    Asset("IMAGE", "images/inventoryimages/wheat_map.tex"),
	Asset("ATLAS", "images/inventoryimages/nuttree_map.xml"),
    Asset("IMAGE", "images/inventoryimages/nuttree_map.tex"),
	Asset("ATLAS", "images/inventoryimages/bluecrystal_map.xml"),
    Asset("IMAGE", "images/inventoryimages/bluecrystal_map.tex"),
	Asset("ATLAS", "images/inventoryimages/redcrystal_map.xml"),
    Asset("IMAGE", "images/inventoryimages/redcrystal_map.tex"),
	Asset("ATLAS", "images/inventoryimages/orangecrystal_map.xml"),
    Asset("IMAGE", "images/inventoryimages/orangecrystal_map.tex"),
	Asset("ATLAS", "images/inventoryimages/greencrystal_map.xml"),
    Asset("IMAGE", "images/inventoryimages/greencrystal_map.tex"),
	Asset("ATLAS", "images/inventoryimages/yellowcrystal_map.xml"),
    Asset("IMAGE", "images/inventoryimages/yellowcrystal_map.tex"),
	Asset("ATLAS", "images/inventoryimages/limetree_map.xml"),
    Asset("IMAGE", "images/inventoryimages/limetree_map.tex"),

}

--GLOBAL.STRINGS.NAMES.TURF_TEST = "Test Turf"

AddMinimapAtlas("images/inventoryimages/extractor.xml")
AddMinimapAtlas("images/inventoryimages/wheat_map.xml")
AddMinimapAtlas("images/inventoryimages/nuttree_map.xml")
AddMinimapAtlas("images/inventoryimages/bluecrystal_map.xml")
AddMinimapAtlas("images/inventoryimages/redcrystal_map.xml")
AddMinimapAtlas("images/inventoryimages/orangecrystal_map.xml")
AddMinimapAtlas("images/inventoryimages/greencrystal_map.xml")
AddMinimapAtlas("images/inventoryimages/yellowcrystal_map.xml")
AddMinimapAtlas("images/inventoryimages/limetree_map.xml")


else


PrefabFiles = {
	"extractor",
	"mosquito_milk",
	"smokeex",
	"wheat",
	"dug_wheat",
	"cut_wheat",
	"flour",
	"bread",
	"wheat_planted",
	"cheese",
	"fernspinach",
	"houndhead",
	"bonearmor",
	"bonehelm",
	"bones",
	"bananapie",
	"shelldust",
	"mushroomsoup",
	"nuttree",
	"nuts",
	"nuts_cooked",
	"rocksalt",
	"saltnugget",
	"salt",
	"oversalt",
	"truffles_planted",
	"truffles",
	"truffles_cooked",
	"transtruffles",
	"spiderhead",
	"spiderhelm",
	"truffleham",
	"truffleegs",
	--"cactus_cocktail",
	--"ribs",
	"pancakes",
	"queenhelm",
	"gray_crystal",
	"lightingstaff",
	"grayamulet",
	"crystals",
	"minhibitor",
	"lemon_cocktail",
}

local assets=
{
-- Map Icon -------------------------------------------------
    Asset("ATLAS", "images/inventoryimages/extractor.xml"),
    Asset("IMAGE", "images/inventoryimages/extractor.tex"),
	Asset("ATLAS", "images/inventoryimages/wheat_map.xml"),
    Asset("IMAGE", "images/inventoryimages/wheat_map.tex"),
	Asset("ATLAS", "images/inventoryimages/nuttree_map.xml"),
    Asset("IMAGE", "images/inventoryimages/nuttree_map.tex"),
	Asset("ATLAS", "images/inventoryimages/bluecrystal_map.xml"),
    Asset("IMAGE", "images/inventoryimages/bluecrystal_map.tex"),
	Asset("ATLAS", "images/inventoryimages/redcrystal_map.xml"),
    Asset("IMAGE", "images/inventoryimages/redcrystal_map.tex"),
	Asset("ATLAS", "images/inventoryimages/orangecrystal_map.xml"),
    Asset("IMAGE", "images/inventoryimages/orangecrystal_map.tex"),
	Asset("ATLAS", "images/inventoryimages/greencrystal_map.xml"),
    Asset("IMAGE", "images/inventoryimages/greencrystal_map.tex"),
	Asset("ATLAS", "images/inventoryimages/yellowcrystal_map.xml"),
    Asset("IMAGE", "images/inventoryimages/yellowcrystal_map.tex"),


}


AddMinimapAtlas("images/inventoryimages/extractor.xml")
AddMinimapAtlas("images/inventoryimages/wheat_map.xml")
AddMinimapAtlas("images/inventoryimages/nuttree_map.xml")
AddMinimapAtlas("images/inventoryimages/bluecrystal_map.xml")
AddMinimapAtlas("images/inventoryimages/redcrystal_map.xml")
AddMinimapAtlas("images/inventoryimages/orangecrystal_map.xml")
AddMinimapAtlas("images/inventoryimages/greencrystal_map.xml")
AddMinimapAtlas("images/inventoryimages/yellowcrystal_map.xml")


end
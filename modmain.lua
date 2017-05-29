modimport("scripts/prefabs.lua")

modimport("scripts/extractt.lua")
modimport("scripts/tinyitems.lua")
modimport("scripts/tinyrecipes.lua")
modimport("scripts/lootdropperzero.lua")

local require = GLOBAL.require
require "tinystrings"

AddSimPostInit(function(inst)
	local oldactionstringoverride = inst.ActionStringOverride
	function inst:ActionStringOverride(bufaction)
		if bufaction.action == GLOBAL.ACTIONS.EAT and bufaction.invobject and bufaction.invobject.prefab == "minhibitor" then
			return "Take Medicine"
		end
		if bufaction.action == GLOBAL.ACTIONS.USEITEM and bufaction.invobject and bufaction.invobject.prefab == "waterbottle" then
			return "Empty"
		end
		
		if oldactionstringoverride then
			return oldactionstringoverride(inst, bufaction)
		end
	end
end)

local function rpghudcompatible(inst) 
	inst.components.equippable.equipslot = GLOBAL.EQUIPSLOTS.NECK
end 

--Transmutable Gold Nugget
local function AddGoldTrans(inst)
	inst:AddComponent("extractable")
        inst.components.extractable.product = "coppernugget"
end

local function AddCoppTrans(inst)
	inst:AddComponent("extractable")
        inst.components.extractable.product = "goldnugget"
end

for _, moddir in ipairs(GLOBAL.KnownModIndex:GetModsToLoad()) do 
if GLOBAL.KnownModIndex:GetModInfo(moddir).name == "RPG HUD" then 
AddPrefabPostInit("grayamulet", rpghudcompatible)
--AddPrefabPostInit("forcefieldn", rpghudcompatible) 
end 
end

for _, moddir in ipairs(GLOBAL.KnownModIndex:GetModsToLoad()) do 
if GLOBAL.KnownModIndex:GetModInfo(moddir).name == "Steam Biome" then 
AddPrefabPostInit("goldnugget", AddGoldTrans)
AddPrefabPostInit("coppernugget", AddCoppTrans) 
end 
end


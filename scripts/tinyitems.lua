local RECIPETABS = GLOBAL.RECIPETABS
local TECH = GLOBAL.TECH

local function AddWaterFill(inst)

	local function ChangeBottle(inst)
 
		if inst:HasTag("aquatic") then
			local fullbottle = GLOBAL.SpawnPrefab("waterbottle")
			fullbottle.Transform:SetPosition(inst.Transform:GetWorldPosition())
			fullbottle.AnimState:PlayAnimation("idle_water")
			inst:Remove()

		end
	end

	local function fullcheck(inst)
	
		local CheckTime = 1.5

		inst.checkwater = inst:DoPeriodicTask(CheckTime, function() ChangeBottle(inst) end)

	end

	if not inst.checkwater then
		fullcheck(inst)
	end
	
	if inst.components.stackable then
		inst:RemoveComponent("stackable")
	end


end

AddPrefabPostInit("messagebottleempty", AddWaterFill)

local function AddNightmareChargerer(inst)
		inst:AddComponent("chargering")    
		inst.components.chargering.nightmarevalue = 1
end

AddPrefabPostInit("nightmarefuel", AddNightmareChargerer)

--Drop Loot Hound Head
local function AddHoundLoot(prefab)
	prefab.components.lootdropper:AddChanceLoot('houndhead',.2)
end

AddPrefabPostInit("hound", AddHoundLoot)

--Drop Loot Bones from Basilisk
if GLOBAL.IsDLCEnabled(GLOBAL.REIGN_OF_GIANTS) then 
local function AddBasilLoot(prefab)
	prefab.components.lootdropper:AddChanceLoot('boneshard',.2)
end

AddPrefabPostInit("bat", AddBasilLoot)

else

local function AddBasilLoot(prefab)
	prefab.components.lootdropper:AddChanceLoot('bones',.2)
end

AddPrefabPostInit("bat", AddBasilLoot)
end

--Drop Loot Spitter Head
local function AddSpitterLoot(prefab)
	prefab.components.lootdropper:AddChanceLoot('spiderhead',.3)
end

AddPrefabPostInit("spider_spitter", AddSpitterLoot)

--Drop Loot more Milk from Goat
if GLOBAL.IsDLCEnabled(GLOBAL.REIGN_OF_GIANTS) or GLOBAL.IsDLCEnabled(GLOBAL.CAPY_DLC) then  
local function AddGoatLoot(prefab)
	prefab.components.lootdropper:AddChanceLoot('goatmilk',1.0)
	prefab.components.lootdropper:AddChanceLoot('goatmilk',1.0)
	prefab.components.lootdropper:AddChanceLoot('goatmilk',1.0)
end

AddPrefabPostInit("lightninggoat", AddGoatLoot)
end

if GLOBAL.IsDLCEnabled(GLOBAL.REIGN_OF_GIANTS) or GLOBAL.IsDLCEnabled(GLOBAL.CAPY_DLC) then 
--Drop Loot Bones from Warg
local function AddWargLoot(prefab)
	prefab.components.lootdropper:AddChanceLoot('boneshard',1.0)
	prefab.components.lootdropper:AddChanceLoot('boneshard',1.0)
	prefab.components.lootdropper:AddChanceLoot('boneshard',1.0)
	prefab.components.lootdropper:AddChanceLoot('boneshard',0.5)
	prefab.components.lootdropper:AddChanceLoot('boneshard',0.3)
end

AddPrefabPostInit("warg", AddWargLoot)
end


-- Tranmutable Spider Hat
local function AddQueenTrans(inst)
	inst:AddComponent("extractable")
        inst.components.extractable.product = "queenhelm"
end

AddPrefabPostInit("spiderhat", AddQueenTrans)

--Transmutable Puple Gem
local function AddPurpleGemTrans(inst)
	inst:AddComponent("extractable")
         inst.components.extractable.product = "gray_crystal"
end

AddPrefabPostInit("purplegem", AddPurpleGemTrans)

--Transmutable Shell Pieces
local function AddSnurtleShellTrans(inst)
	inst:AddComponent("extractable")
        inst.components.extractable.product = "shelldust"
end

AddPrefabPostInit("slurtle_shellpieces", AddSnurtleShellTrans)

--Transmutable Mosquito


local function AddMosquitoTrans(inst)
	inst:AddComponent("extractable")
        inst.components.extractable.product = "mosquito_milk"
end

AddPrefabPostInit("mosquito", AddMosquitoTrans)
AddPrefabPostInit("mosquito_poison", AddMosquitoTrans)

if GLOBAL.IsDLCEnabled(GLOBAL.REIGN_OF_GIANTS) or GLOBAL.IsDLCEnabled(GLOBAL.CAPY_DLC) then
local function AddSeaweedTrans(inst)
	inst:AddComponent("extractable")
        inst.components.extractable.product = "seaweedflour"
end

AddPrefabPostInit("seaweed", AddSeaweedTrans)
AddPrefabPostInit("seaweed_cooked", AddSeaweedTrans)
AddPrefabPostInit("seaweed_dried", AddSeaweedTrans)
end

--Transmutable Rabbit
if GLOBAL.IsDLCEnabled(GLOBAL.REIGN_OF_GIANTS) then
  

else
local function AddRabbitTrans(inst)
	inst:AddComponent("extractable")
        inst.components.extractable.product = "bones"
end

AddPrefabPostInit("rabbit", AddRabbitTrans)
end

-- Bone Armor recipe
if GLOBAL.IsDLCEnabled(GLOBAL.REIGN_OF_GIANTS) or GLOBAL.IsDLCEnabled(GLOBAL.CAPY_DLC) then
local crafting_recipe5 = Recipe("bonearmor", {Ingredient("boneshard", 6) ,Ingredient("silk", 6)}, RECIPETABS.WAR, {SCIENCE=1})
crafting_recipe5.atlas = "images/inventoryimages/bonearmor.xml"

else

local bones = Ingredient("bones", 6)
bones.atlas = "images/inventoryimages/bones.xml"

local crafting_recipe5 = Recipe("bonearmor", {bones ,Ingredient("silk", 6)}, RECIPETABS.WAR, {SCIENCE=1})
crafting_recipe5.atlas = "images/inventoryimages/bonearmor.xml"

end

-- Lightningstaff recipe
if GLOBAL.IsDLCEnabled(GLOBAL.REIGN_OF_GIANTS) then
local gray_crystal = Ingredient("gray_crystal", 2)
gray_crystal.atlas = "images/inventoryimages/gray_crystal.xml"

local crafting_recipe6 = Recipe("lightingstaff", {Ingredient("charcoal", 6) ,Ingredient("lightninggoathorn", 1), gray_crystal}, RECIPETABS.MAGIC, {MAGIC=3})
crafting_recipe6.atlas = "images/inventoryimages/lightingstaff.xml"

else

local gray_crystal = Ingredient("gray_crystal", 2)
gray_crystal.atlas = "images/inventoryimages/gray_crystal.xml"

local crafting_recipe6 = Recipe("lightingstaff", {Ingredient("charcoal", 6) ,Ingredient("livinglog", 2), gray_crystal}, RECIPETABS.MAGIC, {MAGIC=3})
crafting_recipe6.atlas = "images/inventoryimages/lightingstaff.xml"

end

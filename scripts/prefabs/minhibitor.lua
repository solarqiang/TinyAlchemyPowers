local assets=
{
    Asset("ANIM", "anim/minhibitor.zip"),						-- Animation Zip
    Asset("ATLAS", "images/inventoryimages/minhibitor.xml"),	-- Atlas for inventory TEX
    Asset("IMAGE", "images/inventoryimages/minhibitor.tex"),	-- TEX for inventory
}

local function fn(Sim)
	-- Create a new entity
	local inst = CreateEntity()
	inst.entity:AddTransform()
	inst.entity:AddAnimState()
	MakeInventoryPhysics(inst)
	
	-- Set animation info
	inst.AnimState:SetBuild("minhibitor")
	inst.AnimState:SetBank("minhibitor")
	inst.AnimState:PlayAnimation("idle")
	
	if IsDLCEnabled(CAPY_DLC) then
	MakeInventoryFloatable(inst, "idle_water", "idle")
	end
	
	-- Make it edible
	inst:AddComponent("edible")
	inst.components.edible.foodtype = "MEAT"
	inst.components.edible.healthvalue =  -30	-- Amount to heal
	inst.components.edible.hungervalue =  -10	-- Amount to fill belly
	inst.components.edible.sanityvalue =  50	-- Amount to help Sanity
	
	-- Make it stackable
	inst:AddComponent("stackable")
	inst.components.stackable.maxsize = TUNING.STACK_SIZE_SMALLITEM
	
	-- Make it inspectable
	inst:AddComponent("inspectable")
	
	inst:AddComponent("tradable")
	
	-- Make it an inventory item
	inst:AddComponent("inventoryitem")
    inst.components.inventoryitem.imagename = "minhibitor"	-- Use our TEX sprite
    inst.components.inventoryitem.atlasname = "images/inventoryimages/minhibitor.xml"	-- here's the atlas for our tex
	
	
	return inst
end

STRINGS.NAMES.MINHIBITOR = "Mental Inhibitor"
STRINGS.RECIPE_DESC.MINHIBITOR = "Heals mind, but not the body."
STRINGS.CHARACTERS.GENERIC.DESCRIBE.MINHIBITOR = {	
	"For the glory of science!",

}
STRINGS.CHARACTERS.WX78.DESCRIBE.MINHIBITOR = {	
	"PROCESSING UNIT DEFRAGMENTATION",

}

if IsDLCEnabled(CAPY_DLC) then
local crafting_recipe = Recipe("minhibitor", {Ingredient("mosquitosack_yellow", 1) ,Ingredient("nitre", 1) ,Ingredient("ash", 1)}, RECIPETABS.SURVIVAL, {SCIENCE=1})
crafting_recipe.atlas = "images/inventoryimages/minhibitor.xml"
else
local crafting_recipe = Recipe("minhibitor", {Ingredient("mosquitosack", 1) ,Ingredient("nitre", 1) ,Ingredient("ash", 1)}, RECIPETABS.SURVIVAL, {SCIENCE=1})
crafting_recipe.atlas = "images/inventoryimages/minhibitor.xml"
end
-- Return our prefab
return Prefab( "common/inventory/minhibitor", fn, assets)
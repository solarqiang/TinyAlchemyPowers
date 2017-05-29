local assets=
{
    Asset("ANIM", "anim/lime_cooked.zip"),						-- Animation Zip
    Asset("ATLAS", "images/inventoryimages/lime_cooked.xml"),	-- Atlas for inventory TEX
    Asset("IMAGE", "images/inventoryimages/lime_cooked.tex"),	-- TEX for inventory
}

local function fn(Sim)
	-- Create a new entity
	local inst = CreateEntity()
	inst.entity:AddTransform()
	inst.entity:AddAnimState()
	MakeInventoryPhysics(inst)
	
	-- Set animation info
	inst.AnimState:SetBuild("lime_cooked")
	inst.AnimState:SetBank("lime_cooked")
	inst.AnimState:PlayAnimation("idle")
	
	if IsDLCEnabled(CAPY_DLC) then
	MakeInventoryFloatable(inst, "idle_water", "idle")
	end
	
	-- Make it edible
	inst:AddComponent("edible")
	inst.components.edible.healthvalue =  TUNING.HEALING_TINY	-- Amount to heal
	inst.components.edible.hungervalue =  TUNING.CALORIES_TINY	-- Amount to fill belly
	inst.components.edible.sanityvalue = 0	-- Amount to help Sanity
	
	-- Make it perishable
	inst:AddComponent("perishable")
	inst.components.perishable:SetPerishTime(TUNING.PERISH_FAST)
	inst.components.perishable:StartPerishing()
	inst.components.perishable.onperishreplacement = "spoiled_food"
	
	-- Make it stackable
	inst:AddComponent("stackable")
	inst.components.stackable.maxsize = TUNING.STACK_SIZE_SMALLITEM
	
	-- Make it inspectable
	inst:AddComponent("inspectable")
	
	inst:AddComponent("tradable")
	
	-- Make it an inventory item
	inst:AddComponent("inventoryitem")
    inst.components.inventoryitem.imagename = "lime_cooked"	-- Use our TEX sprite
    inst.components.inventoryitem.atlasname = "images/inventoryimages/lime_cooked.xml"	-- here's the atlas for our tex
	
	
	return inst
end

STRINGS.NAMES.LIME_COOKED = "Warm Lime"

-- Randomizes the inspection line upon inspection.
STRINGS.CHARACTERS.GENERIC.DESCRIBE.LIME_COOKED = {	
	"Warm...",
}
STRINGS.CHARACTERS.WX78.DESCRIBE.LIME_COOKED = {	
	"WHERE IS TASTE?",

}

AddIngredientValues({"lime_cooked"}, {fruit=1}, true)

-- Return our prefab
return Prefab( "common/inventory/lime_cooked", fn, assets)
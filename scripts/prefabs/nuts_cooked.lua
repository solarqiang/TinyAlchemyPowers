local assets=
{
    Asset("ANIM", "anim/nuts_cooked.zip"),						-- Animation Zip
    Asset("ATLAS", "images/inventoryimages/nuts_cooked.xml"),	-- Atlas for inventory TEX
    Asset("IMAGE", "images/inventoryimages/nuts_cooked.tex"),	-- TEX for inventory
}

local function fn(Sim)
	-- Create a new entity
	local inst = CreateEntity()
	inst.entity:AddTransform()
	inst.entity:AddAnimState()
	MakeInventoryPhysics(inst)
	
	-- Set animation info
	inst.AnimState:SetBuild("nuts_cooked")
	inst.AnimState:SetBank("nuts_cooked")
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
    inst.components.inventoryitem.imagename = "nuts_cooked"	-- Use our TEX sprite
    inst.components.inventoryitem.atlasname = "images/inventoryimages/nuts_cooked.xml"	-- here's the atlas for our tex
	
	
	return inst
end

STRINGS.NAMES.NUTS_COOKED = "Warm Lemon"

-- Randomizes the inspection line upon inspection.
STRINGS.CHARACTERS.GENERIC.DESCRIBE.NUTS_COOKED = {	
	"At least not as sour",
}
STRINGS.CHARACTERS.WX78.DESCRIBE.NUTS_COOKED = {	
	"WHERE IS TASTE?",

}

AddIngredientValues({"nuts_cooked"}, {fruit=1}, true)

-- Return our prefab
return Prefab( "common/inventory/nuts_cooked", fn, assets)
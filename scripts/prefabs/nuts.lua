local assets=
{
    Asset("ANIM", "anim/nuts.zip"),						-- Animation Zip
    Asset("ATLAS", "images/inventoryimages/nuts.xml"),	-- Atlas for inventory TEX
    Asset("IMAGE", "images/inventoryimages/nuts.tex"),	-- TEX for inventory
}

local function fn(Sim)
	-- Create a new entity
	local inst = CreateEntity()
	inst.entity:AddTransform()
	inst.entity:AddAnimState()
	MakeInventoryPhysics(inst)
	
	-- Set animation info
	inst.AnimState:SetBuild("nuts")
	inst.AnimState:SetBank("nuts")
	inst.AnimState:PlayAnimation("idle")
	
	if IsDLCEnabled(CAPY_DLC) then
	MakeInventoryFloatable(inst, "idle_water", "idle")
	end
	
	-- Make it edible
	inst:AddComponent("edible")
	inst.components.edible.healthvalue =  TUNING.HEALING_SMALL	-- Amount to heal
	inst.components.edible.hungervalue =  TUNING.CALORIES_TINY	-- Amount to fill belly
	inst.components.edible.sanityvalue =  -TUNING.SANITY_TINY	-- Amount to help Sanity
	
	-- Make it perishable
	inst:AddComponent("perishable")
	inst.components.perishable:SetPerishTime(TUNING.PERISH_MED)
	inst.components.perishable:StartPerishing()
	inst.components.perishable.onperishreplacement = "spoiled_food"
	
	-- Make it stackable
	inst:AddComponent("stackable")
	inst.components.stackable.maxsize = TUNING.STACK_SIZE_SMALLITEM
	
	-- Make it inspectable
	inst:AddComponent("inspectable")
	
	inst:AddComponent("tradable")
	
	inst:AddComponent("cookable")
	inst.components.cookable.product = "nuts_cooked"
	
	-- Make it an inventory item
	inst:AddComponent("inventoryitem")
    inst.components.inventoryitem.imagename = "nuts"	-- Use our TEX sprite
    inst.components.inventoryitem.atlasname = "images/inventoryimages/nuts.xml"	-- here's the atlas for our tex
	
	
	return inst
end

STRINGS.NAMES.NUTS = "Lemon"

-- Randomizes the inspection line upon inspection.
STRINGS.CHARACTERS.GENERIC.DESCRIBE.NUTS = {	
	"Eat lemons? I'm not a masochist.",
}
STRINGS.CHARACTERS.WX78.DESCRIBE.NUTS = {	
	"IT'S... GOOD",

}

AddIngredientValues({"nuts"}, {fruit=1}, true)

-- Return our prefab
return Prefab( "common/inventory/nuts", fn, assets)
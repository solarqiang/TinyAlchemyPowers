local assets=
{
    Asset("ANIM", "anim/mosquito_milk.zip"),						-- Animation Zip
    Asset("ATLAS", "images/inventoryimages/mosquito_milk.xml"),	-- Atlas for inventory TEX
    Asset("IMAGE", "images/inventoryimages/mosquito_milk.tex"),	-- TEX for inventory
}

local function fn(Sim)
	-- Create a new entity
	local inst = CreateEntity()
	inst.entity:AddTransform()
	inst.entity:AddAnimState()
	MakeInventoryPhysics(inst)
	
	-- Set animation info
	inst.AnimState:SetBuild("mosquito_milk")
	inst.AnimState:SetBank("mosquito_milk")
	inst.AnimState:PlayAnimation("idle")
	
	-- Make it edible
	inst:AddComponent("edible")
	inst.components.edible.healthvalue = -TUNING.HEALING_SMALL	-- Amount to heal
	inst.components.edible.hungervalue =  TUNING.CALORIES_SMALL	-- Amount to fill belly
	inst.components.edible.sanityvalue = -TUNING.SANITY_SMALL	-- Amount to help Sanity
	
	-- Make it perishable
	inst:AddComponent("perishable")
	inst.components.perishable:SetPerishTime(TUNING.PERISH_SLOW)
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
    inst.components.inventoryitem.imagename = "mosquito_milk"	-- Use our TEX sprite
    inst.components.inventoryitem.atlasname = "images/inventoryimages/mosquito_milk.xml"	-- here's the atlas for our tex
	
	
	return inst
end

STRINGS.NAMES.MOSQUITO_MILK = "Mosquito Milk"

-- Randomizes the inspection line upon inspection.
STRINGS.CHARACTERS.GENERIC.DESCRIBE.MOSQUITO_MILK = {	
	"Milk? Really?",
	"This gelatinous substance doesn't look very tasty...",
}
STRINGS.CHARACTERS.WX78.DESCRIBE.MOSQUITO_MILK = {	
	"CONSISTENCY: GELATINOUS",

}

AddIngredientValues({"mosquito_milk"}, {dairy=1})

-- Return our prefab
return Prefab( "common/inventory/mosquito_milk", fn, assets)
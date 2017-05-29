local assets=
{
    Asset("ANIM", "anim/truffles.zip"),						-- Animation Zip
    Asset("ATLAS", "images/inventoryimages/truffles_cooked.xml"),	-- Atlas for inventory TEX
    Asset("IMAGE", "images/inventoryimages/truffles_cooked.tex"),	-- TEX for inventory
}

local function fn(Sim)
	-- Create a new entity
	local inst = CreateEntity()
	inst.entity:AddTransform()
	inst.entity:AddAnimState()
	MakeInventoryPhysics(inst)
	
	-- Set animation info
	inst.AnimState:SetBuild("truffles")
	inst.AnimState:SetBank("truffles")
	inst.AnimState:PlayAnimation("cooked")
	
	-- Make it edible
	inst:AddComponent("edible")
	inst.components.edible.healthvalue =  TUNING.HEALING_SMALL	-- Amount to heal
	inst.components.edible.hungervalue =  TUNING.CALORIES_SMALL	-- Amount to fill belly
	inst.components.edible.sanityvalue =  TUNING.SANITY_MEDLARGE	-- Amount to help Sanity
	
	-- Make it perishable
	inst:AddComponent("perishable")
	inst.components.perishable:SetPerishTime(TUNING.PERISH_TWO_DAY)
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
    inst.components.inventoryitem.imagename = "truffles_cooked"	-- Use our TEX sprite
    inst.components.inventoryitem.atlasname = "images/inventoryimages/truffles_cooked.xml"	-- here's the atlas for our tex
	
	
	return inst
end

STRINGS.NAMES.TRUFFLES_COOKED = "Cooked Truffles"

-- Randomizes the inspection line upon inspection.
STRINGS.CHARACTERS.GENERIC.DESCRIBE.TRUFFLES_COOKED = {	
	"They smell much stronger than fresh truffles.",
	"A rarity among mushrooms",
	"Why they spoiled so fast?",
}
STRINGS.CHARACTERS.WX78.DESCRIBE.TRUFFLES_COOKED = {	
	"AROMATIC FOOD MATERIAL",

}


AddIngredientValues({"truffles_cooked"}, {truffles=1})

-- Return our prefab
return Prefab( "common/inventory/truffles_cooked", fn, assets)
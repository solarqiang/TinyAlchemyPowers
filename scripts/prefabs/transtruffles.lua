local assets=
{
    Asset("ANIM", "anim/transtruffles.zip"),						-- Animation Zip
    Asset("ATLAS", "images/inventoryimages/transtruffles.xml"),	-- Atlas for inventory TEX
    Asset("IMAGE", "images/inventoryimages/transtruffles.tex"),	-- TEX for inventory
}

local function fn(Sim)
	-- Create a new entity
	local inst = CreateEntity()
	inst.entity:AddTransform()
	inst.entity:AddAnimState()
	MakeInventoryPhysics(inst)
	
	-- Set animation info
	inst.AnimState:SetBuild("transtruffles")
	inst.AnimState:SetBank("transtruffles")
	inst.AnimState:PlayAnimation("idle")
	
	-- Make it edible
	inst:AddComponent("edible")
	inst.components.edible.healthvalue =  TUNING.HEALING_TINY	-- Amount to heal
	inst.components.edible.hungervalue =  TUNING.CALORIES_SMALL	-- Amount to fill belly
	inst.components.edible.sanityvalue =  TUNING.SANITY_SMALL	-- Amount to help Sanity
	
	-- Make it perishable
	inst:AddComponent("perishable")
	inst.components.perishable:SetPerishTime(TUNING.PERISH_PRESERVED)
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
    inst.components.inventoryitem.imagename = "transtruffles"	-- Use our TEX sprite
    inst.components.inventoryitem.atlasname = "images/inventoryimages/transtruffles.xml"	-- here's the atlas for our tex
	
	
	return inst
end

STRINGS.NAMES.TRANSTRUFFLES = "Transmuted Truffles"

-- Randomizes the inspection line upon inspection.
STRINGS.CHARACTERS.GENERIC.DESCRIBE.TRANSTRUFFLES = {	
	"Very aromatic",
	"A rarity among mushrooms",
	"Now I can store them",
}

STRINGS.CHARACTERS.WX78.DESCRIBE.TRANSTRUFFLES = {	
	"AROMATIC FOOD MATERIAL",

}

AddIngredientValues({"transtruffles"}, {truffles=1})

-- Return our prefab
return Prefab( "common/inventory/transtruffles", fn, assets)
local assets=
{
	Asset("ANIM", "anim/truffleegs.zip"),
	Asset("ATLAS", "images/inventoryimages/truffleegs.xml"),	-- Atlas for inventory TEX
    Asset("IMAGE", "images/inventoryimages/truffleegs.tex")
}

local prefabs = 
{
	"spoiled_food",
}

local function fn(Sim)
	local inst = CreateEntity()
	inst.entity:AddTransform()
	inst.entity:AddAnimState()
    
    MakeInventoryPhysics(inst)
    
    inst.AnimState:SetBank("truffleegs")
    inst.AnimState:SetBuild("truffleegs")
    inst.AnimState:PlayAnimation("idle")
    
    inst:AddComponent("stackable")
	inst.components.stackable.maxsize = TUNING.STACK_SIZE_SMALLITEM

    inst:AddComponent("inspectable")
    
    inst:AddComponent("inventoryitem")
	inst.components.inventoryitem.imagename = "truffleegs"
	inst.components.inventoryitem.atlasname = "images/inventoryimages/truffleegs.xml"
	
--[[	inst:AddComponent("harvestable")
	inst.components.stewer.product.imagename = "butter"
	inst.components.stewer.product.atlasname = "images/inventoryimages/butter.xml"
	]]
	 
    inst:AddComponent("edible")
	inst.components.edible.foodtype = "MEAT"
    inst.components.edible.healthvalue = TUNING.HEALING_MEDSMALL
    inst.components.edible.hungervalue = TUNING.CALORIES_HUGE
	inst.components.edible.sanityvalue = TUNING.SANITY_LARGE
	
	inst:AddComponent("perishable")
	inst.components.perishable:SetPerishTime(TUNING.PERISH_PRESERVED)
	inst.components.perishable:StartPerishing()
	inst.components.perishable.onperishreplacement = "spoiled_food"
	
	inst:AddComponent("tradable")
	
    
    return inst
end

STRINGS.NAMES.TRUFFLEEGS = "Eggs and Truffles"

-- Randomizes the inspection line upon inspection.
STRINGS.CHARACTERS.GENERIC.DESCRIBE.TRUFFLEEGS = {	
	"I cooked it myself!",
	"Aromatic and delicious!",

}
STRINGS.CHARACTERS.WX78.DESCRIBE.TRUFFLEEGS = {	
	"UPGRADED FOOD MATERIAL",

}

return Prefab( "common/inventory/truffleegs", fn, assets, prefabs) 

local assets=
{
	Asset("ANIM", "anim/truffleham.zip"),
	Asset("ATLAS", "images/inventoryimages/truffleham.xml"),	-- Atlas for inventory TEX
    Asset("IMAGE", "images/inventoryimages/truffleham.tex")
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
    
    inst.AnimState:SetBank("truffleham")
    inst.AnimState:SetBuild("truffleham")
    inst.AnimState:PlayAnimation("idle")
    
    inst:AddComponent("stackable")
	inst.components.stackable.maxsize = TUNING.STACK_SIZE_SMALLITEM

    inst:AddComponent("inspectable")
    
    inst:AddComponent("inventoryitem")
	inst.components.inventoryitem.imagename = "truffleham"
	inst.components.inventoryitem.atlasname = "images/inventoryimages/truffleham.xml"
	
--[[	inst:AddComponent("harvestable")
	inst.components.stewer.product.imagename = "butter"
	inst.components.stewer.product.atlasname = "images/inventoryimages/butter.xml"
	]]
	 
    inst:AddComponent("edible")
	inst.components.edible.foodtype = "MEAT"
    inst.components.edible.healthvalue = TUNING.HEALING_MED
    inst.components.edible.hungervalue = TUNING.CALORIES_HUGE
	inst.components.edible.sanityvalue = TUNING.SANITY_LARGE
	
	inst:AddComponent("perishable")
	inst.components.perishable:SetPerishTime(TUNING.PERISH_SLOW)
	inst.components.perishable:StartPerishing()
	inst.components.perishable.onperishreplacement = "spoiled_food"
	
	inst:AddComponent("tradable")
	
    
    return inst
end

STRINGS.NAMES.TRUFFLEHAM = "Truffle Ham"

-- Randomizes the inspection line upon inspection.
STRINGS.CHARACTERS.GENERIC.DESCRIBE.TRUFFLEHAM = {	
	"I cooked it myself!",
	"Aromatic and delicious!",

}
STRINGS.CHARACTERS.WX78.DESCRIBE.TRUFFLEHAM = {	
	"UPGRADED FOOD MATERIAL",

}

return Prefab( "common/inventory/truffleham", fn, assets, prefabs) 

local assets=
{
	Asset("ANIM", "anim/ribs.zip"),
	Asset("ATLAS", "images/inventoryimages/ribs.xml"),	-- Atlas for inventory TEX
    Asset("IMAGE", "images/inventoryimages/ribs.tex")
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
    
    inst.AnimState:SetBank("ribs")
    inst.AnimState:SetBuild("ribs")
    inst.AnimState:PlayAnimation("idle")
    
    inst:AddComponent("stackable")
	inst.components.stackable.maxsize = TUNING.STACK_SIZE_SMALLITEM

    inst:AddComponent("inspectable")
    
    inst:AddComponent("inventoryitem")
	inst.components.inventoryitem.imagename = "ribs"
	inst.components.inventoryitem.atlasname = "images/inventoryimages/ribs.xml"
	
--[[	inst:AddComponent("harvestable")
	inst.components.stewer.product.imagename = "butter"
	inst.components.stewer.product.atlasname = "images/inventoryimages/butter.xml"
	]]
	inst:AddComponent("tradable")
	
    inst:AddComponent("edible")
	inst.components.edible.foodtype = "MEAT"
    inst.components.edible.healthvalue = TUNING.HEALING_MED
    inst.components.edible.hungervalue = TUNING.CALORIES_HUGE
	inst.components.edible.sanityvalue = TUNING.SANITY_MEDLARGE
	
	inst:AddComponent("perishable")
	inst.components.perishable:SetPerishTime(TUNING.PERISH_SLOW)
	inst.components.perishable:StartPerishing()
	inst.components.perishable.onperishreplacement = "spoiled_food"
	
    
    return inst
end

STRINGS.NAMES.RIBS = "Ribs in Cactus Sauce"

-- Randomizes the inspection line upon inspection.
STRINGS.CHARACTERS.GENERIC.DESCRIBE.RIBS = {	
	"I cooked it myself!",
}
STRINGS.CHARACTERS.WX78.DESCRIBE.ROCKSALT = {	
	"UPGRADED FOOD MATERIAL",

}

return Prefab( "common/inventory/ribs", fn, assets, prefabs) 

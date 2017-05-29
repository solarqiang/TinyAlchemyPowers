local assets=
{
	Asset("ANIM", "anim/bread.zip"),
	Asset("ATLAS", "images/inventoryimages/bread.xml"),	-- Atlas for inventory TEX
    Asset("IMAGE", "images/inventoryimages/bread.tex")
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
    
    inst.AnimState:SetBank("bread")
    inst.AnimState:SetBuild("bread")
    inst.AnimState:PlayAnimation("idle")

	if IsDLCEnabled(CAPY_DLC) then
	MakeInventoryFloatable(inst, "idle_water", "idle")
	
	end	
 
    inst:AddComponent("stackable")
	inst.components.stackable.maxsize = TUNING.STACK_SIZE_SMALLITEM

    inst:AddComponent("inspectable")
    
    inst:AddComponent("inventoryitem")
	inst.components.inventoryitem.imagename = "bread"
	inst.components.inventoryitem.atlasname = "images/inventoryimages/bread.xml"
	
--[[	inst:AddComponent("harvestable")
	inst.components.stewer.product.imagename = "butter"
	inst.components.stewer.product.atlasname = "images/inventoryimages/butter.xml"
	]]
	
	inst:AddComponent("tradable")
	 
    inst:AddComponent("edible")
    inst.components.edible.healthvalue = TUNING.HEALING_MED
    inst.components.edible.hungervalue = TUNING.CALORIES_MED
	inst.components.edible.sanityvalue = TUNING.SANITY_MEDLARGE*3
	
	inst:AddComponent("perishable")
	inst.components.perishable:SetPerishTime(TUNING.PERISH_MED)
	inst.components.perishable:StartPerishing()
	inst.components.perishable.onperishreplacement = "spoiled_food"
	
    
    return inst
end

STRINGS.NAMES.BREAD = "Bread"

-- Randomizes the inspection line upon inspection.
STRINGS.CHARACTERS.GENERIC.DESCRIBE.BREAD = {	
	"Soft and warm.",
	"Almost like home ...",
}
STRINGS.CHARACTERS.WX78.DESCRIBE.BREAD = {	
	"HIGHLY EFFICIENT FOOD MATERIAL",

}

return Prefab( "common/inventory/bread", fn, assets, prefabs) 

local assets=
{
	Asset("ANIM", "anim/limpetspizza.zip"),
	Asset("ATLAS", "images/inventoryimages/limpetspizza.xml"),	-- Atlas for inventory TEX
    Asset("IMAGE", "images/inventoryimages/limpetspizza.tex")
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
    
    inst.AnimState:SetBank("limpetspizza")
    inst.AnimState:SetBuild("limpetspizza")
    inst.AnimState:PlayAnimation("idle")

	if IsDLCEnabled(CAPY_DLC) then
	MakeInventoryFloatable(inst, "idle_water", "idle")
	
	end	
 
    inst:AddComponent("stackable")
	inst.components.stackable.maxsize = TUNING.STACK_SIZE_SMALLITEM

    inst:AddComponent("inspectable")
    
    inst:AddComponent("inventoryitem")
	inst.components.inventoryitem.imagename = "limpetspizza"
	inst.components.inventoryitem.atlasname = "images/inventoryimages/limpetspizza.xml"
	
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

STRINGS.NAMES.LIMPETSPIZZA = "Seafood Pizza"

-- Randomizes the inspection line upon inspection.
STRINGS.CHARACTERS.GENERIC.DESCRIBE.LIMPETSPIZZA = {	
	"Yummy.",
	"So...good",
}
STRINGS.CHARACTERS.WX78.DESCRIBE.LIMPETSPIZZA = {	
	"HIGHLY EFFICIENT FOOD MATERIAL",

}

return Prefab( "common/inventory/limpetspizza", fn, assets, prefabs) 

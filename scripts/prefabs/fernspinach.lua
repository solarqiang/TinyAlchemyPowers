local assets=
{
	Asset("ANIM", "anim/fernspinach.zip"),
	Asset("ATLAS", "images/inventoryimages/fernspinach.xml"),	-- Atlas for inventory TEX
    Asset("IMAGE", "images/inventoryimages/fernspinach.tex")
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
    
    inst.AnimState:SetBank("fernspinach")
    inst.AnimState:SetBuild("fernspinach")
    inst.AnimState:PlayAnimation("idle")
 
	if IsDLCEnabled(CAPY_DLC) then
	MakeInventoryFloatable(inst, "idle_water", "idle")
	end
 
    inst:AddComponent("stackable")
	inst.components.stackable.maxsize = TUNING.STACK_SIZE_SMALLITEM

    inst:AddComponent("inspectable")
    
    inst:AddComponent("inventoryitem")
	inst.components.inventoryitem.imagename = "fernspinach"
	inst.components.inventoryitem.atlasname = "images/inventoryimages/fernspinach.xml"
	
--[[	inst:AddComponent("harvestable")
	inst.components.stewer.product.imagename = "butter"
	inst.components.stewer.product.atlasname = "images/inventoryimages/butter.xml"
	]]
	 
    inst:AddComponent("edible")
    inst.components.edible.healthvalue = TUNING.HEALING_SMALL
    inst.components.edible.hungervalue = TUNING.CALORIES_MED
	inst.components.edible.sanityvalue = TUNING.SANITY_TINY

	
	inst:AddComponent("perishable")
	inst.components.perishable:SetPerishTime(TUNING.PERISH_MED)
	inst.components.perishable:StartPerishing()
	inst.components.perishable.onperishreplacement = "spoiled_food"
	
	inst:AddComponent("tradable")
    
    return inst
end

STRINGS.NAMES.FERNSPINACH = "Fern Spinach"

-- Randomizes the inspection line upon inspection.
STRINGS.CHARACTERS.GENERIC.DESCRIBE.FERNSPINACH = {	
	"Spinach? Hmmmm...",
	"I can prepare a meal out of everything !",
}
STRINGS.CHARACTERS.WX78.DESCRIBE.FERNSPINACH = {	
	"UPGRADED FOOD MATERIAL",

}

return Prefab( "common/inventory/fernspinach", fn, assets, prefabs) 

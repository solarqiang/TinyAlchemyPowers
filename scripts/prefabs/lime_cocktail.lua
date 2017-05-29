local assets=
{
	Asset("ANIM", "anim/lime_cocktail.zip"),
	Asset("ATLAS", "images/inventoryimages/lime_cocktail.xml"),	-- Atlas for inventory TEX
    Asset("IMAGE", "images/inventoryimages/lime_cocktail.tex")
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
    
    inst.AnimState:SetBank("lime_cocktail")
    inst.AnimState:SetBuild("lime_cocktail")
    inst.AnimState:PlayAnimation("idle")
	
	if IsDLCEnabled(CAPY_DLC) then
	MakeInventoryFloatable(inst, "idle_water", "idle")
	end
    
    inst:AddComponent("stackable")
	inst.components.stackable.maxsize = TUNING.STACK_SIZE_SMALLITEM

    inst:AddComponent("inspectable")
    
    inst:AddComponent("inventoryitem")
	inst.components.inventoryitem.imagename = "lime_cocktail"
	inst.components.inventoryitem.atlasname = "images/inventoryimages/lime_cocktail.xml"
	
--[[	inst:AddComponent("harvestable")
	inst.components.stewer.product.imagename = "butter"
	inst.components.stewer.product.atlasname = "images/inventoryimages/butter.xml"
	]]
	inst:AddComponent("tradable")
	
    inst:AddComponent("edible")
    inst.components.edible.healthvalue = TUNING.HEALING_MEDSMALL
    inst.components.edible.hungervalue = TUNING.CALORIES_SMALL
	inst.components.edible.sanityvalue = TUNING.SANITY_MEDLARGE
	inst.components.edible.temperatureduration = -30
	
	inst:AddComponent("perishable")
	inst.components.perishable:SetPerishTime(TUNING.PERISH_FAST)
	inst.components.perishable:StartPerishing()
	inst.components.perishable.onperishreplacement = "spoiled_food"
	
    
    return inst
end

STRINGS.NAMES.LIME_COCKTAIL = "Lime Cocktail"

-- Randomizes the inspection line upon inspection.
STRINGS.CHARACTERS.GENERIC.DESCRIBE.LIME_COCKTAIL = {
	"Refreshing",
}
STRINGS.CHARACTERS.WX78.DESCRIBE.LIME_COCKTAIL = {	
	"UPGRADED FOOD MATERIAL",
	 
}

return Prefab( "common/inventory/lime_cocktail", fn, assets, prefabs) 

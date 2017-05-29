local assets=
{
	Asset("ANIM", "anim/mushroomsoup.zip"),
	Asset("ATLAS", "images/inventoryimages/mushroomsoup.xml"),	-- Atlas for inventory TEX
    Asset("IMAGE", "images/inventoryimages/mushroomsoup.tex")
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
    
    inst.AnimState:SetBank("mushroomsoup")
    inst.AnimState:SetBuild("mushroomsoup")
    inst.AnimState:PlayAnimation("idle")
	
	if IsDLCEnabled(CAPY_DLC) then
	MakeInventoryFloatable(inst, "idle_water", "idle")
	end
    
    inst:AddComponent("stackable")
	inst.components.stackable.maxsize = TUNING.STACK_SIZE_SMALLITEM

    inst:AddComponent("inspectable")
    
    inst:AddComponent("inventoryitem")
	inst.components.inventoryitem.imagename = "mushroomsoup"
	inst.components.inventoryitem.atlasname = "images/inventoryimages/mushroomsoup.xml"
	
--[[	inst:AddComponent("harvestable")
	inst.components.stewer.product.imagename = "butter"
	inst.components.stewer.product.atlasname = "images/inventoryimages/butter.xml"
	]]
	 
    inst:AddComponent("edible")
    inst.components.edible.healthvalue = TUNING.HEALING_SMALL
    inst.components.edible.hungervalue = TUNING.CALORIES_LARGE
	inst.components.edible.sanityvalue = TUNING.SANITY_TINY
	
	inst:AddComponent("perishable")
	inst.components.perishable:SetPerishTime(TUNING.PERISH_FAST)
	inst.components.perishable:StartPerishing()
	inst.components.perishable.onperishreplacement = "spoiled_food"
	
	inst:AddComponent("tradable")
	
    
    return inst
end

STRINGS.NAMES.MUSHROOMSOUP = "Mushroom Soup"

-- Randomizes the inspection line upon inspection.
STRINGS.CHARACTERS.GENERIC.DESCRIBE.MUSHROOMSOUP = {	
	"Looks good",

}
STRINGS.CHARACTERS.WX78.DESCRIBE.MUSHROOMSOUP = {	
	"UPGRADED FOOD MATERIAL",

}

return Prefab( "common/inventory/mushroomsoup", fn, assets, prefabs) 

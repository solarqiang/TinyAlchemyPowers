local assets=
{
	Asset("ANIM", "anim/nutmuffin.zip"),
	Asset("ATLAS", "images/inventoryimages/nutmuffin.xml"),	-- Atlas for inventory TEX
    Asset("IMAGE", "images/inventoryimages/nutmuffin.tex")
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
    
    inst.AnimState:SetBank("nutmuffin")
    inst.AnimState:SetBuild("nutmuffin")
    inst.AnimState:PlayAnimation("idle")
	
	if IsDLCEnabled(CAPY_DLC) then
	MakeInventoryFloatable(inst, "idle_water", "idle")
	end
    
    inst:AddComponent("stackable")
	inst.components.stackable.maxsize = TUNING.STACK_SIZE_SMALLITEM

    inst:AddComponent("inspectable")
    
    inst:AddComponent("inventoryitem")
	inst.components.inventoryitem.imagename = "nutmuffin"
	inst.components.inventoryitem.atlasname = "images/inventoryimages/nutmuffin.xml"
	
--[[	inst:AddComponent("harvestable")
	inst.components.stewer.product.imagename = "butter"
	inst.components.stewer.product.atlasname = "images/inventoryimages/butter.xml"
	]]
	 
    inst:AddComponent("edible")
    inst.components.edible.healthvalue = TUNING.HEALING_MED
    inst.components.edible.hungervalue = TUNING.CALORIES_LARGE
	inst.components.edible.sanityvalue = TUNING.SANITY_TINY
	
	inst:AddComponent("perishable")
	inst.components.perishable:SetPerishTime(TUNING.PERISH_SLOW)
	inst.components.perishable:StartPerishing()
	inst.components.perishable.onperishreplacement = "spoiled_food"
	
	inst:AddComponent("tradable")
	
    
    return inst
end

STRINGS.NAMES.NUTMUFFIN = "Birchnut Muffin"

-- Randomizes the inspection line upon inspection.
STRINGS.CHARACTERS.GENERIC.DESCRIBE.NUTMUFFIN = {	
	"Light flavor of decadence...",
	"Just good cake.",
}
STRINGS.CHARACTERS.WX78.DESCRIBE.NUTMUFFIN = {	
	"UPGRADED FOOD MATERIAL (TREES NOT FOUND)",

}

return Prefab( "common/inventory/nutmuffin", fn, assets, prefabs) 

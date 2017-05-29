local assets=
{
	Asset("ANIM", "anim/oversalt.zip"),
	Asset("ATLAS", "images/inventoryimages/oversalt.xml"),	-- Atlas for inventory TEX
    Asset("IMAGE", "images/inventoryimages/oversalt.tex")
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
    
    inst.AnimState:SetBank("oversalt")
    inst.AnimState:SetBuild("oversalt")
    inst.AnimState:PlayAnimation("idle")
	
	if IsDLCEnabled(CAPY_DLC) then
	MakeInventoryFloatable(inst, "idle_water", "idle")
	end
    
    inst:AddComponent("stackable")
	inst.components.stackable.maxsize = TUNING.STACK_SIZE_SMALLITEM

    inst:AddComponent("inspectable")
    
    inst:AddComponent("inventoryitem")
	inst.components.inventoryitem.imagename = "oversalt"
	inst.components.inventoryitem.atlasname = "images/inventoryimages/oversalt.xml"
	
--[[	inst:AddComponent("harvestable")
	inst.components.stewer.product.imagename = "butter"
	inst.components.stewer.product.atlasname = "images/inventoryimages/butter.xml"
	]]
	 
    inst:AddComponent("edible")
    inst.components.edible.healthvalue = 0
    inst.components.edible.hungervalue = 0
	inst.components.edible.sanityvalue = 0
	
	inst:AddComponent("perishable")
	inst.components.perishable:SetPerishTime(TUNING.PERISH_FAST)
	inst.components.perishable:StartPerishing()
	inst.components.perishable.onperishreplacement = "spoiled_food"
	
	inst:AddComponent("tradable")
	
    
    return inst
end

STRINGS.NAMES.OVERSALT = "Oversalted Meal"

-- Randomizes the inspection line upon inspection.
STRINGS.CHARACTERS.GENERIC.DESCRIBE.OVERSALT = {	
	"Oversalted...yuck",
	"I don't want to eat that.",
}
STRINGS.CHARACTERS.WX78.DESCRIBE.OVERSALT = {	
	"WASTED FOOD MATERIAL",

}

return Prefab( "common/inventory/oversalt", fn, assets, prefabs) 

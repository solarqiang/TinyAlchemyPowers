local assets=
{
	Asset("ANIM", "anim/cheese.zip"),
	Asset("ATLAS", "images/inventoryimages/cheese.xml"),	-- Atlas for inventory TEX
    Asset("IMAGE", "images/inventoryimages/cheese.tex")
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
    
    inst.AnimState:SetBank("cheese")
    inst.AnimState:SetBuild("cheese")
    inst.AnimState:PlayAnimation("idle")
    
	if IsDLCEnabled(CAPY_DLC) then
	MakeInventoryFloatable(inst, "idle_water", "idle")
	end
	
    inst:AddComponent("stackable")
	inst.components.stackable.maxsize = TUNING.STACK_SIZE_SMALLITEM

    inst:AddComponent("inspectable")
    
    inst:AddComponent("inventoryitem")
	inst.components.inventoryitem.imagename = "cheese"
	inst.components.inventoryitem.atlasname = "images/inventoryimages/cheese.xml"
	
--[[	inst:AddComponent("harvestable")
	inst.components.stewer.product.imagename = "butter"
	inst.components.stewer.product.atlasname = "images/inventoryimages/butter.xml"
	]]
	 
    inst:AddComponent("edible")
    inst.components.edible.healthvalue = TUNING.HEALING_MED
    inst.components.edible.hungervalue = TUNING.CALORIES_LARGE
	
	
	inst:AddComponent("perishable")
	inst.components.perishable:SetPerishTime(TUNING.PERISH_SLOW)
	inst.components.perishable:StartPerishing()
	inst.components.perishable.onperishreplacement = "spoiled_food"
	
	inst:AddComponent("tradable")
    
    return inst
end

STRINGS.NAMES.CHEESE = "Cheese"

-- Randomizes the inspection line upon inspection.
STRINGS.CHARACTERS.GENERIC.DESCRIBE.CHEESE = {	
	"It stinks!",
}
STRINGS.CHARACTERS.WX78.DESCRIBE.CHEESE = {	
	"PUNGENT ODOR.",

}

return Prefab( "common/inventory/cheese", fn, assets, prefabs) 

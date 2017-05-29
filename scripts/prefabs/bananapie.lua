local assets=
{
	Asset("ANIM", "anim/bananapie.zip"),
	Asset("ATLAS", "images/inventoryimages/bananapie.xml"),	-- Atlas for inventory TEX
    Asset("IMAGE", "images/inventoryimages/bananapie.tex")
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
    
    inst.AnimState:SetBank("bananapie")
    inst.AnimState:SetBuild("bananapie")
    inst.AnimState:PlayAnimation("idle")
	
	if IsDLCEnabled(CAPY_DLC) then
	MakeInventoryFloatable(inst, "idle_water", "idle")
	end
    
    inst:AddComponent("stackable")
	inst.components.stackable.maxsize = TUNING.STACK_SIZE_SMALLITEM

    inst:AddComponent("inspectable")
    
    inst:AddComponent("inventoryitem")
	inst.components.inventoryitem.imagename = "bananapie"
	inst.components.inventoryitem.atlasname = "images/inventoryimages/bananapie.xml"
	
--[[	inst:AddComponent("harvestable")
	inst.components.stewer.product.imagename = "butter"
	inst.components.stewer.product.atlasname = "images/inventoryimages/butter.xml"
	]]
	inst:AddComponent("tradable")
	
    inst:AddComponent("edible")
    inst.components.edible.healthvalue = TUNING.HEALING_SMALL*2
    inst.components.edible.hungervalue = TUNING.CALORIES_LARGE
	inst.components.edible.sanityvalue = TUNING.SANITY_MED
	
	inst:AddComponent("perishable")
	inst.components.perishable:SetPerishTime(TUNING.PERISH_SLOW)
	inst.components.perishable:StartPerishing()
	inst.components.perishable.onperishreplacement = "spoiled_food"
	
    
    return inst
end

STRINGS.NAMES.BANANAPIE = "Banana Pie"

-- Randomizes the inspection line upon inspection.
STRINGS.CHARACTERS.GENERIC.DESCRIBE.BANANAPIE = {	
	"It's almost the best cake I've ever eat.",
	"Almost like home ...",
}
STRINGS.CHARACTERS.WX78.DESCRIBE.BANANAPIE = {	
		"CONSISTENCY: UNKNOWN.",

}

return Prefab( "common/inventory/bananapie", fn, assets, prefabs) 

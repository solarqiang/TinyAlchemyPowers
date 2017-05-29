local assets=
{
	Asset("ANIM", "anim/pancakes.zip"),
	Asset("ATLAS", "images/inventoryimages/pancakes.xml"),	-- Atlas for inventory TEX
    Asset("IMAGE", "images/inventoryimages/pancakes.tex")
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
    
    inst.AnimState:SetBank("pancakes")
    inst.AnimState:SetBuild("pancakes")
    inst.AnimState:PlayAnimation("idle")
	
	if IsDLCEnabled(CAPY_DLC) then
	MakeInventoryFloatable(inst, "idle_water", "idle")
	end
    
    inst:AddComponent("stackable")
	inst.components.stackable.maxsize = TUNING.STACK_SIZE_SMALLITEM

    inst:AddComponent("inspectable")
    
    inst:AddComponent("inventoryitem")
	inst.components.inventoryitem.imagename = "pancakes"
	inst.components.inventoryitem.atlasname = "images/inventoryimages/pancakes.xml"
	
	inst:AddComponent("tradable")
	
    inst:AddComponent("edible")
    inst.components.edible.healthvalue = TUNING.HEALING_LARGE
    inst.components.edible.hungervalue = TUNING.CALORIES_MED*2
	inst.components.edible.sanityvalue = TUNING.SANITY_TINY
	
	inst:AddComponent("perishable")
	inst.components.perishable:SetPerishTime(TUNING.PERISH_FAST)
	inst.components.perishable:StartPerishing()
	inst.components.perishable.onperishreplacement = "spoiled_food"
	
    
    return inst
end

STRINGS.NAMES.PANCAKES = "Honey Pancakes"

-- Randomizes the inspection line upon inspection.
STRINGS.CHARACTERS.GENERIC.DESCRIBE.PANCAKES = {	
	"I cook it myself!",
	"Almost like home ...",
}
STRINGS.CHARACTERS.WX78.DESCRIBE.PANCAKES = {	
	"UPGRADED FOOD MATERIAL",

}

return Prefab( "common/inventory/pancakes", fn, assets, prefabs) 

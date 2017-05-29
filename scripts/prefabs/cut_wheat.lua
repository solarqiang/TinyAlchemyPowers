local assets =
{
	Asset("ANIM", "anim/wheat.zip"),
	Asset("ATLAS", "images/inventoryimages/cut_wheat.xml"),
    Asset("IMAGE", "images/inventoryimages/cut_wheat.tex"),
}

local prefabs =
{
    "flour",
} 

local function fn(Sim)
	local inst = CreateEntity()
	inst.entity:AddTransform()
	inst.entity:AddAnimState()
    MakeInventoryPhysics(inst)

    inst.AnimState:SetBank("wheat")
    inst.AnimState:SetBuild("wheat")
    inst.AnimState:PlayAnimation("cutwheat")
    
    inst:AddComponent("stackable")
	inst.components.stackable.maxsize = TUNING.STACK_SIZE_SMALLITEM

    inst:AddComponent("edible")
    inst.components.edible.foodtype = "WOOD"
    inst.components.edible.woodiness = 1


    inst:AddComponent("inspectable")
	
	inst:AddComponent("extractable")
        inst.components.extractable.product = "flour"

    inst:AddComponent("fuel")
    inst.components.fuel.fuelvalue = TUNING.SMALL_FUEL
    
	MakeSmallBurnable(inst, TUNING.SMALL_BURNTIME)
    MakeSmallPropagator(inst)
    
	--inst:AddComponent("repairer")
	--inst.components.repairer.repairmaterial = "hay"
	--inst.components.repairer.healthrepairvalue = TUNING.REPAIR_CUTGRASS_HEALTH
    
    inst:AddComponent("inventoryitem")
	inst.components.inventoryitem.imagename = "cut_wheat"
    inst.components.inventoryitem.atlasname = "images/inventoryimages/cut_wheat.xml"

    return inst
end

STRINGS.NAMES.CUT_WHEAT = "Wheat Grain"

-- Randomizes the inspection line upon inspection.
STRINGS.CHARACTERS.GENERIC.DESCRIBE.CUT_WHEAT = {	
	"It tastes awful, I have to do something about it...",
}
STRINGS.CHARACTERS.WX78.DESCRIBE.CUT_WHEAT = {	
	"HOW TO PEEL THIS?",

}


return Prefab( "common/inventory/cut_wheat", fn, assets) 


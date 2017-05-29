local assets =
{
	Asset("ANIM", "anim/houndhead.zip"),
	Asset("ATLAS", "images/inventoryimages/houndhead.xml"),
    Asset("IMAGE", "images/inventoryimages/houndhead.tex"),
}

local prefabs =
{
    "bonehelm",
} 

local function fn(Sim)
	local inst = CreateEntity()
	inst.entity:AddTransform()
	inst.entity:AddAnimState()
    MakeInventoryPhysics(inst)

    inst.AnimState:SetBank("houndhead")
    inst.AnimState:SetBuild("houndhead")
    inst.AnimState:PlayAnimation("idle")
    
    inst:AddComponent("stackable")
	inst.components.stackable.maxsize = TUNING.STACK_SIZE_SMALLITEM

    inst:AddComponent("inspectable")
	
	inst:AddComponent("extractable")
        inst.components.extractable.product = "bonehelm"

    inst:AddComponent("fuel")
    inst.components.fuel.fuelvalue = TUNING.SMALL_FUEL
    
	MakeSmallBurnable(inst, TUNING.SMALL_BURNTIME)
    MakeSmallPropagator(inst)
    
	--inst:AddComponent("repairer")
	--inst.components.repairer.repairmaterial = "hay"
	--inst.components.repairer.healthrepairvalue = TUNING.REPAIR_CUTGRASS_HEALTH
    
    inst:AddComponent("inventoryitem")
	inst.components.inventoryitem.imagename = "houndhead"
    inst.components.inventoryitem.atlasname = "images/inventoryimages/houndhead.xml"

    return inst
end

STRINGS.NAMES.HOUNDHEAD = "Hound Head"

-- Randomizes the inspection line upon inspection.
STRINGS.CHARACTERS.GENERIC.DESCRIBE.HOUNDHEAD = {	
	"A trophy?",
}
STRINGS.CHARACTERS.WX78.DESCRIBE.HOUNDHEAD = {	
	"I WIN.",

}


return Prefab( "common/inventory/houndhead", fn, assets, prefabs) 


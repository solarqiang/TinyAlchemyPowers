local assets =
{
	Asset("ANIM", "anim/spiderhead.zip"),
	Asset("ATLAS", "images/inventoryimages/spiderhead.xml"),
    Asset("IMAGE", "images/inventoryimages/spiderhead.tex"),
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

    inst.AnimState:SetBank("spiderhead")
    inst.AnimState:SetBuild("spiderhead")
    inst.AnimState:PlayAnimation("idle")
    
    inst:AddComponent("stackable")
	inst.components.stackable.maxsize = TUNING.STACK_SIZE_SMALLITEM

    inst:AddComponent("inspectable")
	
	inst:AddComponent("extractable")
        inst.components.extractable.product = "spiderhelm"

    inst:AddComponent("fuel")
    inst.components.fuel.fuelvalue = TUNING.SMALL_FUEL
    
	MakeSmallBurnable(inst, TUNING.SMALL_BURNTIME)
    MakeSmallPropagator(inst)
    
	--inst:AddComponent("repairer")
	--inst.components.repairer.repairmaterial = "hay"
	--inst.components.repairer.healthrepairvalue = TUNING.REPAIR_CUTGRASS_HEALTH
    
    inst:AddComponent("inventoryitem")
	inst.components.inventoryitem.imagename = "spiderhead"
    inst.components.inventoryitem.atlasname = "images/inventoryimages/spiderhead.xml"

    return inst
end

STRINGS.NAMES.SPIDERHEAD = "Spitter Head"

-- Randomizes the inspection line upon inspection.
STRINGS.CHARACTERS.GENERIC.DESCRIBE.SPIDERHEAD = {	
	"Now try spit on me !",
}

STRINGS.CHARACTERS.WX78.DESCRIBE.SPIDERHEAD = {	
	"I WIN",

}


return Prefab( "common/inventory/spiderhead", fn, assets, prefabs) 


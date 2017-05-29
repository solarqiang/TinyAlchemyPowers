local assets =
{
	Asset("ANIM", "anim/bones.zip"),
	Asset("ATLAS", "images/inventoryimages/bones.xml"),
    Asset("IMAGE", "images/inventoryimages/bones.tex"),
}

local function fn(Sim)
	local inst = CreateEntity()
	inst.entity:AddTransform()
	inst.entity:AddAnimState()
    MakeInventoryPhysics(inst)

    inst.AnimState:SetBank("bones")
    inst.AnimState:SetBuild("bones")
    inst.AnimState:PlayAnimation("idle")
    
    inst:AddComponent("stackable")
	inst.components.stackable.maxsize = TUNING.STACK_SIZE_SMALLITEM

    inst:AddComponent("inspectable")
	
    inst:AddComponent("fuel")
    inst.components.fuel.fuelvalue = TUNING.SMALL_FUEL
    
	MakeSmallBurnable(inst, TUNING.SMALL_BURNTIME)
    MakeSmallPropagator(inst)
    
    inst:AddComponent("inventoryitem")
	inst.components.inventoryitem.imagename = "bones"
    inst.components.inventoryitem.atlasname = "images/inventoryimages/bones.xml"

    return inst
end

STRINGS.NAMES.BONES = "Pile of Bones"

-- Randomizes the inspection line upon inspection.
STRINGS.CHARACTERS.GENERIC.DESCRIBE.BONES = {	
	"And what am I going to do with THIS?",
}
STRINGS.CHARACTERS.WX78.DESCRIBE.BONES = {	
	"PIECES OF STRUCTURAL SUPPORT SYSTEM",

}


return Prefab( "common/inventory/bones", fn, assets) 


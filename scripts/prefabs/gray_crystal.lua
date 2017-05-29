local assets =
{
	Asset("ANIM", "anim/gray_crystal.zip"),
	Asset("ATLAS", "images/inventoryimages/gray_crystal.xml"),
    Asset("IMAGE", "images/inventoryimages/gray_crystal.tex"),
}

local function fn(Sim)

	local inst = CreateEntity()
	inst.entity:AddTransform()
	inst.entity:AddAnimState()
    MakeInventoryPhysics(inst)

    inst.AnimState:SetBank("gray_crystal")
    inst.AnimState:SetBuild("gray_crystal")
    inst.AnimState:PlayAnimation("idle")
	
	if IsDLCEnabled(CAPY_DLC) then
	MakeInventoryFloatable(inst, "idle_water", "idle")
	end
	
	inst:AddComponent("edible")
    inst.components.edible.foodtype = "ELEMENTAL"
    inst:AddComponent("tradable")
    inst.components.edible.hungervalue = 5
		
	inst:AddComponent("bait")
    inst:AddTag("molebait")
    
	inst:AddComponent("repairer")
	inst.components.repairer.repairmaterial = "gem"
	inst.components.repairer.workrepairvalue = TUNING.REPAIR_GEMS_WORK
	
    inst:AddComponent("stackable")
	inst.components.stackable.maxsize = TUNING.STACK_SIZE_SMALLITEM

    inst:AddComponent("inspectable")
	
    inst:AddComponent("fuel")
    inst.components.fuel.fuelvalue = TUNING.SMALL_FUEL
    
	MakeSmallBurnable(inst, TUNING.SMALL_BURNTIME)
    MakeSmallPropagator(inst)
    
    inst:AddComponent("inventoryitem")
	inst.components.inventoryitem.imagename = "gray_crystal"
    inst.components.inventoryitem.atlasname = "images/inventoryimages/gray_crystal.xml"
	
    return inst
end

STRINGS.NAMES.GRAY_CRYSTAL = "Gray Gem"

-- Randomizes the inspection line upon inspection.
STRINGS.CHARACTERS.GENERIC.DESCRIBE.GRAY_CRYSTAL = {	
	"Depleted Purple Gem.",
	"It still has some power...strange.",
}
STRINGS.CHARACTERS.WX78.DESCRIBE.GRAY_CRYSTAL = {	
	"INACTIVE",

}


return Prefab( "common/inventory/gray_crystal", fn, assets) 


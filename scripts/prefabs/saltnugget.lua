local assets=
{
	Asset("ANIM", "anim/saltnugget.zip"),
	Asset("ATLAS", "images/inventoryimages/saltnugget.xml"),	-- Atlas for inventory TEX
    Asset("IMAGE", "images/inventoryimages/saltnugget.tex"),	-- TEX for inventory
}

local function fn(Sim)
    
	local inst = CreateEntity()
	inst.entity:AddTransform()
	inst.entity:AddAnimState()
	MakeInventoryPhysics(inst)

    inst.AnimState:SetBank("saltnugget")
    inst.AnimState:SetBuild("saltnugget")
    inst.AnimState:PlayAnimation("idle")

    inst:AddComponent("edible")
    inst.components.edible.foodtype = "ELEMENTAL"
    inst.components.edible.hungervalue = 2
   
    inst:AddComponent("tradable")
    
    inst:AddComponent("inspectable")
    
	inst:AddComponent("extractable")
        inst.components.extractable.product = "salt"
		
    inst:AddComponent("stackable")
	inst.components.stackable.maxsize = TUNING.STACK_SIZE_SMALLITEM
	
    inst:AddComponent("inventoryitem")
    inst.components.inventoryitem.imagename = "saltnugget"	-- Use our TEX sprite
    inst.components.inventoryitem.atlasname = "images/inventoryimages/saltnugget.xml"	-- here's the atlas for our tex
	
    return inst
end

STRINGS.NAMES.SALTNUGGET = "Salt Nugget"

-- Randomizes the inspection line upon inspection.
STRINGS.CHARACTERS.GENERIC.DESCRIBE.SALTNUGGET = {	
	"Salty ... what a surprise",
	"I have to somehow grind this",
}

STRINGS.CHARACTERS.WX78.DESCRIBE.SALTNUGGET = {	
	"SALTY",

}

return Prefab( "common/inventory/saltnugget", fn, assets) 

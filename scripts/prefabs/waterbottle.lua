local assets=
{
	Asset("ANIM", "anim/waterbottle.zip"),
	Asset("ATLAS", "images/inventoryimages/waterbottle.xml"),	-- Atlas for inventory TEX
    Asset("IMAGE", "images/inventoryimages/waterbottle.tex"),	-- TEX for inventory
}

local function fn(Sim)
    
	local inst = CreateEntity()
	inst.entity:AddTransform()
	inst.entity:AddAnimState()
	MakeInventoryPhysics(inst)

    inst.AnimState:SetBank("waterbottle")
    inst.AnimState:SetBuild("waterbottle")
    inst.AnimState:PlayAnimation("idle")
	
	if IsDLCEnabled(CAPY_DLC) then
	MakeInventoryFloatable(inst, "idle_water", "idle")
	
	end	
   
    inst:AddComponent("tradable")
    
    inst:AddComponent("inspectable")
		
  --  inst:AddComponent("stackable")
  --  inst.components.stackable.maxsize = TUNING.STACK_SIZE_MEDITEM
	
    inst:AddComponent("inventoryitem")
    inst.components.inventoryitem.imagename = "waterbottle"	-- Use our TEX sprite
    inst.components.inventoryitem.atlasname = "images/inventoryimages/waterbottle.xml"	-- here's the atlas for our tex
	
	inst:AddComponent("waterproofer")
	inst.components.waterproofer:SetEffectiveness(0)

	inst.no_wet_prefix = true
	
	inst:AddComponent("extractable")
       inst.components.extractable.product = "salt"
	
    inst:AddComponent("useableitem")
   -- inst.components.useableitem.verb = "EMPTY"
    inst.components.useableitem:SetCanInteractFn(function() return true end)
    inst.components.useableitem:SetOnUseFn(function(inst)
        inst.SoundEmitter:PlaySound("dontstarve_DLC002/creatures/seacreature_movement/water_submerge_med")
        local emptybottle = SpawnPrefab("messagebottleempty")
        GetPlayer().components.inventory:GiveItem(emptybottle)

        inst:Remove()
    end)	

    return inst
end

STRINGS.NAMES.WATERBOTTLE = "Bottle with Sea Water"

-- Randomizes the inspection line upon inspection.
STRINGS.CHARACTERS.GENERIC.DESCRIBE.WATERBOTTLE = {	
	"Wet and salty",
	"I don't want to drink this!",
}

STRINGS.CHARACTERS.WX78.DESCRIBE.WATERBOTTLE = {	
	"SALTY LIQUID",

}

return Prefab( "common/inventory/waterbottle", fn, assets) 

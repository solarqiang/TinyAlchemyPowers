local assets=
{
	Asset("ANIM", "anim/grayamulet.zip"),
	Asset("ANIM", "anim/torso_grayamulet.zip"),
	Asset("ATLAS", "images/inventoryimages/grayamulet.xml"),
    Asset("IMAGE", "images/inventoryimages/grayamulet.tex"),
	
	
}

--[[ Each amulet has a seperate onequip and onunequip function so we can also
add and remove event listeners, or start/stop update functions here. ]]

---GRAY

local function onequip_gray(inst, owner) 
    owner.AnimState:OverrideSymbol("swap_body", "torso_grayamulet", "purpleamulet")
    if inst.components.fueled then
        inst.components.fueled:StartConsuming()        
    end
  
end

local function onunequip_gray(inst, owner) 
    owner.AnimState:ClearOverrideSymbol("swap_body")
    if inst.components.fueled then
        inst.components.fueled:StopConsuming()        
    end
 
end

---FORCEFIELD

 --[[  local function forcefield_proc(inst, owner)
	
        inst:AddTag("forcefield")
        inst.components.armor:SetAbsorption(1)
        local fx = SpawnPrefab("greenfieldfx")
        fx.entity:SetParent(owner.entity)
        fx.Transform:SetPosition(0, 0.2, 0)
        local fx_hitanim = function()
            fx.AnimState:PlayAnimation("hit")
            fx.AnimState:PushAnimation("idle_loop")
        end
        fx:ListenForEvent("blocked", fx_hitanim, owner)

        inst.active = true

        owner:DoTaskInTime( 15, function()
            fx:RemoveEventCallback("blocked", fx_hitanim, owner)
            fx.kill_fx(fx)
            if inst:IsValid() then
                inst:RemoveTag("forcefield")
                inst.components.armor:SetAbsorption(0.05)
                owner:DoTaskInTime( 4, function() inst.active = false end)
            end
        end)
    end

    local function tryproc(inst, owner)
        if not inst.active then
           forcefield_proc(inst, owner)
        end
    end

	local function onunequip_forcefield(inst, owner) 
    owner.AnimState:ClearOverrideSymbol("swap_body")
	
	 owner:RemoveEventCallback("equip", inst.procfn)
	 owner:RemoveEventCallback("attacked", inst.procfn)
end
	
local function onequip_forcefield(inst, owner) 
    owner.AnimState:OverrideSymbol("swap_body", "", "")
	
	inst.procfn = function() tryproc(inst, owner) end
    owner:ListenForEvent("equip", inst.procfn )
	owner:ListenForEvent("attacked", inst.procfn )
  
end]]

---COMMON FUNCTIONS

local function onfinished(inst)
    inst:Remove()
end

local function unimplementeditem(inst)
    local player = GetPlayer()
    player.components.talker:Say(GetString(player.prefab, "ANNOUNCE_UNIMPLEMENTED"))
    if player.components.health.currenthealth > 1 then
        player.components.health:DoDelta(-player.components.health.currenthealth * 0.5)
    end

    if inst.components.useableitem then
        inst.components.useableitem:StopUsingItem()
    end
end

local function commonfn()
	local inst = CreateEntity()
    
	inst.entity:AddTransform()
	inst.entity:AddAnimState()
    MakeInventoryPhysics(inst)   
    
    inst:AddComponent("inspectable")
	
    inst:AddComponent("equippable")
    inst.components.equippable.equipslot = EQUIPSLOTS.BODY
    
    inst:AddComponent("inventoryitem")
    inst.components.inventoryitem.foleysound = "dontstarve/movement/foley/jewlery"
    
    return inst
	
end

local function gray(inst)
    local inst = commonfn(inst)

		inst.AnimState:SetBank("grayamulet")
		inst.AnimState:SetBuild("grayamulet")
		
	if IsDLCEnabled(CAPY_DLC) then
	MakeInventoryFloatable(inst, "idle_water", "idle")
	end		
	
        inst:AddComponent("fueled")
        inst.components.fueled.fueltype = "MAGIC"
        inst.components.fueled:InitializeFuelLevel(TUNING.PURPLEAMULET_FUEL)
        inst.components.fueled:SetDepletedFn(onfinished)

        inst.AnimState:PlayAnimation("idle")
		
        inst.components.equippable:SetOnEquip( onequip_gray )
        inst.components.equippable:SetOnUnequip( onunequip_gray )
		
		inst.components.inventoryitem.imagename = "grayamulet"
		inst.components.inventoryitem.atlasname = "images/inventoryimages/grayamulet.xml"

        inst.components.equippable.dapperness = TUNING.DAPPERNESS_HUGE    

    return inst
end

--[[ local function forcefieldn(inst)
    local inst = commonfn(inst)
		
		inst.AnimState:SetBank("forcefieldn")
		inst.AnimState:SetBuild("forcefieldn")

        inst.AnimState:PlayAnimation("idle")
		
		inst:AddComponent("armor")
        inst:AddTag("metal")
        inst.components.armor:InitCondition(3000, 0.05)
		
        inst.components.equippable:SetOnEquip( onequip_forcefield )
        inst.components.equippable:SetOnUnequip( onunequip_forcefield )
		
		inst.components.inventoryitem.imagename = "forcefieldn"
		inst.components.inventoryitem.atlasname = "images/inventoryimages/forcefieldn.xml"  

    return inst
end]]

STRINGS.NAMES.GRAYAMULET = "Calm Amulet"
STRINGS.RECIPE_DESC.GRAYAMULET = "A bright mind is a peaceful mind."
STRINGS.CHARACTERS.GENERIC.DESCRIBE.GRAYAMULET = {	
	"It shouldn't exist in this world ... I feel it.",
	"I feel warm and calm when I look at it."
	 
}
STRINGS.CHARACTERS.WX78.DESCRIBE.GRAYAMULET = {	
	"PROCESSING UNIT DEFRAGMENTATION DEVICE",

}

--[[STRINGS.NAMES.FORCEFIELDN = "Damaged Forcefield"
STRINGS.CHARACTERS.GENERIC.DESCRIBE.FORCEFIELDN = {	
	"Lightweight and durable ... when it works.",
	 
}]]

local gray_crystal = Ingredient("gray_crystal", 1)
gray_crystal.atlas = "images/inventoryimages/gray_crystal.xml"

local crafting_recipe = Recipe("grayamulet", {Ingredient("goldnugget", 6) , gray_crystal}, RECIPETABS.MAGIC, {MAGIC=3})
crafting_recipe.atlas = "images/inventoryimages/grayamulet.xml"

return Prefab( "common/inventory/grayamulet", gray, assets)
--Prefab( "common/inventory/forcefieldn", forcefieldn, assets)

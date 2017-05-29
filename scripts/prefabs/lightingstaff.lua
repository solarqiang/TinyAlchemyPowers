local assets=
{ 
    Asset("ANIM", "anim/lightingstaff.zip"),
    Asset("ANIM", "anim/lightingstaff_swap.zip"), 

    Asset("ATLAS", "images/inventoryimages/lightingstaff.xml"),
    Asset("IMAGE", "images/inventoryimages/lightingstaff.tex"),
}

local prefabs = 
{
}

local function naturewrath(staff, target)
		local caster = staff.components.inventoryitem.owner
		
		if target.components.combat then
			local strike = target:GetPosition()
            GetSeasonManager():DoLightningStrike(strike)
            target.components.health:DoDelta(-300,0,0)
        
		 elseif target.components.burnable and not target.components.burnable:IsBurning() then
			local strike = target:GetPosition()
			GetSeasonManager():DoLightningStrike(strike)
		else
		local strike = GetPlayer():GetPosition()
		--caster.components.combat:GetAttacked(caster, 20)
		
        if IsDLCEnabled(REIGN_OF_GIANTS) or IsDLCEnabled(CAPY_DLC) then 
		caster.components.health:DoDelta(-20,0,0)
		caster.AnimState:PlayAnimation("shock")
		else
		caster.components.combat:GetAttacked(caster, 20)
		caster:PushEvent("thorns")
		end
		GetSeasonManager():DoLightningStrike(strike)
		end 
		
		if caster and caster.components.sanity then
        caster.components.sanity:DoDelta(-TUNING.SANITY_SMALL)
		end
		
		 staff.components.finiteuses:Use(1) 
		 
    end

local function onfinished(inst)
   
    inst:Remove()
end

local function fn(colour)

    local function OnEquip(inst, owner) 
        owner.AnimState:OverrideSymbol("swap_object", "lightingstaff_swap", "lightingstaff")
        owner.AnimState:Show("ARM_carry") 
        owner.AnimState:Hide("ARM_normal") 
    end

    local function OnUnequip(inst, owner) 
        owner.AnimState:Hide("ARM_carry") 
        owner.AnimState:Show("ARM_normal") 
    end

    local inst = CreateEntity()
    local trans = inst.entity:AddTransform()
    local anim = inst.entity:AddAnimState()
    MakeInventoryPhysics(inst)
    
    anim:SetBank("lightingstaff")
    anim:SetBuild("lightingstaff")
    anim:PlayAnimation("idle")
	
	if IsDLCEnabled(CAPY_DLC) then
	MakeInventoryFloatable(inst, "idle_water", "idle")
	end

    inst:AddComponent("inventoryitem")
    inst.components.inventoryitem.imagename = "lightingstaff"
    inst.components.inventoryitem.atlasname = "images/inventoryimages/lightingstaff.xml"
	
	inst:AddComponent("inspectable")
    
	inst:AddComponent("spellcaster")
    inst.components.spellcaster:SetSpellFn(naturewrath)
    inst.components.spellcaster.canuseontargets = true
	inst.components.spellcaster.canusefrominventory = false
	inst.components.spellcaster.canuseonpoint = false
    inst:AddTag("nopunch")
	
	inst:AddComponent("reticule")
    inst.components.reticule.targetfn = function() 
        return Vector3(GetPlayer().entity:LocalToWorldSpace(5,0,0))
    end
    inst.components.reticule.ease = true

	inst:AddComponent("finiteuses")
    inst.components.finiteuses:SetOnFinished( onfinished )
	
	inst.components.finiteuses:SetMaxUses(8)
    inst.components.finiteuses:SetUses(8)
	
    inst:AddComponent("equippable")
    inst.components.equippable:SetOnEquip( OnEquip )
    inst.components.equippable:SetOnUnequip( OnUnequip )

    return inst
end

STRINGS.NAMES.LIGHTINGSTAFF = "Lightning Staff"
STRINGS.RECIPE_DESC.LIGHTINGSTAFF = "Aid from nature."
STRINGS.CHARACTERS.GENERIC.DESCRIBE.LIGHTINGSTAFF = {	
	"It shouldn't exist in this world ... I feel it.",
	"Full of power ... the dangerous power."
	 
}
STRINGS.CHARACTERS.WX78.DESCRIBE.LIGHTINGSTAFF = {	
	"DANGER, DO NOT USE!",
	 
}

return  Prefab("common/inventory/lightingstaff", fn, assets, prefabs)
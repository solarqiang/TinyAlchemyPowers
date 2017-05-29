local assets=
{
 Asset("ANIM", "anim/bonearmor.zip"),
 Asset("IMAGE", "images/inventoryimages/bonearmor.tex"),
 Asset("ATLAS", "images/inventoryimages/bonearmor.xml"),
}

local function OnBlocked(owner) 
    owner.SoundEmitter:PlaySound("dontstarve/wilson/hit_armour")
end

local function onequip(inst, owner) 
    owner.AnimState:OverrideSymbol("swap_body", "bonearmor", "swap_body")
    inst:ListenForEvent("blocked", OnBlocked, owner)
    owner.SoundEmitter:PlaySound("dontstarve/wilson/equip_item_gold")  
end

local function onunequip(inst, owner) 
    owner.AnimState:ClearOverrideSymbol("swap_body")
    inst:RemoveEventCallback("blocked", OnBlocked, owner)
end

local function fn()
	local inst = CreateEntity()
    
	inst.entity:AddTransform()
	inst.entity:AddAnimState()
    MakeInventoryPhysics(inst)
    
    inst.AnimState:SetBank("armor_wood")
    inst.AnimState:SetBuild("bonearmor")
    inst.AnimState:PlayAnimation("anim")
    
	if IsDLCEnabled(CAPY_DLC) then
	MakeInventoryFloatable(inst, "idle_water", "anim")
	end
	
    inst:AddComponent("inspectable")
    
    inst:AddComponent("inventoryitem")
	inst.components.inventoryitem.foleysound = "dontstarve/movement/foley/marblearmour"
    inst.components.inventoryitem.atlasname = "images/inventoryimages/bonearmor.xml"
    
    inst:AddComponent("armor")
    inst.components.armor:InitCondition(700, 0.85)
    
    inst:AddComponent("equippable")
    inst.components.equippable.equipslot = EQUIPSLOTS.BODY

    inst.components.equippable:SetOnEquip( onequip )
    inst.components.equippable:SetOnUnequip( onunequip )
    
    return inst
end

STRINGS.NAMES.BONEARMOR = "Bonearmor"
STRINGS.RECIPE_DESC.BONEARMOR = "Armor of Bones"
STRINGS.CHARACTERS.GENERIC.DESCRIBE.BONEARMOR = {	
	"Little creepy, but quite comfortable.",
	 
}
STRINGS.CHARACTERS.WX78.DESCRIBE.BONEARMOR = {	
	"EXTERNAL EXOSKELETON",

}

return Prefab( "common/inventory/bonearmor", fn, assets) 
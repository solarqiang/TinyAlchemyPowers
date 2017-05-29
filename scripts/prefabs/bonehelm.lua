local assets=
{ 
    Asset("ANIM", "anim/bonehelm.zip"),
    Asset("ANIM", "anim/bonehelm_swap.zip"), 

    Asset("ATLAS", "images/inventoryimages/bonehelm.xml"),
    Asset("IMAGE", "images/inventoryimages/bonehelm.tex"),
}

local prefabs = 
{
}

local function fn()

    local function OnEquip(inst, owner) 
        owner.AnimState:OverrideSymbol("swap_hat", "bonehelm_swap", "swap_hat")
        owner.AnimState:Show("HAT")
        owner.AnimState:Show("HAT_HAIR")
        owner.AnimState:Hide("HAIR_NOHAT")
        owner.AnimState:Hide("HAIR")
        print('A')
        if owner:HasTag("player") then
            print('B')
            owner.AnimState:Hide("HEAD")
            owner.AnimState:Show("HEAD_HAIR")
        end
    end

    local function OnUnequip(inst, owner) 
        owner.AnimState:Hide("HAT")
        owner.AnimState:Hide("HAT_HAIR")
        owner.AnimState:Show("HAIR_NOHAT")
        owner.AnimState:Show("HAIR")

        if owner:HasTag("player") then
            owner.AnimState:Show("HEAD")
            owner.AnimState:Hide("HEAD_HAIR")
        end
    end

    local inst = CreateEntity()
    local trans = inst.entity:AddTransform()
    local anim = inst.entity:AddAnimState()
    MakeInventoryPhysics(inst)
    
    anim:SetBank("bonehelm")
    anim:SetBuild("bonehelm")
    anim:PlayAnimation("idle")

    inst:AddComponent("inventoryitem")
    inst.components.inventoryitem.imagename = "bonehelm"
    inst.components.inventoryitem.atlasname = "images/inventoryimages/bonehelm.xml"
	
	inst:AddComponent("inspectable")
	
	inst:AddComponent("armor")
        inst.components.armor:InitCondition(450, 0.75)
    
    inst:AddComponent("equippable")
    inst.components.equippable.equipslot = EQUIPSLOTS.HEAD
    inst.components.equippable:SetOnEquip(OnEquip)
    inst.components.equippable:SetOnUnequip(OnUnequip)

    return inst
end

STRINGS.NAMES.BONEHELM = "Skull Helmet"
STRINGS.CHARACTERS.GENERIC.DESCRIBE.BONEHELM = {	
	"My name's Killer...Hounds Killer.",
	 
}
STRINGS.CHARACTERS.WX78.DESCRIBE.BONEHELM = {	
	"THIS WILL COVER MY PROCESSING UNIT",

}

return  Prefab("common/inventory/bonehelm", fn, assets, prefabs)
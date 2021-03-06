local assets=
{ 
    Asset("ANIM", "anim/spiderhelm.zip"),
    Asset("ANIM", "anim/spiderhelm_swap.zip"), 

    Asset("ATLAS", "images/inventoryimages/spiderhelm.xml"),
    Asset("IMAGE", "images/inventoryimages/spiderhelm.tex"),
}

local prefabs = 
{
}

local function fn()

    local function OnEquip(inst, owner) 
        owner.AnimState:OverrideSymbol("swap_hat", "spiderhelm_swap", "swap_hat")
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
    
    anim:SetBank("spiderhelm")
    anim:SetBuild("spiderhelm")
    anim:PlayAnimation("idle")

    inst:AddComponent("inventoryitem")
    inst.components.inventoryitem.imagename = "spiderhelm"
    inst.components.inventoryitem.atlasname = "images/inventoryimages/spiderhelm.xml"
	
	inst:AddComponent("inspectable")
	
	inst:AddComponent("armor")
        inst.components.armor:InitCondition(450, 0.75)
    
    inst:AddComponent("equippable")
    inst.components.equippable.equipslot = EQUIPSLOTS.HEAD
    inst.components.equippable:SetOnEquip(OnEquip)
    inst.components.equippable:SetOnUnequip(OnUnequip)

    return inst
end

STRINGS.NAMES.SPIDERHELM = "Skull Helmet"
STRINGS.CHARACTERS.GENERIC.DESCRIBE.SPIDERHELM = {	
	"Good spider is a dead spider.",
	 
}
STRINGS.CHARACTERS.WX78.DESCRIBE.SPIDERHELM = {	
	"THIS WILL COVER MY PROCESSING UNIT",

}

return  Prefab("common/inventory/spiderhelm", fn, assets, prefabs)
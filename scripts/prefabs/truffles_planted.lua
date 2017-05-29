local assets=
{
	Asset("ANIM", "anim/truffles.zip"),
}

local prefabs=
{
	"truffles",
}

local function onpickedfn(inst)
	inst:Remove()
end


local function fn(Sim)
    --Truffles you eat is defined in truffles.lua
	local inst = CreateEntity()
	inst.entity:AddTransform()
	inst.entity:AddAnimState()
	inst.entity:AddSoundEmitter()
   
    inst.AnimState:SetBank("truffles")
    inst.AnimState:SetBuild("truffles")
    inst.AnimState:PlayAnimation("planted")
    inst.AnimState:SetRayTestOnBB(true);
    

    inst:AddComponent("inspectable")
    
    inst:AddComponent("pickable")
    inst.components.pickable.picksound = "dontstarve/wilson/pickup_plants"
    inst.components.pickable:SetUp("truffles", 10)
	inst.components.pickable.onpickedfn = onpickedfn
    
    inst.components.pickable.quickpick = true

    
	MakeSmallBurnable(inst)
    MakeSmallPropagator(inst)
	
    return inst
end

STRINGS.NAMES.TRUFFLES_PLANTED = "Truffles"

-- Randomizes the inspection line upon inspection.
STRINGS.CHARACTERS.GENERIC.DESCRIBE.TRUFFLES_PLANTED = {	
	"Very aromatic",
	"A rarity among mushrooms",
}
STRINGS.CHARACTERS.WX78.DESCRIBE.TRUFFLES_PLANTED = {	
	"AROMATIC FOOD MATERIAL",

}

return Prefab( "common/inventory/truffles_planted", fn, assets) 

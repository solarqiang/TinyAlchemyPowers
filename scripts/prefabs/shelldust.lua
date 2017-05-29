local assets=
{
    Asset("ANIM", "anim/shelldust.zip"),						-- Animation Zip
    Asset("ATLAS", "images/inventoryimages/shelldust.xml"),	-- Atlas for inventory TEX
    Asset("IMAGE", "images/inventoryimages/shelldust.tex"),	-- TEX for inventory
}

local function BlowAway(inst)
    inst.blowawaytask = nil
    inst.persists = false
    inst:RemoveComponent("inventoryitem")
    inst:RemoveComponent("inspectable")
	inst.SoundEmitter:PlaySound("dontstarve/common/dust_blowaway")
	inst.AnimState:PlayAnimation("disappear")
	inst:ListenForEvent("animover", function() inst:Remove() end)
end

local function StopBlowAway(inst)
	if inst.blowawaytask then
		inst.blowawaytask:Cancel()
		inst.blowawaytask = nil
	end
end
		
local function PrepareBlowAway(inst)
	StopBlowAway(inst)
	inst.blowawaytask = inst:DoTaskInTime(2+math.random()*10, BlowAway)
end

local function fn(Sim)
	-- Create a new entity
	local inst = CreateEntity()
	inst.entity:AddTransform()
	inst.entity:AddAnimState()
	MakeInventoryPhysics(inst)
	
	-- Set animation info
	inst.AnimState:SetBuild("shelldust")
	inst.AnimState:SetBank("shelldust")
	inst.AnimState:PlayAnimation("idle")
	
	-- Make it edible
	inst:AddComponent("edible")
	inst.components.edible.healthvalue = 0	-- Amount to heal
	inst.components.edible.hungervalue =  0	-- Amount to fill belly
	inst.components.edible.sanityvalue = -TUNING.SANITY_SMALL	-- Amount to help Sanity
	
	-- Make it perishable
	inst:AddComponent("perishable")
	inst.components.perishable:SetPerishTime(TUNING.PERISH_SLOW)
	inst.components.perishable:StartPerishing()
	inst.components.perishable.onperishreplacement = "spoiled_food"
	
	-- Make it stackable
	inst:AddComponent("stackable")
	inst.components.stackable.maxsize = TUNING.STACK_SIZE_SMALLITEM
	
	-- Make it inspectable
	inst:AddComponent("inspectable")
	
	inst:AddComponent("tradable")
	
	-- Make it an inventory item
	inst:AddComponent("inventoryitem")
    inst.components.inventoryitem.imagename = "shelldust"	-- Use our TEX sprite
    inst.components.inventoryitem.atlasname = "images/inventoryimages/shelldust.xml"	-- here's the atlas for our tex
	
	inst:ListenForEvent("ondropped",  PrepareBlowAway)
	
	return inst
end

STRINGS.NAMES.SHELLDUST = "Shell Dust"

-- Randomizes the inspection line upon inspection.
STRINGS.CHARACTERS.GENERIC.DESCRIBE.SHELLDUST = {	
	"Don't eat dry.",
	"Different flour, almost",
}

STRINGS.CHARACTERS.WX78.DESCRIBE.SHELLDUST = {	
	"LOOSE FOOD UNIT",

}

AddIngredientValues({"shelldust"}, {loose=1})

-- Return our prefab
return Prefab( "common/inventory/shelldust", fn, assets)
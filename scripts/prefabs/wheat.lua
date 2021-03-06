--require "pickable"

local assets=
{
	Asset("ANIM", "anim/wheat.zip"),
	Asset("ATLAS", "images/inventoryimages/wheat_map.xml"),
    Asset("IMAGE", "images/inventoryimages/wheat_map.tex"),
	Asset("SOUND", "sound/common.fsb"),
}


local prefabs =
{
    "cut_wheat",
    "dug_wheat",
}

local function getstatus(inst)
	if inst.components.pickable and inst.components.pickable:IsBarren() then
		STRINGS.CHARACTERS.GENERIC.DESCRIBE.WHEAT = {	
		"It needs poop",
		}
		STRINGS.CHARACTERS.WX78.DESCRIBE.WHEAT = {	
		"FERTILIZATION REQUIRED",

		}
	
	elseif inst.components.pickable and not inst.components.pickable:CanBePicked() then
		STRINGS.CHARACTERS.GENERIC.DESCRIBE.WHEAT = {	
		"I hope they will grow back...",
		"I cut it down in the prime of its life"
		}
		STRINGS.CHARACTERS.WX78.DESCRIBE.WHEAT = {	
		"IT IS REBOOTING",

		}
	elseif inst.components.burnable and inst.components.burnable:IsBurning() then
		STRINGS.CHARACTERS.GENERIC.DESCRIBE.WHEAT = {	
		"That's burning fast!",
		"Burn baby burn!",
		}
		STRINGS.CHARACTERS.WX78.DESCRIBE.WHEAT = {	
		"DAMAGED.",

		}
	else
	STRINGS.CHARACTERS.GENERIC.DESCRIBE.WHEAT = {	
		"Apparently needed to make bread",
		}
	STRINGS.CHARACTERS.WX78.DESCRIBE.WHEAT = {	
	"POTENTIAL CONSTRUCTION MATERIAL",

		}
	STRINGS.CHARACTERS.WILLOW.DESCRIBE.WHEAT = {	
	"They are yellow, sweet",

		}
	
	end
end  

local function dig_up(inst, chopper)
	if inst.components.pickable and inst.components.pickable:CanBePicked() then
		inst.components.lootdropper:SpawnLootPrefab("cut_wheat")
	end
	inst:Remove()
	local bush = inst.components.lootdropper:SpawnLootPrefab("dug_wheat")
	
end

local function onregenfn(inst)
	inst.AnimState:PlayAnimation("grow") 
	inst.AnimState:PushAnimation("idle", true)

end

local function makefullfn(inst)
	inst.AnimState:PlayAnimation("idle", true)
	
end

local function makebarrenfn(inst)
	inst.AnimState:PlayAnimation("dead")	
end


local function onpickedfn(inst)
	inst.SoundEmitter:PlaySound("dontstarve/wilson/pickup_reeds") 
	inst.AnimState:PlayAnimation("picking") 
	
	if inst.components.pickable:IsBarren() then
		inst.AnimState:PushAnimation("dead")
	else
		inst.AnimState:PushAnimation("picked")
	end
	
end

local function makeemptyfn(inst)
	inst.AnimState:PlayAnimation("picked")
	
end

local function ontransplantfn(inst)
	inst.components.pickable:MakeBarren()
end  

--local function makefn(stage)
	local function fn(Sim)
		local inst = CreateEntity()
		local trans = inst.entity:AddTransform()
		local anim = inst.entity:AddAnimState()
	    local sound = inst.entity:AddSoundEmitter()
		
		local minimap = inst.entity:AddMiniMapEntity()
		minimap:SetIcon( "wheat_map.tex" )
		
	    
	    anim:SetBank("wheat")
	    anim:SetBuild("wheat")
	    anim:PlayAnimation("idle",true)
	    anim:SetTime(math.random()*2)
	    local color = 0.75 + math.random() * 0.25
	    anim:SetMultColour(color, color, color, 1)

		inst:AddComponent("pickable")
		inst.components.pickable.picksound = "dontstarve/wilson/pickup_reeds"
		
		inst.components.pickable:SetUp("cut_wheat", TUNING.GRASS_REGROW_TIME)
		inst.components.pickable.onregenfn = onregenfn
		inst.components.pickable.onpickedfn = onpickedfn
		inst.components.pickable.makeemptyfn = makeemptyfn
		inst.components.pickable.makebarrenfn = makebarrenfn
		inst.components.pickable.makefullfn = makefullfn
		inst.components.pickable.ontransplantfn = ontransplantfn
		inst.components.pickable.max_cycles = 5
		inst.components.pickable.cycles_left = 5	

	    --if stage == 1 then
		--inst.components.pickable:MakeBarren()
		--end
		
		inst:AddComponent("lootdropper")
		
	    inst:AddComponent("inspectable")
		inst.components.inspectable.getstatus = getstatus		
	    
		inst:AddComponent("workable")
	    inst.components.workable:SetWorkAction(ACTIONS.DIG)
	    inst.components.workable:SetOnFinishCallback(dig_up)
	    inst.components.workable:SetWorkLeft(0)
	    
	    ---------------------        

	    MakeMediumBurnable(inst)
	    MakeSmallPropagator(inst)
		MakeNoGrowInWinter(inst)    
	    ---------------------   
	    
	    return inst
	end

 --  return fn
--end    

STRINGS.NAMES.WHEAT = "Wheat"


return Prefab( "common/wheat", fn, assets, prefabs)
--	MakePlacer( "common/wheat_placer", "wheat", "wheat", "idle" ) 

--[[local function wheat(name, stage)
    return Prefab("forest/objects/"..name, makefn(stage), assets, prefabs)
end

return wheat("wheat", 0),
		wheat("depleted_wheat", 1)
]]
local assets=
{
	Asset("ANIM", "anim/limetree.zip"),
	Asset("ATLAS", "images/inventoryimages/limetree_map.xml"),
    Asset("IMAGE", "images/inventoryimages/limetree_map.tex"),
	Asset("SOUND", "sound/common.fsb"),
}


local prefabs =
{
    "lime",
}  

local function getstatus(inst)
	
	if inst.components.pickable and not inst.components.pickable:CanBePicked() then
		STRINGS.CHARACTERS.GENERIC.DESCRIBE.LIMETREE = {	
		"I hope they will grow back...",

		}
		STRINGS.CHARACTERS.WX78.DESCRIBE.LIMETREE = {	
		"IT IS REBOOTING.",

		}
		
	elseif inst.components.burnable and inst.components.burnable:IsBurning() then
		STRINGS.CHARACTERS.GENERIC.DESCRIBE.LIMETREE = {	
		"That's burning fast!",
		"Burn baby burn!",
		}
		STRINGS.CHARACTERS.WX78.DESCRIBE.LIMETREE = {	
		"DAMAGED.",

		}
	else
	STRINGS.CHARACTERS.GENERIC.DESCRIBE.LIMETREE = {	
		"Good with tea.",
		"They look ripe. Time to harvest."
		}
	STRINGS.CHARACTERS.WX78.DESCRIBE.LIMETREE = {	
		"PERIODIC CALORIE DISPENSOR (SOUR).",

		}
	
	end
end  

local function onregenfn(inst)
	inst.AnimState:PlayAnimation("grow") 
	inst.AnimState:PushAnimation("idle", true)
end

local function makefullfn(inst)
	inst.AnimState:PlayAnimation("idle", true)
	
end



local function onpickedfn(inst)
	inst.SoundEmitter:PlaySound("dontstarve/wilson/pickup_reeds") 
	inst.AnimState:PushAnimation("empty", true)
	
end

local function makeemptyfn(inst)
	inst.AnimState:PlayAnimation("empty", true)
	
end


	local function fn(Sim)
		local inst = CreateEntity()
		local trans = inst.entity:AddTransform()
		local anim = inst.entity:AddAnimState()
	    local sound = inst.entity:AddSoundEmitter()
		
		local minimap = inst.entity:AddMiniMapEntity()
		minimap:SetIcon( "limetree_map.tex" )
	    
	    anim:SetBank("limetree")
	    anim:SetBuild("limetree")
	    anim:PlayAnimation("idle",true)
	    anim:SetTime(math.random()*2)

		inst:AddComponent("pickable")
		inst.components.pickable.picksound = "dontstarve/wilson/pickup_reeds"
		
		inst.components.pickable:SetUp("lime", TUNING.GRASS_REGROW_TIME)
		inst.components.pickable.onregenfn = onregenfn
		inst.components.pickable.onpickedfn = onpickedfn
		inst.components.pickable.makeemptyfn = makeemptyfn
		inst.components.pickable.makefullfn = makefullfn

	    --if stage == 1 then
			--inst.components.pickable:MakeBarren()
		--end
		
		inst:AddComponent("lootdropper")
		
	    inst:AddComponent("inspectable")
		inst.components.inspectable.getstatus = getstatus		
	    
	    ---------------------        

	    MakeMediumBurnable(inst)
	    MakeSmallPropagator(inst)
		MakeNoGrowInWinter(inst)    
	    ---------------------   
	    
	    return inst
	end   

STRINGS.NAMES.LIMETREE = "Swampy Lime Bush"

return Prefab( "common/limetree", fn, assets, prefabs)
local assets=
{
	Asset("ANIM", "anim/nuttree.zip"),
	Asset("ATLAS", "images/inventoryimages/nuttree_map.xml"),
    Asset("IMAGE", "images/inventoryimages/nuttree_map.tex"),
	Asset("SOUND", "sound/common.fsb"),
}


local prefabs =
{
    "nuts",
}  

local function getstatus(inst)
	
	if inst.components.pickable and not inst.components.pickable:CanBePicked() then
		STRINGS.CHARACTERS.GENERIC.DESCRIBE.NUTTREE = {	
		"I hope they will grow back...",

		}
		STRINGS.CHARACTERS.WX78.DESCRIBE.NUTTREE = {	
		"IT IS REBOOTING.",

		}
		
	elseif inst.components.burnable and inst.components.burnable:IsBurning() then
		STRINGS.CHARACTERS.GENERIC.DESCRIBE.NUTTREE = {	
		"That's burning fast!",
		"Burn baby burn!",
		}
		STRINGS.CHARACTERS.WX78.DESCRIBE.NUTTREE = {	
		"DAMAGED.",

		}
	else
	STRINGS.CHARACTERS.GENERIC.DESCRIBE.NUTTREE = {	
		"Good with tea.",
		"They look ripe. Time to harvest."
		}
	STRINGS.CHARACTERS.WX78.DESCRIBE.NUTTREE = {	
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
		minimap:SetIcon( "nuttree_map.tex" )
	    
	    anim:SetBank("nuttree")
	    anim:SetBuild("nuttree")
	    anim:PlayAnimation("idle",true)
	    anim:SetTime(math.random()*2)

		inst:AddComponent("pickable")
		inst.components.pickable.picksound = "dontstarve/wilson/pickup_reeds"
		
		inst.components.pickable:SetUp("nuts", TUNING.GRASS_REGROW_TIME)
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

STRINGS.NAMES.NUTTREE = "Swampy Lemon Bush"

return Prefab( "common/nuttree", fn, assets, prefabs)
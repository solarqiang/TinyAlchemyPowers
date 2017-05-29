require "prefabutil"

local assets=
{
	Asset("ANIM", "anim/extractor.zip"),
    Asset("ATLAS", "images/inventoryimages/extractor.xml"),
    Asset("IMAGE", "images/inventoryimages/extractor.tex"),
--	Asset("ATLAS", "images/inventoryimages/ui_extractor_1x1.xml"),
}

local prefabs = 

{
 --"campfirefire",
 --"smokeex",
}

local function getstatus(inst)

	if inst.components.burnable and inst.components.burnable:IsBurning() then
		STRINGS.CHARACTERS.GENERIC.DESCRIBE.EXTRACTOR = {	
		"That's burning fast!",
		"Burn baby burn!",
		}
		STRINGS.CHARACTERS.WX78.DESCRIBE.EXTRACTOR = {	
		"MACHINE WASTED.",

		}
	elseif inst:HasTag("burnt") then
		STRINGS.CHARACTERS.GENERIC.DESCRIBE.EXTRACTOR = {	
		"Magic is no more...",
		}
		STRINGS.CHARACTERS.WX78.DESCRIBE.EXTRACTOR = {	
		"DAMAGED.",

		}
	else
		STRINGS.CHARACTERS.GENERIC.DESCRIBE.EXTRACTOR = {	
		"Strange gadget of the strange purpose...",
		}
		STRINGS.CHARACTERS.WX78.DESCRIBE.EXTRACTOR = {	
		"MACHINE, ENERGY SOURCE: UNDEFINED",

		}
	
	end
end  

-- Extractor potraktowany m³otem
local function onhammered(inst, worker)
	if inst:HasTag("burnt") then
	inst.components.lootdropper:SetLoot({"charcoal","charcoal","ash"})
	inst.components.lootdropper:AddChanceLoot("ash" , 0.5)
	inst.components.lootdropper:AddChanceLoot("charcoal" , 0.4)
    inst.components.lootdropper:AddChanceLoot("ash" , 0.3)
  --  inst.components.lootdropper:AddChanceLoot("purplegem" , 0.1)
	else
	inst.components.lootdropper:SetLoot({"redgem","boards","ash"})
	inst.components.lootdropper:AddChanceLoot("ash" , 0.5)
	inst.components.lootdropper:AddChanceLoot("boards" , 0.4)
    inst.components.lootdropper:AddChanceLoot("boards" , 0.3)
	end
	inst.components.lootdropper:DropLoot()
	SpawnPrefab("collapse_small").Transform:SetPosition(inst.Transform:GetWorldPosition())
	inst.SoundEmitter:PlaySound("dontstarve/common/destroy_wood")
	inst:Remove()
end

local function onhit(inst, worker)
	inst.AnimState:PlayAnimation("hit")
	inst.AnimState:PushAnimation("idle")
end

local function onbuilt(inst)
--	inst.components.fueled:InitializeFuelLevel(0)
	inst.AnimState:PlayAnimation("build")
	inst.AnimState:PushAnimation("idle", false)
end

local function onFloodedStart(inst)
		if inst.components.streamer then
			inst:RemoveComponent("streamer")
		end
	if not inst:HasTag("broken_f") then
	inst:AddTag("broken_f")
	end
	inst.AnimState:PushAnimation("idle", true)
end 


local function onFloodedEnd(inst)
	if inst.components.streamer then 
		inst:RemoveComponent("streamer")
	end 
	if inst:HasTag("broken_f")then
	inst:RemoveTag("broken_f")
	end
	inst.AnimState:PushAnimation("idle", true)
end 

--[[local function onignite(inst)
    if not inst.components.streamer then
        inst:AddComponent("streamer")
    end
	inst.AnimState:PlayAnimation("working", true)
end

local function onextinguish(inst)
    if inst.components.streamer then
        inst:RemoveComponent("streamer")
    end
    if inst.components.fueled then
        inst.components.fueled:InitializeFuelLevel(0)
    end
	inst.AnimState:PushAnimation("idle", true)
end]]

local function OnGetItemFromPlayer(inst, giver, item)


    if item.components.chargering.nightmarevalue > 0 and not inst:HasTag("broken_f") then
		
		if not inst.components.streamer then
			inst:AddComponent("streamer")
		end
		
		inst.AnimState:PlayAnimation("working", true)
		
		inst:DoTaskInTime(30, function()
		if inst.components.streamer then
			inst:RemoveComponent("streamer")
		end
		if inst:HasTag("burnt") then
		inst.AnimState:PlayAnimation("burned", true)
		else
		inst.AnimState:PushAnimation("idle", true)
		end
		end)
		
    end
end

local function OnRefuseItem(inst, giver, item)

	inst.AnimState:PushAnimation("idle", true)

end

-- 	Define the positions of the slots
--local slotpos = {Vector3(5,34,0)}




--local function onopen(inst)
	--inst.SoundEmitter:PlaySound("dontstarve/wilson/chest_open", "open")
	
--	inst.AnimState:PlayAnimation("open")
--end 

--local function onclose(inst)
	--inst.SoundEmitter:PlaySound("dontstarve/wilson/chest_close", "close")

	--inst.AnimState:PlayAnimation("closed")
--end

local function makeburnt(inst)
	if inst.components.streamer then
        inst:RemoveComponent("streamer")
    end
	if inst.components.chargerer then
        inst:RemoveComponent("chargerer")
    end
	if inst.components.floodable then
        inst:RemoveComponent("floodable")
    end
	
	inst.AnimState:PlayAnimation("burned", true)
end

local function onsave(inst, data)
	if inst:HasTag("burnt") or inst:HasTag("fire") then
        data.burnt = true
    end
end

local function onload(inst, data)
	if data and data.burnt then
        inst.components.burnable.onburnt(inst)
    end
end

local function fn(Sim)
	local inst = CreateEntity()
	inst.entity:AddTransform()
	inst.entity:AddAnimState()
	inst.entity:AddSoundEmitter()
	
	local minimap = inst.entity:AddMiniMapEntity()
	minimap:SetIcon( "extractor.tex" )
    
    inst:AddTag("structure")
    MakeObstaclePhysics(inst, .5)
    
    inst.AnimState:SetBank("extractor")
    inst.AnimState:SetBuild("extractor")
	inst.AnimState:PlayAnimation("idle")
	

	--inst:AddComponent("container")
    --inst.components.container:SetNumSlots(1)
    --inst.components.container.widgetslotpos = slotpos
    --inst.components.container.widgetanimbank = nil
	--inst.components.container.widgetanimbuild = nil
	--inst.components.container.widgetbgatlas = "images/inventoryimages/ui_extractor_1x1.xml"
	--inst.components.container.widgetbgimage = "ui_extractor_1x1.tex"	
    --inst.components.container.widgetpos = Vector3(200,0,0)
	--inst.components.container.side_align_tip = 100
    --inst.components.container.acceptsstacks = false

    --inst.components.container.onopenfn = onopen
    --inst.components.container.onclosefn = onclose
	
    inst:AddComponent("inspectable")
	inst.components.inspectable.getstatus = getstatus	
	
	
--[[	inst:AddComponent("burnable")
    inst.components.burnable:AddBurnFX("smokeex", Vector3(-185,-245,0), "fire_marker")
	inst:ListenForEvent("onextinguish", onextinguish)
    inst:ListenForEvent("onignite", onignite)
	
	
	inst:AddComponent("fueled")
    inst.components.fueled.maxfuel = TUNING.NIGHTLIGHT_FUEL_MAX
    inst.components.fueled.accepting = true
    inst.components.fueled.fueltype = "NIGHTMARE"
    inst.components.fueled:SetSections(1)
    inst.components.fueled.ontakefuelfn = function() inst.SoundEmitter:PlaySound("dontstarve/common/nightmareAddFuel") end
    
    inst.components.fueled:SetUpdateFn( function()
        if inst.components.burnable and inst.components.fueled then
            inst.components.burnable:SetFXLevel(inst.components.fueled:GetCurrentSection(), inst.components.fueled:GetSectionPercent())
        end
    end)
        
    inst.components.fueled:SetSectionCallback( function(section)
        if section == 0 then
            inst.components.burnable:Extinguish() 
        else
            if not inst.components.burnable:IsBurning() then
                inst.components.burnable:Ignite()
            end
            
            inst.components.burnable:SetFXLevel(section, inst.components.fueled:GetSectionPercent())
            
        end
    end)
        
    inst.components.fueled:InitializeFuelLevel(TUNING.NIGHTLIGHT_FUEL_START)]]

	inst:AddComponent("chargerer")

	inst.components.chargerer:SetAcceptTest(
		function(inst, item)
			return item.components.chargering.nightmarevalue > 0
		end)
	
	inst.components.chargerer.onaccept = OnGetItemFromPlayer
    inst.components.chargerer.onrefuse = OnRefuseItem
	
	inst:AddComponent("lootdropper")
	inst:AddComponent("norecipelootdropper")	
    inst:AddComponent("workable")
    inst.components.workable:SetWorkAction(ACTIONS.HAMMER)
    inst.components.workable:SetWorkLeft(4)
	inst.components.workable:SetOnFinishCallback(onhammered)
	inst.components.workable:SetOnWorkCallback(onhit) 
	
	inst:ListenForEvent( "onbuilt", onbuilt)

	if IsDLCEnabled(REIGN_OF_GIANTS) or IsDLCEnabled(CAPY_DLC) then 	
	MakeSmallBurnable(inst, nil, nil, true)
	MakeSmallPropagator(inst)
	end
	
	if IsDLCEnabled(CAPY_DLC) then 
	inst:AddComponent("floodable")
	inst.components.floodable.onStartFlooded = onFloodedStart
	inst.components.floodable.onStopFlooded = onFloodedEnd
	inst.components.floodable.floodEffect = "shock_machines_fx"
	inst.components.floodable.floodSound = "dontstarve_DLC002/creatures/jellyfish/electric_land"
	end
	
	inst:ListenForEvent("burntup", makeburnt)
	
	inst.OnSave = onsave 
    inst.OnLoad = onload	

    return inst
end


STRINGS.NAMES.EXTRACTOR = "Alchemy Table"
STRINGS.RECIPE_DESC.EXTRACTOR = "Change items to new forms."

-- Add recipe for extractor
if IsDLCEnabled(CAPY_DLC) then 
local crafting_recipe = Recipe("extractor", {Ingredient("boards", 8),Ingredient("ash", 2), Ingredient("redgem", 1)}, RECIPETABS.MAGIC,  TECH.MAGIC_TWO, RECIPE_GAME_TYPE.COMMON, "extractor_placer")
crafting_recipe.atlas = "images/inventoryimages/extractor.xml"
else
local crafting_recipe = Recipe("extractor", {Ingredient("boards", 6),Ingredient("log", 5), Ingredient("redgem", 1)}, RECIPETABS.MAGIC,  TECH.MAGIC_TWO, "extractor_placer")
crafting_recipe.atlas = "images/inventoryimages/extractor.xml"
end


return Prefab( "common/extractor", fn, assets, prefabs),
	MakePlacer( "common/extractor_placer", "extractor", "extractor", "idle" ) 

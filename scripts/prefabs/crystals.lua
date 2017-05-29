local bluecrystal_assets =
{
	Asset("ANIM", "anim/bluecrystal.zip"),
	Asset("ATLAS", "images/inventoryimages/bluecrystal_map.xml"),
    Asset("IMAGE", "images/inventoryimages/bluecrystal_map.tex"),
}

local redcrystal_assets =
{
	Asset("ANIM", "anim/redcrystal.zip"),
	Asset("ATLAS", "images/inventoryimages/redcrystal_map.xml"),
    Asset("IMAGE", "images/inventoryimages/redcrystal_map.tex"),
}

local orangecrystal_assets =
{
	Asset("ANIM", "anim/orangecrystal.zip"),
	Asset("ATLAS", "images/inventoryimages/orangecrystal_map.xml"),
    Asset("IMAGE", "images/inventoryimages/orangecrystal_map.tex"),
}

local greencrystal_assets =
{
	Asset("ANIM", "anim/greencrystal.zip"),
	Asset("ATLAS", "images/inventoryimages/greencrystal_map.xml"),
    Asset("IMAGE", "images/inventoryimages/greencrystal_map.tex"),
}

local yellowcrystal_assets =
{
	Asset("ANIM", "anim/yellowcrystal.zip"),
	Asset("ATLAS", "images/inventoryimages/yellowcrystal_map.xml"),
    Asset("IMAGE", "images/inventoryimages/yellowcrystal_map.tex"),
}

local prefabs =
{
    "bluegem",
	"redgem",
	"orangegem",
	"greengem",
	"yellowgem",
	"rocks",
	"nitre",
	"nightmarebeak",
}    


SetSharedLootTable( 'blue',
{
	{'bluegem',   1.0},
    {'bluegem',   0.5},
    {'bluegem',   0.3},
    {'bluegem',   0.1},

})

SetSharedLootTable( 'red',
{
	{'redgem',   1.0},
    {'redgem',   0.5},
    {'redgem',   0.3},
    {'redgem',   0.1},

})

SetSharedLootTable( 'orange',
{
	{'orangegem',   1.0},
    {'orangegem',   0.4},
    {'orangegem',   0.2},
    {'orangegem',   0.1},
	{'nightmarebeak', 1,0},
	{'nightmarebeak', 1,0},

})

SetSharedLootTable( 'green',
{
	{'greengem',   1.0},
    {'greengem',   0.4},
    {'greengem',   0.2},
    {'greengem',   0.1},

})

SetSharedLootTable( 'yellow',
{
	{'yellowgem',   1.0},
	{'yellowgem',   0.4},
	{'yellowgem',   0.2},
    {'yellowgem',   0.1},
    {'nitre',   0.8},
    {'nitre',   0.3},

})

local function baserock_fn(Sim)
	local inst = CreateEntity()
	local trans = inst.entity:AddTransform()
	local anim = inst.entity:AddAnimState()
	inst.entity:AddSoundEmitter()
	
	MakeObstaclePhysics(inst, 1.)
	
	inst:AddComponent("lootdropper") 
	
	inst:AddComponent("workable")
	inst.components.workable:SetWorkAction(ACTIONS.MINE) 

    local color = 0.5 + math.random() * 0.5
    anim:SetMultColour(color, color, color, 1)    

	inst:AddComponent("inspectable")
	inst.components.inspectable.nameoverride = "ROCK"
	MakeSnowCovered(inst, .01)        
	return inst
end

local function bluecrystal_fn(Sim)
	local inst = baserock_fn(Sim)
	
	local minimap = inst.entity:AddMiniMapEntity()
	minimap:SetIcon( "bluecrystal_map.tex" )
	
	local light = inst.entity:AddLight()
		inst.Light:Enable(true)
		inst.Light:SetRadius(2.5)
		inst.Light:SetFalloff(1)
		inst.Light:SetIntensity(0.8)
		inst.Light:SetColour(80/255,230/255,248/255)
	
	inst.components.workable:SetOnWorkCallback(
		function(inst, worker, workleft)
			local pt = Point(inst.Transform:GetWorldPosition())
			if workleft <= 0 then
				inst.SoundEmitter:PlaySound("dontstarve/wilson/rock_break")
				inst.components.lootdropper:DropLoot(pt)
				inst:Remove()
			else
				
				
				if workleft < TUNING.ROCKS_MINE*(1/3) then
					inst.AnimState:PlayAnimation("low")
				elseif workleft < TUNING.ROCKS_MINE*(2/3) then
					inst.AnimState:PlayAnimation("med")
				else
					inst.AnimState:PlayAnimation("full")
				end
			end
			
			    if worker and worker.components.temperature then
					local temp = worker.components.temperature:GetCurrent()
					worker.components.temperature:SetTemperature(temp - 45)
				end
			
		end)    
	
	
	inst.AnimState:SetBank("bluecrystal")
	inst.AnimState:SetBuild("bluecrystal")
	inst.AnimState:PlayAnimation("full")
	
	inst.components.workable:SetWorkLeft(TUNING.ROCKS_MINE)

	inst.components.lootdropper:SetChanceLootTable('blue')

	return inst
end

local function redcrystal_fn(Sim)
	local inst = baserock_fn(Sim)
	
	local minimap = inst.entity:AddMiniMapEntity()
	minimap:SetIcon( "redcrystal_map.tex" )
	
	local light = inst.entity:AddLight()
		inst.Light:Enable(true)
		inst.Light:SetRadius(2.5)
		inst.Light:SetFalloff(1)
		inst.Light:SetIntensity(0.8)
		inst.Light:SetColour(255/255,27/255,43/255)
	
	inst.components.workable:SetOnWorkCallback(
		function(inst, worker, workleft)
			local pt = Point(inst.Transform:GetWorldPosition())
			if workleft <= 0 then
				inst.SoundEmitter:PlaySound("dontstarve/wilson/rock_break")
				inst.components.lootdropper:DropLoot(pt)
				inst:Remove()
			else
				
				
				if workleft < TUNING.ROCKS_MINE*(1/3) then
					inst.AnimState:PlayAnimation("low")
				elseif workleft < TUNING.ROCKS_MINE*(2/3) then
					inst.AnimState:PlayAnimation("med")
				else
					inst.AnimState:PlayAnimation("full")
				end
			end
			
				if worker and worker.components.temperature then
					local temp = worker.components.temperature:GetCurrent()
					worker.components.temperature:SetTemperature(temp + 55)
				end
			
		end)    
	
	inst.AnimState:SetBank("redcrystal")
	inst.AnimState:SetBuild("redcrystal")
	inst.AnimState:PlayAnimation("full")
	
	inst.components.workable:SetWorkLeft(TUNING.ROCKS_MINE)

	inst.components.lootdropper:SetChanceLootTable('red')

	return inst
end

local function orangecrystal_fn(Sim)
	local inst = baserock_fn(Sim)
	
	local minimap = inst.entity:AddMiniMapEntity()
	minimap:SetIcon( "orangecrystal_map.tex" )
	
	local light = inst.entity:AddLight()
		inst.Light:Enable(true)
		inst.Light:SetRadius(2.5)
		inst.Light:SetFalloff(1)
		inst.Light:SetIntensity(0.8)
		inst.Light:SetColour(255/255,178/255,103/255)
	
	inst.components.workable:SetOnWorkCallback(
		function(inst, worker, workleft)
			local pt = Point(inst.Transform:GetWorldPosition())
			if workleft <= 0 then
				inst.SoundEmitter:PlaySound("dontstarve/wilson/rock_break")
				inst.components.lootdropper:DropLoot(pt)
				inst:Remove()
			else
				
				
				if workleft < TUNING.ROCKS_MINE*(1/3) then
					inst.AnimState:PlayAnimation("low")
				elseif workleft < TUNING.ROCKS_MINE*(2/3) then
					inst.AnimState:PlayAnimation("med")
				else
					inst.AnimState:PlayAnimation("full")
				end
			end
			
	end)   
	
	inst.AnimState:SetBank("orangecrystal")
	inst.AnimState:SetBuild("orangecrystal")
	inst.AnimState:PlayAnimation("full")
	
	inst.components.workable:SetWorkLeft(TUNING.ROCKS_MINE)

	inst.components.lootdropper:SetChanceLootTable('orange')

	return inst
end

local function greencrystal_fn(Sim)
	local inst = baserock_fn(Sim)
	
	local light = inst.entity:AddLight()
		inst.Light:Enable(true)
		inst.Light:SetRadius(2.5)
		inst.Light:SetFalloff(1)
		inst.Light:SetIntensity(0.8)
		inst.Light:SetColour(77/255,250/255,77/255)
	
	local minimap = inst.entity:AddMiniMapEntity()
	minimap:SetIcon( "greencrystal_map.tex" )
	
	inst.components.workable:SetOnWorkCallback(
		function(inst, worker, workleft)
			local pt = Point(inst.Transform:GetWorldPosition())
			if workleft <= 0 then
				inst.SoundEmitter:PlaySound("dontstarve/wilson/rock_break")
				inst.components.lootdropper:DropLoot(pt)
				inst:Remove()
			else
				
				
				if workleft < TUNING.ROCKS_MINE*(1/3) then
					inst.AnimState:PlayAnimation("low")
				elseif workleft < TUNING.ROCKS_MINE*(2/3) then
					inst.AnimState:PlayAnimation("med")
				else
					inst.AnimState:PlayAnimation("full")
				end
			end
			
	end)  	
	
	inst.AnimState:SetBank("greencrystal")
	inst.AnimState:SetBuild("greencrystal")
	inst.AnimState:PlayAnimation("full")
	
	inst.components.workable:SetWorkLeft(18)

	inst.components.lootdropper:SetChanceLootTable('green')

	return inst
end

local function yellowcrystal_fn(Sim)
	local inst = baserock_fn(Sim)
	
	local light = inst.entity:AddLight()
		inst.Light:Enable(true)
		inst.Light:SetRadius(2.5)
		inst.Light:SetFalloff(1)
		inst.Light:SetIntensity(0.8)
		inst.Light:SetColour(255/255,233/255,114/255)
	
	local minimap = inst.entity:AddMiniMapEntity()
	minimap:SetIcon( "yellowcrystal_map.tex" )
	
	inst.components.workable:SetOnWorkCallback(
		function(inst, worker, workleft)
			local pt = Point(inst.Transform:GetWorldPosition())
			if workleft <= 0 then
				inst.SoundEmitter:PlaySound("dontstarve/wilson/rock_break")
				inst.components.lootdropper:DropLoot(pt)
				inst:Remove()
			else
				
				
				if workleft < TUNING.ROCKS_MINE*(1/3) then
					inst.AnimState:PlayAnimation("low")
				elseif workleft < TUNING.ROCKS_MINE*(2/3) then
					inst.AnimState:PlayAnimation("med")
				else
					inst.AnimState:PlayAnimation("full")
				end
			end
			
			if worker then
				local strike = GetPlayer():GetPosition()
				worker.components.health:DoDelta(-20,0,0)
				worker.AnimState:PlayAnimation("shock")
				GetSeasonManager():DoLightningStrike(strike)
			end 
			
	end)  	
	
	inst.AnimState:SetBank("yellowcrystal")
	inst.AnimState:SetBuild("yellowcrystal")
	inst.AnimState:PlayAnimation("full")
	
	inst.components.workable:SetWorkLeft(TUNING.ROCKS_MINE)

	inst.components.lootdropper:SetChanceLootTable('yellow')

	return inst
end

STRINGS.NAMES.BLUECRYSTAL = "Crystals"
STRINGS.NAMES.REDCRYSTAL = "Crystals"
STRINGS.NAMES.ORANGECRYSTAL = "Crystals"
STRINGS.NAMES.GREENCRYSTAL = "Crystals"
STRINGS.NAMES.YELLOWCRYSTAL = "Crystals"

return Prefab("forest/objects/rocks/bluecrystal", bluecrystal_fn, bluecrystal_assets, prefabs),
Prefab("forest/objects/rocks/redcrystal", redcrystal_fn, redcrystal_assets, prefabs),
Prefab("forest/objects/rocks/orangecrystal", orangecrystal_fn, orangecrystal_assets, prefabs),
Prefab("forest/objects/rocks/greencrystal", greencrystal_fn, greencrystal_assets, prefabs),
Prefab("forest/objects/rocks/yellowcrystal", yellowcrystal_fn, yellowcrystal_assets, prefabs)


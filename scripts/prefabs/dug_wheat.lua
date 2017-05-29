local assets =
{
	Asset("ANIM", "anim/wheat.zip"),
	
	Asset("ATLAS", "images/inventoryimages/dug_wheat.xml"),
	
	Asset("IMAGE", "images/inventoryimages/dug_wheat.tex"),
}


local function test_ground(inst, pt)
	local tiletype = GetGroundTypeAtPosition(pt)
	local ground_OK = tiletype == GROUND.GRASS or tiletype == GROUND.FOREST or tiletype == GROUND.DECIDUOUS
	
	if ground_OK then
	    local ents = TheSim:FindEntities(pt.x,pt.y,pt.z, 4)
		local min_spacing = inst.components.deployable.min_spacing or 2

	    for k, v in pairs(ents) do
			if v ~= inst and v.entity:IsValid() and v.entity:IsVisible() and not v:HasTag("player") and not v.components.placer and v.parent == nil and not v:HasTag("FX") then
				if distsq( Vector3(v.Transform:GetWorldPosition()), pt) < min_spacing*min_spacing then
					return false
				end
			end
		end
		
		return true

	end
	return false
	
end


local function CanDeploy(inst) return true end

local function ondeploy(inst, pt)
	local tree = SpawnPrefab("wheat") 
	if tree then 
		tree.Transform:SetPosition(pt.x, pt.y, pt.z) 
		inst.components.stackable:Get():Remove()
		tree.components.pickable:OnTransplant()
		tree.SoundEmitter:PlaySound("dontstarve/wilson/pickup_reeds")
	end 
end


	local function fn(Sim)
		local inst = CreateEntity()
		inst.entity:AddTransform()
		inst.entity:AddAnimState()
		--inst.entity:AddSoundEmitter()
		MakeInventoryPhysics(inst)
	    
		inst.AnimState:SetBank("wheat")
		inst.AnimState:SetBuild("wheat")
		inst.AnimState:PlayAnimation("dropped")

		inst:AddComponent("pickable")
		
		inst:AddComponent("stackable")
		inst.components.stackable.maxsize = TUNING.STACK_SIZE_LARGEITEM
		
		inst:AddComponent("inspectable")
		
		inst:AddComponent("inventoryitem")
			inst.components.inventoryitem.atlasname = "images/inventoryimages/dug_wheat.xml"
	    inst.components.inventoryitem.imagename = "dug_wheat"
		
		inst:AddComponent("fuel")
		inst.components.fuel.fuelvalue = TUNING.LARGE_FUEL
	    

        MakeMediumBurnable(inst, TUNING.LARGE_BURNTIME)
		MakeSmallPropagator(inst)
		
	    inst:AddComponent("deployable")
	    --inst.components.deployable.test = function() return true end
	    inst.components.deployable.ondeploy = ondeploy
	    inst.components.deployable.test = test_ground
	    inst.components.deployable.min_spacing = 2
	    
		
	    
		---------------------  
		return inst      
	end
	
	STRINGS.NAMES.DUG_WHEAT = "Wheat Tuft"

-- Randomizes the inspection line upon inspection.
STRINGS.CHARACTERS.GENERIC.DESCRIBE.DUG_WHEAT = {	
	"I should plant this",

}
STRINGS.CHARACTERS.WX78.DESCRIBE.DUG_WHEAT = {	
	"IT WOULD BE MORE USEFUL IN THE GROUND",

}


	return Prefab( "common/objects/dug_wheat", fn, assets),
		MakePlacer( "common/dug_wheat_placer", "wheat", "wheat", "idle")
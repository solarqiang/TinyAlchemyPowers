local ACTIONS = GLOBAL.ACTIONS
local STRINGS = GLOBAL.STRINGS
ActionHandler = GLOBAL.ActionHandler
Vector3 = GLOBAL.Vector3

GLOBAL.STRINGS.ACTIONS.EXTRACTT = "Transmute"
GLOBAL.STRINGS.ACTIONS.INSERTCHARGER = "Add Fuel"

function AlchemySimPostInit()

ACTIONS.EXTRACTT = GLOBAL.Action()
ACTIONS.INSERTCHARGER = GLOBAL.Action()
-- Extraction function based on Cook action
ACTIONS.EXTRACTT.fn = function(act)
	if act.target.components.streamer then
	    local ingredient = act.doer.components.inventory:RemoveItem(act.invobject)
	    
        if ingredient.components.health and ingredient.components.combat then
            act.doer:PushEvent("killed", {victim = ingredient})
        end
        
	    local product = act.target.components.streamer:CookItem(ingredient, act.doer)
	    if product then
	        act.doer.components.inventory:GiveItem(product,nil, Vector3(TheSim:GetScreenPos(act.target.Transform:GetWorldPosition()) ))
	        return true
	    end
	elseif act.target.components.stewer then
		act.target.components.stewer:StartCooking()
		return true
    end
end

ACTIONS.INSERTCHARGER.fn = function(act)
if act.target.components.chargerer then
		act.target.components.chargerer:AcceptGift(act.doer, act.invobject)
	    return true
    end
end

-- for function (required to extract action)

for k,v in pairs(ACTIONS) do
	 if k == "EXTRACTT" or "INSERTCHARGER" then
    		v.str = STRINGS.ACTIONS[k] or "ACTION"
   		 v.id = k
	 end
end 

-- required to extract animation

local function addActionHandler(SGname, action, state, condition)
	actionHandler = GLOBAL.ActionHandler(action, state, condition)
	for k,v in pairs(GLOBAL.SGManager.instances) do	
		if(k.sg.name == SGname) then
			k.sg.actionhandlers[action] = actionHandler
			break
		end
	end 
end

local function addState(SGname, state)
	 for k,v in pairs(GLOBAL.SGManager.instances) do	
		if(k.sg.name == SGname) then
			k.sg.states[state.name] =  state
			break
		end
	 end
end

-- Extraction anim and sound

addActionHandler("wilson", GLOBAL.ACTIONS.EXTRACTT, "extractt")

local extractt = GLOBAL.State{
        name = "extractt",
        tags = {"doing"},
        
        onenter = function(inst, timeout)
            
            inst.sg:SetTimeout(timeout or 1)
            inst.components.locomotor:Stop()
            inst.SoundEmitter:PlaySound("dontstarve/rain/thunder_close", "make")
            
            inst.AnimState:PlayAnimation("build_pre")
            inst.AnimState:PushAnimation("build_loop", true)
        end,
        
        ontimeout= function(inst)
            inst.AnimState:PlayAnimation("build_pst")
            inst.sg:GoToState("idle", false)
            inst:PerformBufferedAction()
        
        end,
        
        onexit= function(inst)
            inst.SoundEmitter:KillSound("make")
        end, 
    }

    addState("wilson", extractt)
	
addActionHandler("wilson", GLOBAL.ACTIONS.INSERTCHARGER, "insertcharger")

local insertcharger = GLOBAL.State{
        name = "insertcharger",

        
		onenter = function(inst)
            inst.components.locomotor:Stop()
            inst.AnimState:PlayAnimation("give") 
        end,
        
        timeline =
        {
            GLOBAL.TimeEvent(13*GLOBAL.FRAMES, function(inst)
                inst:PerformBufferedAction()
            end),
        },        

        events=
        {
            GLOBAL.EventHandler("animover", function(inst) inst.sg:GoToState("idle") end ),
        },
    }

    addState("wilson", insertcharger)
	
	end
AddSimPostInit(AlchemySimPostInit)
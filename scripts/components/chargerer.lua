local Chargerer = Class(function(self, inst)
    self.inst = inst
    self.enabled = true
end)


function Chargerer:IsTryingToTradeWithMe(inst)
    local act = inst:GetBufferedAction()
    if act then
        return act.target == self.inst and act.action == ACTIONS.INSERTCHARGER
    end
end

function Chargerer:Enable( fn )
    self.enabled = true
end

function Chargerer:Disable( fn )
    self.enabled = false
end

function Chargerer:SetAcceptTest( fn )
    self.test = fn
end

function Chargerer:CanAccept( item )
    return self.enabled and (not self.test or self.test(self.inst, item))
end

function Chargerer:AcceptGift( giver, item )
    
    if not self.enabled then
        return false
    end
    
   
    if self:CanAccept(item) then

		if item.components.stackable and item.components.stackable.stacksize > 1 then
			item = item.components.stackable:Get()
		else
			item.components.inventoryitem:RemoveFromOwner()
		end
        
        if self.inst.components.inventory then
            self.inst.components.inventory:GiveItem(item)
        else
            item:Remove()
        end
        
		if self.onaccept then
			self.onaccept(self.inst, giver, item)
		end
		
        self.inst:PushEvent("trade", {giver = giver, item = item})

        return true
    end

	if self.onrefuse then
		self.onrefuse(self.inst, giver, item)
	end
end

return Chargerer

local extractable = Class(function(self, inst)
    self.inst = inst
    self.product = nil
    self.oncooked = nil
end)

function extractable:SetOnCookedFn(fn)
	self.oncooked = fn
end

function extractable:Cook(streamer, chef)
    if self.oncooked then
		self.oncooked(self.inst, streamer, chef)
    end
    if self.product then
        local prefab = self.product
        if type(self.product) == "function" then
            prefab = self.product(self.inst)
        end
        local prod = SpawnPrefab(prefab)
        
        if prod then
			if self.inst.components.perishable and prod.components.perishable then
				
				local new_percent = 1 - (1 - self.inst.components.perishable:GetPercent())*.5
				prod.components.perishable:SetPercent(new_percent)
			end
			
			
			return prod
        end
    end
end


function extractable:CollectUseActions(doer, target, actions)
    if target.components.streamer then
        table.insert(actions, ACTIONS.EXTRACTT)
    end
end



return extractable
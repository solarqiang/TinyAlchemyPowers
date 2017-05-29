local Chargering = Class(function(self, inst)
    self.inst = inst
    self.nightmarevalue = 0
end)

function Chargering:CollectUseActions(doer, target, actions)
    if target.components.chargerer and target.components.chargerer.enabled then
        table.insert(actions, ACTIONS.INSERTCHARGER)
    end
end


return Chargering
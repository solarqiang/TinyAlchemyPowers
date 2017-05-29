local streamer = Class(function(self, inst)
    self.inst = inst
end)


function streamer:CookItem(item, chef)
    if item and item.components.extractable then

        
        local newitem = item.components.extractable:Cook(self.inst, chef)
        ProfileStatsAdd("cooked_"..item.prefab)

        if self.oncookitem then
            self.oncookitem(item, newitem)
        end
        
        --if self.inst.SoundEmitter then
          --  self.inst.SoundEmitter:PlaySound("dontstarve/wilson/cook")        
       -- end

        item:Remove()
        return newitem
    end
end


return streamer

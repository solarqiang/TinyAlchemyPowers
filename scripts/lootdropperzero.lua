function lootdropperzero(inst)

	inst.GenerateLoot = function(self)
    local loots = {}
    
    if self.numrandomloot and math.random() <= (self.chancerandomloot or 1) then
		for k = 1, self.numrandomloot do
		    local loot = self:PickRandomLoot()
		    if loot then
			    table.insert(loots, loot)
			end
		end
	end
    
    if self.chanceloot then
		for k,v in pairs(self.chanceloot) do
			if math.random() < v.chance then
				table.insert(loots, v.prefab)
				self.droppingchanceloot = true
			end
		end
	end

    if self.chanceloottable then
    	local loot_table = GLOBAL.LootTables[self.chanceloottable]
    	if loot_table then
    		for i, entry in ipairs(loot_table) do
    			local prefab = entry[1]
    			local chance = entry[2]    			
				if math.random() <= chance then
					table.insert(loots, prefab)
					self.droppingchanceloot = true
				end
			end
		end
	end

	if not self.droppingchanceloot and self.ifnotchanceloot then
		self.inst:PushEvent("ifnotchanceloot")
		for k,v in pairs(self.ifnotchanceloot) do
			table.insert(loots, v.prefab)
		end
	end


    
    if self.loot then
		for k,v in ipairs(self.loot) do
			table.insert(loots, v)
		end
	end
	
	local recipe = GLOBAL.GetRecipe(self.inst.prefab)

	if recipe and not self.inst.components.norecipelootdropper then
	

		
		local percent = 1

		if self.inst.components.finiteuses then
			percent = self.inst.components.finiteuses:GetPercent()
		end

		for k,v in ipairs(recipe.ingredients) do
			local amt = math.ceil( (v.amount * TUNING.HAMMER_LOOT_PERCENT) * percent)
			for n = 1, amt do
				table.insert(loots, v.type)
			end
		end
	end
    
    return loots

    end


end	   

AddComponentPostInit("lootdropper", lootdropperzero)
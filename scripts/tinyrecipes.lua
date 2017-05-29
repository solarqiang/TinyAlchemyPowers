-- Crock Pot food

local butter =
	{
		name = "butter",
		test = function(cooker, names, tags) return tags.dairy and names.butterflywings and not names.twigs end,
		priority = 1,
		weight = 1,
		--foodtype = "VEGGIE",
		health = TUNING.HEALING_LARGE,
		hunger = TUNING.CALORIES_MED,
		--sanity = TUNING.SANITY_LARGE,
		perishtime = TUNING.PERISH_SUPERSLOW,
		cooktime = .5,
	}

	

local bread =
	{
		name = "bread",
		test = function(cooker, names, tags) return tags.dairy and tags.loose and tags.egg and not tags.meat end,
		priority = 10,
		weight = 1,
		--foodtype = "VEGGIE",
		health = TUNING.HEALING_MED,
		hunger = TUNING.CALORIES_MED,
		sanity = TUNING.SANITY_MEDLARGE*3,
		perishtime = TUNING.PERISH_MED,
		cooktime = 1,
	}


local cheese =
	{
		name = "cheese",
		test = function(cooker, names, tags) return tags.dairy and tags.dairy >=2 and not tags.meat end,
		priority = 9,
		weight = 1,
		--foodtype = "VEGGIE",
		health = TUNING.HEALING_MED,
		hunger = TUNING.CALORIES_LARGE,
		--sanity = TUNING.SANITY_MED,
		perishtime = TUNING.PERISH_SLOW,
		cooktime = .75,
	}



local fernspinach =
	{
		name = "fernspinach",
		test = function(cooker, names, tags) return tags.foliage and tags.foliage >=1 and not tags.meat end,
		priority = 5,
		weight = 1,
		foodtype = "VEGGIE",
		health = TUNING.HEALING_SMALL,
		hunger = TUNING.CALORIES_MED,
		sanity = TUNING.SANITY_TINY,
		perishtime = TUNING.PERISH_MED,
		cooktime = .5,
	}


local bananapie =
	{
		name = "bananapie",
		test = function(cooker, names, tags) return (names.cave_banana or names.cave_banana_cooked) and not tags.meat end,
		priority = 1,
		weight = 1,
		foodtype = "VEGGIE",
		health = TUNING.HEALING_SMALL*2,
		hunger = TUNING.CALORIES_LARGE,
		sanity = TUNING.SANITY_MED,
		perishtime = TUNING.PERISH_SLOW,
		cooktime = 2,
	}

	
local mushroomsoup =
	{
		name = "mushroomsoup",
		test = function(cooker, names, tags) return (names.red_cap or names.red_cap_cooked or names.green_cap or names.green_cap_cooked or names.blue_cap or names.blue_cap_cooked) and tags.loose and not tags.meat end,
		priority = 1,
		weight = 1,
		foodtype = "VEGGIE",
		health = TUNING.HEALING_SMALL,
		hunger = TUNING.CALORIES_LARGE,
		sanity = TUNING.SANITY_TINY,
		perishtime = TUNING.PERISH_FAST,
		cooktime = 2,
	}

	

	local nutmuffin =
	{
		name = "nutmuffin",
		test = function(cooker, names, tags) return (names.acorn_cooked) and tags.loose and not tags.meat end,
		priority = 1,
		weight = 1,
		foodtype = "VEGGIE",
		health = TUNING.HEALING_MED,
		hunger = TUNING.CALORIES_LARGE,
		sanity = TUNING.SANITY_TINY,
		perishtime = TUNING.PERISH_SLOW,
		cooktime = 1.5,
	}

	
	local oversalt =
	{
		name = "oversalt",
		test = function(cooker, names, tags) return tags.salt and tags.salt >=2 end,
		priority = 5,
		weight = 1,
		--foodtype = "VEGGIE",
		health = 0,
		hunger = 0,
		sanity = 0,
		perishtime = TUNING.PERISH_FAST,
		cooktime = .25,
	}

	
		local truffleham =
	{
		name = "truffleham",
		test = function(cooker, names, tags) return tags.truffles and tags.meat and tags.meat > 1.5 and not tags.inedible end,
		priority = 1,
		weight = 1,
		foodtype = "MEAT",
		health = TUNING.HEALING_MED,
		hunger = TUNING.CALORIES_HUGE,
		sanity = TUNING.SANITY_LARGE,
		perishtime = TUNING.PERISH_SLOW,
		cooktime = 1.5,
	}

	
		local truffleegs =
	{
		name = "truffleegs",
		test = function(cooker, names, tags) return tags.egg and tags.egg > 1 and tags.truffles and tags.truffles >= 1 and not tags.veggie end,
		priority = 1,
		weight = 1,
		foodtype = "MEAT",
		health = TUNING.HEALING_MEDSMALL,
		hunger = TUNING.CALORIES_HUGE,
		sanity = TUNING.SANITY_LARGE,
		perishtime = TUNING.PERISH_PRESERVED,
		cooktime = 1.5,
	}


		local cactus_cocktail =
	{
		name = "cactus_cocktail",
		test = function(cooker, names, tags) return ((names.cactus_meat and names.cactus_meat>=3) or (names.cactus_meat_cooked and names.cactus_meat_cooked>=3) or (names.cactus_meat and names.cactus_meat_cooked and (names.cactus_meat+names.cactus_meat_cooked)>=3)) and not tags.meat end,
		priority = 1,
		weight = 1,
		foodtype = "VEGGIE",
		health = TUNING.HEALING_MEDSMALL,
		hunger = TUNING.CALORIES_SMALL,
		sanity = TUNING.SANITY_MEDLARGE,
		perishtime = TUNING.PERISH_FAST,
		cooktime = .5,
	}



	local ribs =
	{
		name = "ribs",
		test = function(cooker, names, tags) return (names.cactus_meat or names.cactus_meat_cooked) and tags.loose and tags.meat and tags.meat <= 1.5 and not tags.inedible end,
		priority = 2,
		weight = 1,
		foodtype = "MEAT",
		health = TUNING.HEALING_MED,
		hunger = TUNING.CALORIES_HUGE,
		sanity = TUNING.SANITY_MEDLARGE,
		perishtime = TUNING.PERISH_SLOW,
		cooktime = 2,
	}


	
		local pancakes =
	{
		name = "pancakes",
		test = function(cooker, names, tags) return tags.sweetener and tags.loose and tags.egg end,
		priority = 4,
		weight = 1,
		foodtype = "VEGGIE",
		health = TUNING.HEALING_LARGE,
		hunger = TUNING.CALORIES_MED*2,
		sanity = TUNING.SANITY_TINY,
		perishtime = TUNING.PERISH_FAST,
		cooktime = 1,
	}

	
	
		local lemon_cocktail =
	{
		name = "lemon_cocktail",
		test = function(cooker, names, tags) return ((names.nuts and names.nuts>=3) or (names.nuts_cooked and names.nuts_cooked>=3) or (names.nuts and names.nuts_cooked and (names.nuts+names.nuts_cooked)>=3)) and not tags.meat and not tags.veggie end,
		priority = 1,
		weight = 1,
		foodtype = "VEGGIE",
		health = TUNING.HEALING_MEDSMALL,
		hunger = TUNING.CALORIES_SMALL,
		sanity = TUNING.SANITY_MEDLARGE,
		perishtime = TUNING.PERISH_FAST,
		cooktime = .5,
	}
	
		local lime_cocktail =
	{
		name = "lime_cocktail",
		test = function(cooker, names, tags) return ((names.lime and names.lime>=3) or (names.lime_cooked and names.lime_cooked>=3) or (names.lime and names.lime_cooked and (names.lime+names.lime_cooked)>=3)) and not tags.meat and not tags.veggie end,
		priority = 1,
		weight = 1,
		foodtype = "VEGGIE",
		health = TUNING.HEALING_MEDSMALL,
		hunger = TUNING.CALORIES_SMALL,
		sanity = TUNING.SANITY_MEDLARGE,
		perishtime = TUNING.PERISH_FAST,
		cooktime = .5,
	}
	
	local limpetspizza =
	{
		name = "limpetspizza",
		test = function(cooker, names, tags) return (names.limpets or names.limpets_cooked) and names.salt and tags.loose and not tags.inedible end,
		priority = 6,
		weight = 1,
		foodtype = "MEAT",
		health = TUNING.HEALING_MED,
		hunger = TUNING.CALORIES_HUGE,
		sanity = TUNING.SANITY_MEDLARGE,
		perishtime = TUNING.PERISH_SLOW,
		cooktime = 2,
	}

	
function Cooking()
if GLOBAL.IsDLCEnabled(GLOBAL.REIGN_OF_GIANTS) or GLOBAL.IsDLCEnabled(GLOBAL.CAPY_DLC) then 	

	AddIngredientValues({"cactus_meat"}, {veggie=1, cactus=1})
	AddIngredientValues({"cactus_meat_cooked"}, {veggie=1, cactus=1})
	AddCookerRecipe("cookpot",ribs)
	AddCookerRecipe("cookpot",cactus_cocktail)
	AddCookerRecipe("cookpot",nutmuffin)
	AddCookerRecipe("cookpot",lime_cocktail)
	AddCookerRecipe("cookpot",limpetspizza)

end

	AddIngredientValues({"foliage"}, {foliage=.5})
	AddCookerRecipe("cookpot",lemon_cocktail)
	AddCookerRecipe("cookpot",pancakes)
	AddCookerRecipe("cookpot",truffleegs)
	AddCookerRecipe("cookpot",truffleham)
	AddCookerRecipe("cookpot",oversalt)
	AddCookerRecipe("cookpot",mushroomsoup)	
	AddCookerRecipe("cookpot",bananapie)
	AddCookerRecipe("cookpot",fernspinach)
	AddCookerRecipe("cookpot",cheese)
	AddCookerRecipe("cookpot",bread)
	AddCookerRecipe("cookpot",butter)
	
end

AddGamePostInit(Cooking)
-- Set local 
local AxeLvl
local FitnessLvl
local NimbleLvl
local LightfootedLvl
local SprintingLvl	
local SneakLvl

local SOMWActivated

local SOTOSbvars = SandboxVars.SOTO;

-- Checking skill levels
function checkskillslevel()
	local player = getPlayer();
	if player == nil then
		return
	end

	AxeLvl = player:getPerkLevel(Perks.Axe);
	FitnessLvl = player:getPerkLevel(Perks.Fitness);
	SneakLvl = player:getPerkLevel(Perks.Sneak);	
	NimbleLvl = player:getPerkLevel(Perks.Nimble);
	SprintingLvl = player:getPerkLevel(Perks.Sprinting);		
	LightfootedLvl = player:getPerkLevel(Perks.Lightfoot);	

	if getActivatedMods():contains("SimpleOverhaulMeleeWeapons") == true then
		SOMWActivated = 1;
		else SOMWActivated = 0;
	end

end

Events.OnGameStart.Add(checkskillslevel);
Events.LevelPerk.Add(checkskillslevel);
Events.OnCreatePlayer.Add(checkskillslevel);
Events.OnCreateLivingCharacter.Add(checkskillslevel);

--- INCREASE AND DECREASE STATS ---
-- DRUNKENNESS
function SODecDrunkenness(player, chance, drunkenness)
	local HundredChance = ZombRand(100);
	if HundredChance <= chance then
		local currentDrunkenness = player:getStats():getDrunkenness();
		player:getStats():setDrunkenness(currentDrunkenness - drunkenness);
		if player:getStats():getDrunkenness() < 0 then
			player:getStats():setDrunkenness(0);
		end	
	end
end

-- BOREDOM
function SODecBoredom(player, chance, boredom)
	local HundredChance = ZombRand(100);
	if HundredChance <= chance then
		local currentBoredom = player:getBodyDamage():getBoredomLevel();
		player:getBodyDamage():setBoredomLevel(currentBoredom - boredom);
		if player:getBodyDamage():getBoredomLevel() < 0 then
			player:getBodyDamage():setBoredomLevel(0);
		end
	end
end

-- HUNGER
function SOAddHunger(player, chance, hunger)
	local HundredChance = ZombRand(100);
	local HeartyAppititeMult = 1
	local LightEaterMult = 1	
	if HundredChance <= chance then
		local currentHunger = player:getStats():getHunger();
		if player:HasTrait("HeartyAppitite") then
			HeartyAppititeMult = 1.50
		end	
		if player:HasTrait("LightEater") then
			LightEaterMult = 0.75
		end	
		player:getStats():setHunger(currentHunger + (hunger * (HeartyAppititeMult * LightEaterMult)));
		if player:getStats():getHunger() > 0.999 then
			player:getStats():setHunger(0.999);
		end
	end
end	
function SODecHunger(player, chance, hunger)
	local HundredChance = ZombRand(100);
	if HundredChance <= chance then
		local currentHunger = player:getStats():getHunger();
		player:getStats():setHunger(currentHunger - hunger);
		if player:getStats():getHunger() < 0 then
			player:getStats():setHunger(0);
		end
	end
end	

-- THIRST
function SOAddThirst(player, chance, thirst)
	local HundredChance = ZombRand(100);
	local HighThirstMult = 1
	local LowThirstMult = 1			
	if HundredChance <= chance then
		local currentThirst = player:getStats():getThirst();
		if player:HasTrait("HighThirst") then
			HighThirstMult = 2.0
		end	
		if player:HasTrait("LowThirst") then
			LowThirstMult = 0.50
		end			
		player:getStats():setThirst(currentThirst + (thirst * (HighThirstMult * LowThirstMult)));
		if player:getStats():getThirst() > 0.999 then
			player:getStats():setThirst(0.999);
		end
	end
end	
function SODecThirst(player, chance, thirst)
	local HundredChance = ZombRand(100);
	if HundredChance <= chance then
		local currentThirst = player:getStats():getThirst();
		player:getStats():setThirst(currentThirst - thirst);
		if player:getStats():getThirst() < 0 then
			player:getStats():setThirst(0);
		end
	end
end	

-- WETNESS
function SOAddWetness(player, chance, wetness)
	local HundredChance = ZombRand(100);
	local OverweightMult = 1
	local ObeseMult = 1			
	if HundredChance <= chance then
		local currentWetness = player:getBodyDamage():getWetness();
		if player:HasTrait("Overweight") then
			OverweightMult = 1.2
		end	
		if player:HasTrait("Obese") then
			ObeseMult = 1.4
		end	
		player:getBodyDamage():setWetness(currentWetness + (wetness * (OverweightMult * ObeseMult)));
		if player:getBodyDamage():getWetness() > 99 then
			player:getBodyDamage():setWetness(99);
		end
	end
end	
function SODecWetness(player, chance, wetness)
	local HundredChance = ZombRand(100);
	if HundredChance <= chance then
		local currentWetness = player:getBodyDamage():getWetness();
		local OverweightMult = 1
		local ObeseMult = 1		
		if player:HasTrait("Overweight") then
			OverweightMult = 0.8
		end	
		if player:HasTrait("Obese") then
			ObeseMult = 0.6
		end	
		player:getBodyDamage():setWetness(currentWetness - (wetness * (OverweightMult * ObeseMult)));
		if player:getBodyDamage():getWetness() < 0 then
			player:getBodyDamage():setWetness(0);
		end
	end
end	

-- STRESS
function SOAddStress(player, chance, stress)
	local HundredChance = ZombRand(100);
	if HundredChance <= chance then
		local currentStress = player:getStats():getStress();
		player:getStats():setStress(currentStress + stress);
		if player:getStats():getStress() > 0.999 then
			player:getStats():setStress(0.999);
		end
	end
end
function SODecStress(player, chance, stress)
	local HundredChance = ZombRand(100);
	if HundredChance <= chance then
		local currentStress = player:getStats():getStress();
		player:getStats():setStress(currentStress - stress);
		if player:getStats():getStress() < 0 then
			player:getStats():setStress(0);
		end
	end
end

-- CIGARETTES STRESS
function SOAddCigStress(player, chance, cigstress)
	local HundredChance = ZombRand(100);
	if HundredChance <= chance then
		local currentCigarettesStress = player:getStats():getStressFromCigarettes();
		player:getStats():setStressFromCigarettes(currentCigarettesStress + cigstress);
		if player:getStats():getStressFromCigarettes() > 0.999 then
			player:getStats():setStressFromCigarettes(0.999);
		end
	end
end
function SODecCigStress(player, chance, cigstress)
	local HundredChance = ZombRand(100);
	if HundredChance <= chance then
		local currentCigarettesStress = player:getStats():getStressFromCigarettes();
		player:getStats():setStressFromCigarettes(currentCigarettesStress - cigstress);
		if player:getStats():getStressFromCigarettes() < 0 then
			player:getStats():setStressFromCigarettes(0);
		end
	end
end

-- UNHAPPYNESS
function SOAddUnhappyness(player, chance, unhappyness)
	local HundredChance = ZombRand(100);
	if HundredChance <= chance then
		local currentUnhappyness = player:getBodyDamage():getUnhappynessLevel();
		player:getBodyDamage():setUnhappynessLevel(currentUnhappyness + unhappyness);
		if player:getBodyDamage():getUnhappynessLevel() > 99 then
			player:getBodyDamage():setUnhappynessLevel(99);
		end
	end
end
function SODecUnhappyness(player, chance, unhappyness)
	local HundredChance = ZombRand(100);
	if HundredChance <= chance then
		local currentUnhappyness = player:getBodyDamage():getUnhappynessLevel();
		player:getBodyDamage():setUnhappynessLevel(currentUnhappyness - unhappyness);
		if player:getBodyDamage():getUnhappynessLevel() < 0 then
			player:getBodyDamage():setUnhappynessLevel(0);
		end
	end
end

-- PANIC
function SOAddPanic(player, chance, panic)
	local HundredChance = ZombRand(100);
	if HundredChance <= chance then
		local currentPanic = player:getStats():getPanic();
		player:getStats():setPanic(currentPanic + panic);
		if player:getStats():getPanic() > 99 then
			player:getStats():setPanic(99);
		end
	end
end

-- FATIGUE
function SOAddFatigue(player, chance, fatigue)
	local HundredChance = ZombRand(100);
	local FitnessLvlValues = {
		[0] 	= 1.0,
		[1]		= 0.95,
		[2] 	= 0.92,
		[3] 	= 0.89,
		[4] 	= 0.87,
		[5] 	= 0.85,
		[6] 	= 0.83,
		[7] 	= 0.81,
		[8] 	= 0.79,
		[9] 	= 0.77,
		[10]	= 0.75
	}
	local x = FitnessLvl;
	local FitnessFatGainMult = FitnessLvlValues[x];	
	if HundredChance <= chance then
		local currentFatigue = player:getStats():getFatigue();
		local SleepyheadMult = 1
		local WakefulMult = 1		
		if player:HasTrait("NeedsMoreSleep") then			
			SleepyheadMult = 1.3
		end		
		if player:HasTrait("NeedsLessSleep") then			
			WakefulMult = 0.7
		end				
		player:getStats():setFatigue(currentFatigue + (((fatigue * FitnessFatGainMult) * (SleepyheadMult * WakefulMult))));		
		if player:getStats():getFatigue() > 0.999 then
			player:getStats():setFatigue(0.999);
		end
	end
end
function SODecFatigue(player, chance, fatigue)
	local HundredChance = ZombRand(100);
	local SleepyheadMult = 1
	local WakefulMult = 1	
	if HundredChance <= chance then
		local currentFatigue = player:getStats():getFatigue();
		if player:HasTrait("NeedsMoreSleep") then			
			SleepyheadMult = 0.7
		end		
		if player:HasTrait("NeedsLessSleep") then			
			WakefulMult = 1.3
		end		
		player:getStats():setFatigue(currentFatigue - ((fatigue * (SleepyheadMult * WakefulMult))));			
		if player:getStats():getFatigue() < 0 then
			player:getStats():setFatigue(0);
		end
	end
end

-- FOOD NAUSEA
function SOAddFoodSickness(player, chance, foodsickness)
	local HundredChance = ZombRand(100);
	if HundredChance <= chance then
	local currentFoodSickness = player:getBodyDamage():getFoodSicknessLevel();
		if player:HasTrait("WeakStomach") then
			player:getBodyDamage():setFoodSicknessLevel(currentFoodSickness + (foodsickness * 1.3));
		elseif player:HasTrait("IronGut") then
			player:getBodyDamage():setFoodSicknessLevel(currentFoodSickness + (foodsickness * 0.7));
		else
			player:getBodyDamage():setFoodSicknessLevel(currentFoodSickness + foodsickness);
		end
		if player:getBodyDamage():getFoodSicknessLevel() > 99 then
			player:getBodyDamage():setFoodSicknessLevel(99);
		end
	end
end

-- PAIN
function SOAddPain(player, chance, bodyPart, pain)
	local HundredChance = ZombRand(100);
	if HundredChance <= chance then
		local bodyPartAux = BodyPartType.FromString(bodyPart);
		local playerBodyPart = player:getBodyDamage():getBodyPart(bodyPartAux);
		local currentPain = playerBodyPart:getPain();
		playerBodyPart:setAdditionalPain(currentPain + pain);
		if playerBodyPart:getPain() > 99 then
			playerBodyPart:setAdditionalPain(99);
		end
	end
end

-- ENDURANCE
function SOAddEndurance(player, chance, endurance)
	local HundredChance = ZombRand(100);
	if HundredChance <= chance then
		local currentEndurance = player:getStats():getEndurance();
		player:getStats():setEndurance(currentEndurance + endurance);
		if player:getStats():getEndurance() > 0.999 then
			player:getStats():setEndurance(0.999);
		end
--	print("Restored");			
	end
end

function SODecEndurance(player, chance, endurance)
	local HundredChance = ZombRand(100);
	local FitnessLvlValues = {
		[0] 	= 0.9,
		[1]		= 0.8,
		[2] 	= 0.75,
		[3] 	= 0.7,
		[4] 	= 0.65,
		[5] 	= 0.60,
		[6] 	= 0.57,
		[7] 	= 0.53,
		[8] 	= 0.49,
		[9] 	= 0.46,
		[10]	= 0.43
	}
	local x = FitnessLvl;
	local FitnessEndLossMult = FitnessLvlValues[x];
	if HundredChance <= chance then
		local currentEndurance = player:getStats():getEndurance();
		player:getStats():setEndurance(currentEndurance - (endurance * FitnessEndLossMult));
		if player:getStats():getEndurance() < 0 then
			player:getStats():setEndurance(0);
		end
	end
end

--------------------------------

-- STRONG BACK AND WEAK BACK TRAIT - MAIN
function SOcheckWeight()
	local player = getPlayer();
	if getActivatedMods():contains("AliceSPack") == true then
		if player:HasTrait("Metalstrongback") and player:HasTrait("StrongBack") then
		player:setMaxWeightBase(13);	
		elseif player:HasTrait("Metalstrongback2") and player:HasTrait("StrongBack") then
		player:setMaxWeightBase(13);
		elseif player:HasTrait("Strongback") and player:HasTrait("StrongBack") then
		player:setMaxWeightBase(10);
		elseif player:HasTrait("Strongback2") and player:HasTrait("StrongBack") then
		player:setMaxWeightBase(10);
		elseif player:HasTrait("Metalstrongback") then
		player:setMaxWeightBase(12);		
		elseif player:HasTrait("Metalstrongback2") then
		player:setMaxWeightBase(12);
		elseif player:HasTrait("StrongBack") then
		player:setMaxWeightBase(10);
		elseif player:HasTrait("Strongback2") then
		player:setMaxWeightBase(10);		
		elseif player:HasTrait("WeakBack") then
		player:setMaxWeightBase(7);
		else
		player:setMaxWeightBase(8);
		end
	end	
	if getActivatedMods():contains("AliceSPack") == false then		
		if player:HasTrait("StrongBack") then
		player:setMaxWeightBase(9);
		elseif player:HasTrait("WeakBack") then
		player:setMaxWeightBase(7);
		else
		player:setMaxWeightBase(8);
		end
	end
	
--[[	if getActivatedMods():contains("AliceSPack") == false then		
		if player:HasTrait("StrongBack") then
		player:setMaxWeightDelta(1.15);
		player:setMaxWeightBase(8);
		elseif player:HasTrait("WeakBack") then
		player:setMaxWeightDelta(0.86);		
		player:setMaxWeightBase(8);
		else
		player:setMaxWeightDelta(1);		
		player:setMaxWeightBase(8);
		end
	end	]]
	
end

-- LARK TRAIT - MAIN
function larkpersontrait()
	local player = getPlayer();	
	local gameTime = getGameTime();
	local currentHour = gameTime:getHour();
 	if player:HasTrait("LarkPerson") and not player:isAsleep() then
		if currentHour >= 5 and currentHour <= 9 then	
			SODecFatigue(player, 50, 0.0065)
		end
		if currentHour >= 17 and currentHour <= 21 then
			SOAddFatigue(player, 50, 0.0065)	
		end
	end
end

-- OWL TRAIT - MAIN
function owlpersontrait()
	local player = getPlayer();	
	local gameTime = getGameTime();
	local currentHour = gameTime:getHour();
 	if player:HasTrait("OwlPerson") and not player:isAsleep() then
		if currentHour >= 17 and currentHour <= 21 then	
			SODecFatigue(player, 50, 0.0065)
		end
		if currentHour >= 5 and currentHour <= 9 then
			SOAddFatigue(player, 50, 0.0065)
		end
	end
end

-- MUSCLE STRAIN TRAITS
function musclestraintraits()
    local player = getPlayer()
    local bodyDamage = player:getBodyDamage()

    local MSArmsParts = {
        "Hand_R", "ForeArm_R", "UpperArm_R",
        "Hand_L", "ForeArm_L", "UpperArm_L"
    }
    local MSTorsoParts = {
        "Torso_Upper", "Torso_Lower"
    }

    if player:HasTrait("Tireless") or player:HasTrait("MinersEndurance") then
        for _, partName in ipairs(MSArmsParts) do
            local bodyPart = bodyDamage:getBodyPart(BodyPartType.FromString(partName))
            if bodyPart then
                local stiffness = bodyPart:getStiffness()
                if stiffness > 0 then
                    local newStiffness = math.max(0, stiffness - 0.084) -- stiffness reduction amount around 35% reduction of original value
                    if newStiffness ~= stiffness then
                        bodyPart:setStiffness(newStiffness)
                        -- print(string.format("Reduced stiffness for %s: %.2f -> %.2f", partName, stiffness, newStiffness))
                    end
                end
            end
        end
    end

    if player:HasTrait("StrongBack") then
        for _, partName in ipairs(MSTorsoParts) do
            local bodyPart = bodyDamage:getBodyPart(BodyPartType.FromString(partName))
            if bodyPart then
                local stiffness = bodyPart:getStiffness()
                if stiffness > 0 then
                    local newStiffness = math.max(0, stiffness - 0.084) -- stiffness reduction amount around 35% reduction of original value
                    if newStiffness ~= stiffness then
                        bodyPart:setStiffness(newStiffness)
                        -- print(string.format("Reduced stiffness for %s: %.2f -> %.2f", partName, stiffness, newStiffness))
                    end
                end
            end
        end
    end
end

-- TIRELESS TRAIT - MAIN
function tirelesstrait(player, weapon)
	local player = getPlayer();
	local currentFatigue
	local FatigueMult
	local EndRecoverChance

	if player:HasTrait("Tireless") or player:HasTrait("MinersEndurance") then
		-- return if Bare Hands
		if weapon:getType() == "BareHands" then
			return
		end
		-- get item stats
		local WeaponInPrimaryHand = player:getPrimaryHandItem();
		local WeaponInSecondaryHand = player:getSecondaryHandItem();	
		-- if no mainhand weapon then return
		if WeaponInPrimaryHand == nil then
			return
		end
		
		local WeaponEndMod = WeaponInPrimaryHand:getEnduranceMod();
		local WeaponWeight = WeaponInPrimaryHand:getWeight();

		currentFatigue = player:getStats():getFatigue();
		FatigueMult = 1.0 - currentFatigue
		FatigueMult = round(FatigueMult,2)

		if player:HasTrait("Tireless") then EndRecoverChance = 20 end -- 20% if Tireless
		if player:HasTrait("MinersEndurance") then EndRecoverChance = 30 end -- 30% if MinersEndurance
		
		-- Endurance formula	
		local RWeaponEndCost = (((WeaponWeight * 0.003) * WeaponEndMod)) * FatigueMult;	
		local RWeaponEndCost = round(RWeaponEndCost,6)
		-- Restoring 50% of RWeaponEndCost while swing with 25% chance
		SOAddEndurance(player, EndRecoverChance, (RWeaponEndCost * 0.5));
		
		-- print("Tireless: " .. EndRecoverChance)		
		-- print("Tireless: " .. (RWeaponEndCost * 0.5))
		-- print("FatigueMult: " .. FatigueMult)	
		end
end

-- MARATHON RUNNER TRAIT - MAIN
function marathonrunnertrait ()
	local player = getPlayer();
	if player == nil then
		return
	end	
	local currentFatigue
	local FatigueMult
	local OverweightMult
	local ObeseMult	
	local AthleticPenalty	
	if player:HasTrait("MarathonRunner") then 
		-- local EndRegenChance = 100;	
		local FitnessMult = 0.7 + (FitnessLvl * 0.1)

		if player:HasTrait("Overweight") then			
			OverweightMult = 0.7
			else OverweightMult = 1
		end				
		if player:HasTrait("Obese") then			
			ObeseMult = 0.4
			else ObeseMult = 1	
		end
		if FitnessLvl >= 9 then
			AthleticPenalty = 0.4
			else AthleticPenalty = 1
		end	

		currentFatigue = player:getStats():getFatigue();
		FatigueMult = 1.0 - currentFatigue
		FatigueMult = round(FatigueMult,2)
		local MRRunER = (((0.00065 * FitnessMult) * AthleticPenalty) * (OverweightMult * ObeseMult)) * FatigueMult;
		local MRRunER = round(MRRunER,6)	
		-- Running and Sprinting
		if player:IsRunning() == true or player:isSprinting() == true then
			if player:isPlayerMoving() and player:isSneaking() == false then
				SOAddEndurance(player, 100, MRRunER);
				-- print("MR Endurance: " .. MRRunER)		
			end
		end
	end
end

-- BETWEEN THE SHADOWS - MAIN
function ninjawaytrait ()
	local player = getPlayer();
	if player == nil then
		return
	end	
	local currentFatigue
	local currentEndurance	
	local FatigueMult
	local OverweightMult
	local ObeseMult	
	local AthleticPenalty	
	local FitnessLvlValues = {
		[0] 	= 0.7,
		[1]		= 0.8,
		[2] 	= 0.9,
		[3] 	= 1.0,
		[4] 	= 1.1,
		[5] 	= 1.2,
		[6] 	= 1.3,
		[7] 	= 1.4,
		[8] 	= 1.5,
		[9] 	= 1.55,
		[10]	= 1.6
	}
	local x = FitnessLvl;
	local FitnessMult = FitnessLvlValues[x];		
	if player:HasTrait("NinjaWay") and not player:isAsleep() then 	
		if player:HasTrait("Overweight") then			
			OverweightMult = 0.7
				else OverweightMult = 1
		end				
		if player:HasTrait("Obese") then			
			ObeseMult = 0.4
				else ObeseMult = 1	
		end	
		if FitnessLvl >= 9 then
			AthleticPenalty = 0.4
				else AthleticPenalty = 1
		end		
		currentEndurance = player:getStats():getEndurance();
		currentFatigue = player:getStats():getFatigue();
		FatigueMult = 1.0 - currentFatigue
		FatigueMult = round(FatigueMult,2)
		local BtSEnduranceRUN = (((0.00065 * FitnessMult) * AthleticPenalty)* (OverweightMult * ObeseMult)) * FatigueMult;	
		local BtSEnduranceRUN = round(BtSEnduranceRUN,6)	
		local BtSEnduranceRegen = ((0.00065 * FitnessMult) * (OverweightMult * ObeseMult)) * FatigueMult;
		local BtSEnduranceRegen = round(BtSEnduranceRegen,6)	
		if player:isSneaking() == true then
			-- Sneaking NOT MOVING
			if not player:isPlayerMoving() and currentEndurance <= 0.99 then
				if not player:getCurrentState() == PlayerAimState.instance() or player:isSitOnGround() == false then	
					SOAddEndurance(player, 100, (BtSEnduranceRegen * 2));
					-- print("BtS stand: " .. (BtSEnduranceRegen * 2))		
				end
			end	
			-- Sneaking WALK
			if player:isPlayerMoving() and player:IsRunning() == false then
				if player:isAiming() == false then
					SOAddEndurance(player, 100, BtSEnduranceRegen);
					-- print("BtS Walk: " .. BtSEnduranceRegen)		
				end
			end	
			-- Sneaking RUN			
			if player:isPlayerMoving() and player:IsRunning() == true then
				SOAddEndurance(player, 100, (BtSEnduranceRUN * 2));
				-- print("BtS Run: " .. (BtSEnduranceRUN * 2))		
			end	
		end
	end
end

-- BREATHING TECHNIQUE TRAIT - MAIN
function breathingtechtrait()
	local player = getPlayer();
	if player == nil then
		return
	end	
	local currentEndurance
	local currentFatigue
	local FatigueMult
	local OverweightMult
	local ObeseMult	
	local FitnessLvlValues = {
		[0] 	= 0.7,
		[1]		= 0.8,
		[2] 	= 0.9,
		[3] 	= 1.0,
		[4] 	= 1.1,
		[5] 	= 1.2,
		[6] 	= 1.3,
		[7] 	= 1.4,
		[8] 	= 1.5,
		[9] 	= 1.55,
		[10]	= 1.6
	}
	local x = FitnessLvl;
	local FitnessMult = FitnessLvlValues[x];	
	if player:HasTrait("BreathingTech") then
		if player:HasTrait("Overweight") then			
			OverweightMult = 0.7
				else OverweightMult = 1
		end				
		if player:HasTrait("Obese") then			
			ObeseMult = 0.4
				else ObeseMult = 1	
		end		
		currentEndurance = player:getStats():getEndurance();
		currentFatigue = player:getStats():getFatigue();
		FatigueMult = 1.0 - currentFatigue
		FatigueMult = round(FatigueMult,2)
		local BTEndRestoringAmount = ((0.0025 * FitnessMult) * (OverweightMult * ObeseMult)) * FatigueMult;
		local BTEndRestoringAmount = round(BTEndRestoringAmount,6)
		if not player:isAsleep() and currentEndurance <= 0.999 then
			-- if not moving stand
			if not player:isPlayerMoving() and player:isAiming() == false and player:isSitOnGround() == false and player:getVehicle() == nil then
				SOAddEndurance(player, 100, BTEndRestoringAmount);
--				print("BThq stand: " .. BTEndRestoringAmount)				
			end
			-- if not moving sitting
			if (not player:isPlayerMoving() and (player:isSitOnGround() == true or player:isSittingOnFurniture())) or player:getVehicle() ~= nil then	
				SOAddEndurance(player, 100, (BTEndRestoringAmount * 3));
--				print("BThq sitting: " .. (BTEndRestoringAmount * 3))			
			end			
		end
	end
end

-- SORE LEGS - MAIN
function sorelegstrait()
	local player = getPlayer();
	if player == nil then
		return
	end	
	if player:HasTrait("SoreLegs") then
		local Foot_L = player:getBodyDamage():getBodyPart(BodyPartType.FromString("Foot_L"));
		local Foot_R = player:getBodyDamage():getBodyPart(BodyPartType.FromString("Foot_R"));	
		local WalkPain = 2 - (LightfootedLvl * 0.1);
		local RunPain = 5 - (SprintingLvl * 0.3);
		local SprintPain = 20 - SprintingLvl;
		local EnduranceLoss = 0.03 - (SprintingLvl * 0.002);
		-- Walking pain
		if player:isPlayerMoving() and not player:IsRunning() == true and not player:isSprinting() == true then	
			if Foot_L:getPain() <= 17 then
			SOAddPain(player, 100, "Foot_L", WalkPain);	
			end
			if Foot_R:getPain() <= 17 then
			SOAddPain(player, 100, "Foot_R", WalkPain);
			end
		end
		-- Running pain
		if player:IsRunning() == true and player:isPlayerMoving() then
			SOAddPain(player, 10, "UpperLeg_L", RunPain);	
			SOAddPain(player, 10, "UpperLeg_R", RunPain);	
			SOAddPain(player, 20, "LowerLeg_L", RunPain);	
			SOAddPain(player, 20, "LowerLeg_R", RunPain);
			if Foot_L:getPain() <= 35 then
			SOAddPain(player, 30, "Foot_L", RunPain);
			end
			if Foot_R:getPain() <= 35 then	
			SOAddPain(player, 30, "Foot_R", RunPain);
		end
		-- Sprinting pain
		end
		if player:isSprinting() == true and player:isPlayerMoving() then
			SOAddPain(player, 10, "UpperLeg_L", SprintPain);	
			SOAddPain(player, 10, "UpperLeg_R", SprintPain);	
			SOAddPain(player, 20, "LowerLeg_L", SprintPain);	
			SOAddPain(player, 20, "LowerLeg_R", SprintPain);
			SOAddPain(player, 30, "Foot_L", SprintPain);	
			SOAddPain(player, 30, "Foot_R", SprintPain);
			SODecEndurance(player, 100, EnduranceLoss);	
		end
	end
end
-- SORE LEGS TRAIT - STOMP PAIN
function sorellegsstomppain(player, weapon)
	local player = getPlayer();	
	if player:HasTrait("SoreLegs")then
		-- LightfootedLvl = player:getPerkLevel(Perks.Lightfoot);		
		local Foot_R = player:getBodyDamage():getBodyPart(BodyPartType.FromString("Foot_R"));	
		if weapon:getCategories():contains("Unarmed") and player:isAimAtFloor() and Foot_R:getPain() <= 50 then
			local LightfootedStompPain = 6 - (LightfootedLvl * 0.3);	
			SOAddPain(player, 100, "Foot_R", LightfootedStompPain);
		end
	end
end

-- LIQUID BLOOD TRAIT - MAIN
function liquidbloodtrait()
	local player = getPlayer();
	if player:HasTrait("LiquidBlood") then 
		local gamespeed = UIManager.getSpeedControls():getCurrentGameSpeed();
		local gsmultiplier = 1;
		if gamespeed == 1 then gsmultiplier = 1;
			elseif gamespeed == 2 then gsmultiplier = 5;
			elseif gamespeed == 3 then gsmultiplier = 20;
			elseif gamespeed == 4 then gsmultiplier = 40;
		end
		local bodydamage = player:getBodyDamage();
		local bleeding = bodydamage:getNumPartsBleeding();
		if bleeding > 0 then
			for i = 0, player:getBodyDamage():getBodyParts():size() - 1 do
				local b = player:getBodyDamage():getBodyParts():get(i);
				if b:bleeding() and b:IsBleedingStemmed() == false then
					local damage = 0.0057;
					if b:getType() == BodyPartType.Neck then
						damage = damage * 5;
					end
					b:ReduceHealth(damage * gsmultiplier);
				end
			end
		end
	end
end

-- THICK BLOOD TRAIT - MAIN
function thickbloodtrait()
	local player = getPlayer();
	if player:HasTrait("ThickBlood") then
		local gamespeed = UIManager.getSpeedControls():getCurrentGameSpeed();
		local gsmultiplier = 1;
		if gamespeed == 1 then gsmultiplier = 1;
			elseif gamespeed == 2 then gsmultiplier = 5;
			elseif gamespeed == 3 then gsmultiplier = 20;
			elseif gamespeed == 4 then gsmultiplier = 40;
		end
			local bodydamage = player:getBodyDamage();
			local bleeding = bodydamage:getNumPartsBleeding(); 
				if bleeding > 0 then
				for i = 0, player:getBodyDamage():getBodyParts():size() - 1 do
				local b = player:getBodyDamage():getBodyParts():get(i);
					if b:bleeding() and b:IsBleedingStemmed() == false then
					local damage = 0.00228;
					if b:getType() == BodyPartType.Neck then
						damage = damage * 4;
					end
					b:AddHealth(damage * gsmultiplier);
				end
			end
		end
	end
end

-- ALCOHOLIC TRAIT - NEGATIVE EFFECTS
function SOalcoholictrait()
	local player = getPlayer();
	if player:getModData().SOtenminutesSinceLastDrink == nil then
		player:getModData().SOtenminutesSinceLastDrink = 0;
	end	
	if player:getModData().SOtenminutesToObtainAlcoholic == nil then
		player:getModData().SOtenminutesToObtainAlcoholic = 0;
	end		
	-- Abstinence
	if player:HasTrait("SOAlcoholic") then
		-- one hour = 6	
		local hourstosuffeifnotdrinksafe = 144; -- 24 hours
		local hourstosuffeifnotdrinkhalf = 288; -- 48 hours		
		local hourstosuffeifnotdrinkfull = 576; -- 96 hours
		if player:getModData().SOtenminutesSinceLastDrink >= hourstosuffeifnotdrinksafe then
			if not player:isAsleep() then -- and player:getStats():getStress() <= 0.55 
				-- SOAddStress(player, 100, 0.005);
				SOAddBoredom(player, 100, 0.5);
			end
		end
		if player:getModData().SOtenminutesSinceLastDrink >= hourstosuffeifnotdrinkhalf then
			if not player:isAsleep() then
				SOAddThirst(player, 33, 0.0001);
				SOAddBoredom(player, 100, 0.5);
				SOAddUnhappyness(player, 100, 0.25);
			end
		end		
		if player:getModData().SOtenminutesSinceLastDrink >= hourstosuffeifnotdrinkfull then
			if not player:isAsleep() then
				SOAddThirst(player, 33, 0.0001);		
				SOAddFatigue(player, 33, 0.0001);
				SOAddStress(player, 100, 0.0035);
				SOAddBoredom(player, 100, 0.5);
			end
			SOAddPain(player, 10, "Head", (ZombRand(5)+2));			
			if player:getBodyDamage():getFoodSicknessLevel() <= 40 then
				SOAddFoodSickness(player, 10, (ZombRand(5)));
			end
		end
	end
end

-- CHRONIC MIGRAINE TRAIT - MAIN
function chronicmigrainetrait()
	local player = getPlayer()
	local head = player:getBodyDamage():getBodyPart(BodyPartType.FromString("Head"))
	local painEffect = player:getPainEffect()
	local foodSicknessLevel = player:getBodyDamage():getFoodSicknessLevel()
	local currentHeadPain = head:getPain()

	if player:getModData().migraineCooldown == nil then
		player:getModData().migraineCooldown = 0
	end
	if player:getModData().migraineDuration == nil then
		player:getModData().migraineDuration = 0
	end

	if player:HasTrait("ChronicMigraine") then

		if player:getModData().migraineCooldown > 0 then
			player:getModData().migraineCooldown = player:getModData().migraineCooldown - 1
		end
		if player:getModData().migraineDuration > 0 then
			player:getModData().migraineDuration = player:getModData().migraineDuration - 1
		end

		-- Debug values
		-- local durationInHours = math.floor(player:getModData().migraineDuration / 6)
		-- local cooldownInHours = math.floor(player:getModData().migraineCooldown / 6)

		-- Migraine is active
		if player:getModData().migraineDuration > 0 then
			-- print("Migraine active. Time remaining: " .. durationInHours)
			if painEffect <= 0 then
				local migrainePain = ZombRand(5, 10)	
				local migraunePainChance = 100
				if currentHeadPain <= 70 and currentHeadPain >= 40 then migraunePainChance = 70 
				elseif currentHeadPain >= 71 then migraunePainChance = 20 end
				-- print("migraunePainChance: " .. migraunePainChance)
				-- print("migrainePain: " .. migrainePain)
				SOAddPain(player, migraunePainChance, "Head", migrainePain)
			end
			elseif player:getModData().migraineCooldown > 0 then
			-- print("Cooldown until next migraine: " .. cooldownInHours)
		end
		-- Migraine not active and cooldown is complete
		if player:getModData().migraineDuration <= 0 and player:getModData().migraineCooldown <= 0 then
			player:getModData().migraineDuration = ZombRand(24, 288) -- 4-48 hours
			player:getModData().migraineCooldown = ZombRand(144, 432) -- 24-72 hours
			-- print("Migraine started. Duration: " .. durationInHours)
		end
	end
end

-- ALCOHOLIC TRAIT - REMOVE ADD
function SOalcoholictrait2()

	local player = getPlayer();
	
	if player:getModData().SOtenminutesSinceLastDrink == nil then
		player:getModData().SOtenminutesSinceLastDrink = 0;
	end	
	if player:getModData().SOtenminutesToObtainAlcoholic == nil then
		player:getModData().SOtenminutesToObtainAlcoholic = 0;
	end		
	-- increasing SOtenminutesSinceLastDrink amount if alcoholic
	if player:HasTrait("SOAlcoholic") then
		player:getModData().SOtenminutesSinceLastDrink = player:getModData().SOtenminutesSinceLastDrink + 1;
	end
	-- reducing SOtenminutesToObtainAlcoholic amount if not alcoholic
	if not player:HasTrait("SOAlcoholic") then
		player:getModData().SOtenminutesToObtainAlcoholic = player:getModData().SOtenminutesToObtainAlcoholic - 1;
	end	
	-- Lose Alcoholic trait
	if player:HasTrait("SOAlcoholic") then
		-- Получаем значение из настроек в часах
		local AlcoholicHoursToRemoveMin = SOTOSbvars.AlcoholicHoursToRemoveMin -- Например, 1032 (43 дня)
		local AlcoholicHoursToRemoveMax = SOTOSbvars.AlcoholicHoursToRemoveMax -- Например, 1128 (47 дней)

		-- Конвертируем часы в 10-минутные интервалы
		local AlcoholicTenMinutesToRemoveMin = AlcoholicHoursToRemoveMin * 6
		local AlcoholicTenMinutesToRemoveMax = AlcoholicHoursToRemoveMax * 6
		local AlcoholicTenMinutesToRemoveDiff = AlcoholicTenMinutesToRemoveMax - AlcoholicTenMinutesToRemoveMin
		local AlcoholicTenMinutesToRemove = AlcoholicTenMinutesToRemoveMin + ZombRand(AlcoholicTenMinutesToRemoveDiff)

		if player:getModData().SOtenminutesSinceLastDrink >= AlcoholicTenMinutesToRemove then
			if SOTOSbvars.AlcoholicRemovable == true then
				getSoundManager():PlaySound("GainExperienceLevel", false, 0):setVolume(0.50)
				player:getTraits():remove("SOAlcoholic")
				HaloTextHelper.addTextWithArrow(player, getText("UI_trait_soalcoholic"), false, HaloTextHelper.getColorGreen())
				player:getModData().SOtenminutesToObtainAlcoholic = 0
				player:getModData().SOtenminutesSinceLastDrink = 0
			end
		end
	end
	-- Gain Alcoholic trait	
	if not player:HasTrait("SOAlcoholic") then
	
		local AlcoholicValueToEarnMin = SOTOSbvars.AlcoholicValueToEarnMin; -- 6192
		local AlcoholicValueToEarnMax = SOTOSbvars.AlcoholicValueToEarnMax; -- 6768
		local AlcoholicValueToEarnDiff = AlcoholicValueToEarnMax - AlcoholicValueToEarnMin;
		local AlcoholicValueToEarn = AlcoholicValueToEarnMin + ZombRand(AlcoholicValueToEarnDiff); -- around 30 bottles in week
		if player:getModData().SOtenminutesToObtainAlcoholic >= AlcoholicValueToEarn then
			if SOTOSbvars.AlcoholicEarnable == true then		
				player:getTraits():add("SOAlcoholic");
				player:getModData().SOtenminutesToObtainAlcoholic = 0;
				player:getModData().SOtenminutesSinceLastDrink = 0;			
				HaloTextHelper.addTextWithArrow(player, getText("UI_trait_soalcoholic"), true, HaloTextHelper.getColorRed());
			end
		end
	end
	-- mod data limits
	if player:getModData().SOtenminutesSinceLastDrink > 6768 then
		player:getModData().SOtenminutesSinceLastDrink = 6768;
		elseif player:getModData().SOtenminutesSinceLastDrink < 0 then
			player:getModData().SOtenminutesSinceLastDrink = 0;
	end		
	if player:getModData().SOtenminutesToObtainAlcoholic > 6048 then
		player:getModData().SOtenminutesToObtainAlcoholic = 6048;
		elseif player:getModData().SOtenminutesToObtainAlcoholic < 0 then
		player:getModData().SOtenminutesToObtainAlcoholic = 0;
	end	
	-- Debug	
	-- print("player:getModData().SOtenminutesSinceLastDrink: " .. player:getModData().SOtenminutesSinceLastDrink);	
	-- print("player:getModData().SOtenminutesToObtainAlcoholic: " .. player:getModData().SOtenminutesToObtainAlcoholic);
end

function alcoholbottlesdrinked()
	local player = getPlayer();
	if player:getModData().SOAlcoholBottlesDrinked == nil then
		player:getModData().SOAlcoholBottlesDrinked = 0; 
	end	
	player:getModData().SOAlcoholBottlesDrinked = player:getModData().SOAlcoholBottlesDrinked - 1

	if player:getModData().SOAlcoholBottlesDrinked <= 0 then
		player:getModData().SOAlcoholBottlesDrinked = 0
	end
	
	if player:getSleepingTabletEffect() <= 0 then
		player:setSleepingTabletEffect(0)
	end
	-- print("alcoholbottlesscale: " .. player:getModData().SOAlcoholBottlesDrinked);	
end

-- ALCOHOLIC - ANIMATION
function SOalcoholicAnimshaking(player)
	local player = getPlayer();
	if player:HasTrait("SOAlcoholic") and player:getModData().SOtenminutesSinceLastDrink >= 576 and not player:isAsleep() then
		if ZombRand(10) == 0 and player:isSneaking() == false then
		player:setVariable("Ext", "Sway")
		player:reportEvent("EventDoExt")
		end
	end	
end

-- SENSITIVE DIGESTION TRAIT - MAIN
function sensitivedigestiontrait()
	local player = getPlayer();
	if player:HasTrait("SensitiveDigestion") then
		local FoodEatenLevel = player:getMoodles():getMoodleLevel(MoodleType.FoodEaten)
		local currentFoodSickness = player:getBodyDamage():getFoodSicknessLevel();
		local SickProtection = 1
		if currentFoodSickness >= 80 then SickProtection = 0.5 end
		--	print("SickProtection: " .. SickProtection);	
		if FoodEatenLevel == 1 then
			SOAddPain(player, 100, "Torso_Lower", 0.9);
			SOAddFoodSickness(player, 100, 0.33 * SickProtection);
			-- print("Sickness 1");				
			elseif FoodEatenLevel == 2 then
				SOAddPain(player, 100, "Torso_Lower", 1.0);
				SOAddFoodSickness(player, 100, 0.44 * SickProtection);
				-- print("Sickness 2");				
				elseif FoodEatenLevel == 3 then
					SOAddPain(player, 100, "Torso_Lower", 1.1);
					SOAddFoodSickness(player, 100, 0.55 * SickProtection);
					-- print("Sickness 3");					
					elseif FoodEatenLevel == 4 then
						SOAddPain(player, 100, "Torso_Lower", 1.2);
						SOAddFoodSickness(player, 100, 0.66 * SickProtection);
						-- print("Sickness 4");
		end
	end
end

-- PANIC ATTACKS TRAIT - MAIN
function panicattackstrait ()
	local player = getPlayer();
	local playersurvivedhours = player:getHoursSurvived();	
	local stats = player:getStats();
	local panic = stats:getPanic();
	local speedcontrolforpa = UIManager.getSpeedControls();
	local gamespeedforpa = speedcontrolforpa:getCurrentGameSpeed();	
	local betaEffect = player:getBetaEffect()
	
	if player:HasTrait("PanicAttacks") and betaEffect <= 0 then

		PAchancecalc = 864 + (playersurvivedhours * 0.4);
		PAchance = ZombRand(PAchancecalc);

		if PAchance == 0 then
		-- Panic attack while sleeping	
		if player:isAsleep() then
			forceAwakechance = ZombRand(10);
			if forceAwakechance == 0 then
				player:forceAwake();
				getSoundManager():PlaySound("ZombieSurprisedPlayer", false, 0):setVolume(0.50);			
				-- player:playEmote("soshiver");
				player:setVariable("Ext", "Shiver")
				player:reportEvent("EventDoExt")				
				SOAddPanic(player, 100, (ZombRand(21)+80));
				SOAddStress(player, 100, 0.60);
				SOAddWetness(player, 100, (ZombRand(31)+20));
			end
		end
		-- Panic attack not sleeping	
		if not player:isAsleep() then		
			if gamespeedforpa <= 3 then
				getSoundManager():PlaySound("ZombieSurprisedPlayer", false, 0):setVolume(0.25);			
			end
			-- player:playEmote("soshiver");
			player:setVariable("Ext", "Shiver")
			player:reportEvent("EventDoExt")				
			SOAddPanic(player, 100, (ZombRand(31)+70));
			SOAddStress(player, 100, 0.30);
			-- SOAddWetness(player, 100, (ZombRand(31)+10));
			end
		end
		--	Panic increase		
		if panic >= 10 and panic <= 49 then
			SOAddPanic (player, 100, (ZombRand(3)+1));	
		end
		if panic >= 50 and panic <= 79 then
			SOAddPanic (player, 66, (ZombRand(5)+1));	
		end	
		if panic >= 80 then
			SOAddPanic (player, 33, (ZombRand(10)+1));	
		end	
		-- print("PAchancecalc: " .. PAchancecalc);			
		-- print("PAchance: " .. PAchance);	
	end		
end

-- ALLERGIC TRAIT - MAIN
function allergictrait ()
	local player = getPlayer();
	if player:HasTrait("Allergic") and not player:isAsleep() then
	local itemmh = player:getPrimaryHandItem()
	local itemsh = player:getSecondaryHandItem()
		if player:HasTrait("ProneToIllness") then
		AllergicSneezeChance = 230
			else AllergicSneezeChance = 288
		end
		-- print("AllergicSneezeChance: " .. AllergicSneezeChance);		
		if ZombRand(AllergicSneezeChance) == 0 then
			-- Sneezing
			if not player:hasEquipped("Base.ToiletPaper") and not player:hasEquipped("Base.Tissue") then
			player:Say(getText("IGUI_PlayerText_Sneeze"));	
			if not player:isOutside() then	
			addSound(player, player:getX(), player:getY(), player:getZ(), 24, 50); -- range, then volume
				else 
				addSound(player, player:getX(), player:getY(), player:getZ(), 48, 100); -- range, then volume
			end
--			player:playEmote("sosneeze");
			player:setVariable("Ext", "Sneeze2")
			player:reportEvent("EventDoExt")			
			player:playerVoiceSound("SneezeHeavy")
			end
			-- Sneezing Toilet Paper			
			if player:hasEquipped("Base.ToiletPaper") or player:hasEquipped("Base.Tissue") then
				if ZombRand(2) == 0 then			
					if itemmh and itemmh:getType() == "ToiletPaper" then
					itemmh:Use()
						elseif itemsh and itemsh:getType() == "ToiletPaper" then
						itemsh:Use()
							elseif itemmh and itemmh:getType() == "Tissue" then
							itemmh:Use()
								elseif itemsh and itemsh:getType() == "Tissue" then
								itemsh:Use()						
					end
				end
			player:Say(getText("IGUI_PlayerText_SneezeMuffled"));
			addSound(player, player:getX(), player:getY(), player:getZ(), 3, 10); -- range, then volume
			player:setVariable("Ext", "Sneeze2")
			player:reportEvent("EventDoExt")	
			player:playerVoiceSound("SneezeLight")			
			end
		end
	end
end

-- SNORER TRAIT - MAIN
function snorertrait ()
	local player = getPlayer();
	if player:HasTrait("Snorer") and player:isAsleep() then
		if ZombRand(30) == 0 then
			if not player:isOutside() then	
			addSound(player, player:getX(), player:getY(), player:getZ(), 10, 50); -- range, then volume
				else 
				addSound(player, player:getX(), player:getY(), player:getZ(), 20, 50); -- range, then volume
			end	
		end
		if ZombRand(300) == 0 then
			if not player:isOutside() then	
			addSound(player, player:getX(), player:getY(), player:getZ(), 15, 80); -- range, then volume
				else 
				addSound(player, player:getX(), player:getY(), player:getZ(), 30, 80); -- range, then volume
			end	
		end		
	end
end

-- SMOKER TRAIT - MAIN
function smokertraitmain ()
	local player = getPlayer();
	local EnduranceMoodleLevel = player:getMoodles():getMoodleLevel(MoodleType.Endurance);
	if player:HasTrait("Smoker") and not player:isAsleep() then	
		if EnduranceMoodleLevel >= 1 then
			local AsthmaticMult	= 1
			local EndSmokeScale = 1
			local EndSmokeCoughRange = 20
			if player:HasTrait("Asthmatic") then AsthmaticMult = 0.7 end	
			if EnduranceMoodleLevel == 1 then
				EndSmokeCoughChance = 1;
				EndSmokeCoughRange = 20;	
				elseif EnduranceMoodleLevel == 2 then
				EndSmokeCoughChance = 0.8;
				EndSmokeCoughRange = 22;	
				elseif EnduranceMoodleLevel == 3 then
				EndSmokeCoughChance = 0.6;
				EndSmokeCoughRange = 24;					
				elseif EnduranceMoodleLevel == 4 then
				EndSmokeCoughChance = 0.4; 
				EndSmokeCoughRange = 26;
			end			
				
			local SmokerCoughChance = (50 * AsthmaticMult * EndSmokeScale) -- 2.0% per min
			if ZombRand(SmokerCoughChance) == 0 then
				-- Coughing
				if not player:hasEquipped("Base.ToiletPaper") and not player:hasEquipped("Base.Tissue") then
				player:Say(getText("IGUI_PlayerText_Cough"));	
				if not player:isOutside() then	
				addSound(player, player:getX(), player:getY(), player:getZ(), (EndSmokeCoughRange * 0.5), 50); -- range, then volume
					else 
					addSound(player, player:getX(), player:getY(), player:getZ(), EndSmokeCoughRange, 100); -- range, then volume
				end
				player:setVariable("Ext", "Cough")
				player:reportEvent("EventDoExt")	
				player:playerVoiceSound("Cough")					
				end
				-- Coughing Muffled		
				if player:hasEquipped("Base.ToiletPaper") or player:hasEquipped("Base.Tissue") then
					if ZombRand(2) == 0 then			
						if itemmh and itemmh:getType() == "ToiletPaper" then
						itemmh:Use()
							elseif itemsh and itemsh:getType() == "ToiletPaper" then
							itemsh:Use()
								elseif itemmh and itemmh:getType() == "Tissue" then
								itemmh:Use()
									elseif itemsh and itemsh:getType() == "Tissue" then
									itemsh:Use()						
						end
					end
					player:Say(getText("IGUI_PlayerText_CoughMuffled"));
					addSound(player, player:getX(), player:getY(), player:getZ(), (EndSmokeCoughRange * 0.1), 10); -- range, then volume
					player:setVariable("Ext", "Cough")
					player:reportEvent("EventDoExt")	
					player:playerVoiceSound("Cough")					
				end
			end	
		end
				
		-- ENDURANCE LOSS IF RUNNING	
		if player:isPlayerMoving() and player:IsRunning() == true then
			-- player:Say("smoke run");
			SODecEndurance(player, 50, 0.0005);
		end
	end
end

function smokeroftenandhunger()
	local player = getPlayer();
	if player:HasTrait("Smoker") and not player:isAsleep() then	
		local TimeSinceLastSmoke = player:getTimeSinceLastSmoke();	
		-- Smoke more often
		if ZombRand(24) == 0 and TimeSinceLastSmoke <= 9 then
			player:setTimeSinceLastSmoke(TimeSinceLastSmoke + 1);
			elseif TimeSinceLastSmoke > 10 then 
			player:setTimeSinceLastSmoke(10);
		end
		-- Smoker reduce hunger
		if TimeSinceLastSmoke <= 6 then
			SODecHunger(player, 50, 0.0005);
		end
		-- Smoker increase hunger
		if TimeSinceLastSmoke >= 9 then
			SOAddHunger(player, 25, 0.0005);
		end
	end
end

-- SMOKER TRAIT - SWING ENDUR LOSS
function smokerattack(player, weapon)
	local player = getPlayer();
	if player:HasTrait("Smoker") then
		local AsthmaticMult
		-- return if Bare Hands
		if weapon:getType() == "BareHands" then
			return
		end
		-- get item stats
		local WeaponInPrimaryHand = player:getPrimaryHandItem();
		local WeaponInSecondaryHand = player:getSecondaryHandItem();	
		-- if no mainhaind weapon then return
		if WeaponInPrimaryHand == nil then
			return
		end
		local WeaponEndMod = WeaponInPrimaryHand:getEnduranceMod();
		local WeaponWeight = WeaponInPrimaryHand:getWeight();
		if player:HasTrait("Asthmatic") then			
			AsthmaticMult = 1.3
				else AsthmaticMult = 1
		end				
		-- Endurance formula	
		local RWeaponEndCost = ((WeaponWeight * 0.003) * WeaponEndMod) * AsthmaticMult;	
		local RWeaponEndCost = round(RWeaponEndCost,6)
		-- Loses endurance while swing with chance
		SODecEndurance(player, 20, (RWeaponEndCost * 0.5));
		-- print("Smoker swing: " .. (RWeaponEndCost * 0.5))
	end
end

-- HIKER TRAIT - MAIN REGEN
function hikertrait ()
	local player = getPlayer();
	if player:getModData().SOminutesWalking == nil then
		player:getModData().SOminutesWalking = 0;
	end		
	if player:HasTrait("Hiker") then 
		if player:isPlayerMoving() and player:IsRunning() == false and player:isSprinting() == false and player:isSneaking() == false then
			player:getModData().SOminutesWalking = player:getModData().SOminutesWalking + 1;
			else
				player:getModData().SOminutesWalking = player:getModData().SOminutesWalking - 3;
		end
		if player:getModData().SOminutesWalking >= 10 then
			SODecFatigue(player, 100, 0.000125);
			SODecThirst(player, 100, 0.000125);	
			SODecHunger(player, 100, 0.000125);		
		end
		if player:getModData().SOminutesWalking > 13 then
			player:getModData().SOminutesWalking = 13;
			elseif player:getModData().SOminutesWalking < 0 then
			player:getModData().SOminutesWalking = 0;
		end	
	end
end

-- OPTIMIST TRAIT - HOURS UNTIL DEPRESSION
function hoursindepression ()
	local player = getPlayer();
	if player:getModData().SOhoursUntilDepression == nil then
		player:getModData().SOhoursUntilDepression = 0;
	end
	if player:HasTrait("Optimist") then
		if player:getBodyDamage():getUnhappynessLevel() >= 39 then
			player:getModData().SOhoursUntilDepression = player:getModData().SOhoursUntilDepression + 1;
			else
				player:getModData().SOhoursUntilDepression = player:getModData().SOhoursUntilDepression - 2;
		end
		if player:getModData().SOhoursUntilDepression > 168 then
		player:getModData().SOhoursUntilDepression = 168;
			elseif player:getModData().SOhoursUntilDepression < 0 then
			player:getModData().SOhoursUntilDepression = 0;
		end	
	-- print("SOhoursUntilDepression = " .. player:getModData().SOhoursUntilDepression)
	end
end

-- OPTIMIST TRAIT - MAIN
function optimisttrait ()
	local player = getPlayer();
	local currentUnhappyness = player:getBodyDamage():getUnhappynessLevel();	
	if player:getModData().SOhoursUntilDepression == nil then
		player:getModData().SOhoursUntilDepression = 0;
	end
	if player:HasTrait("Optimist") and not player:isAsleep() and player:getModData().SOhoursUntilDepression <= 32 then
		if player:getBodyDamage():getUnhappynessLevel() >= 50 then
			player:getBodyDamage():setUnhappynessLevel(49);	
		end
	end
end

-- OPTIMIST TRAIT - BOREDOOM
function optimistraitbored ()
	local player = getPlayer();
	local boredoommod = 0.045;
	if player:HasTrait("Optimist") then
		-- passive reducing boredoom		
		if not player:isAsleep() then
			SODecBoredom(player, 100, boredoommod);	
		end
		-- more reducing boredoom while sleeping	
		if player:isAsleep() then	
			SODecBoredom(player, 100, (boredoommod * 2));
		end	
	end
end

-- DEPRESSIVE TRAIT - MAIN
function depressivemoodtrait ()
	local player = getPlayer();
	local climateManager = getClimateManager();
	local currRainIntensity = climateManager:getRainIntensity();	
	
	if player:HasTrait("Depressive") and not player:isAsleep() then
		local depressionChance = 5
		-- if currRainIntensity >= 0.05 then 
		if RainManager:isRaining() then 
			depressionChance = 10
		-- print("rain depression");	
		end
		SOAddUnhappyness(player, depressionChance, (ZombRand(5)+1));	
		if ZombRand(1036) == 0 then
			SOAddUnhappyness(player, 100, (ZombRand(31)+70));
		end
	end
end		

-- COMMERCIAL DRIVER TRAIT - MAIN
function commdrivertrait()
	local player = getPlayer();
-- local playerdata = player:getModData();	
	if player:HasTrait("CommDriver") and not player:isAsleep() then
		if player:isDriving() == true then
			-- player:Say("wroom");		
			SODecFatigue(player, 50, 0.0015);
		end
	end
end

-- USED TO CORPSES TRAIT - MAIN
function gravemanjob(player)
	local player = getPlayer(); 
	local bodydamage = player:getBodyDamage();
	local foodSickness = bodydamage:getFoodSicknessLevel();
	local poison = bodydamage:getPoisonLevel();
	local infected = bodydamage:IsInfected();	
	local newSickness = foodSickness - 1;
	local FoodEatenLevel = player:getMoodles():getMoodleLevel(MoodleType.FoodEaten)
	if player:HasTrait("UsedToCorpses") then
		if foodSickness >= 1 and foodSickness <= 20 then 	
			if infected == false and poison == 0 then 	
				if player:HasTrait("SensitiveDigestion") and FoodEatenLevel == 0 then
					bodydamage:setFoodSicknessLevel(newSickness);	
--					print("Sickness protection with DS".. foodSickness)						
				elseif not player:HasTrait("SensitiveDigestion") then
					bodydamage:setFoodSicknessLevel(newSickness);
--					print("Sickness protection".. foodSickness)						
				end
				if newSickness < 0 then
					newSickness = 0
				end					
			end
		end
	end
	-- print("poison = " .. bodydamage:getPoisonLevel())	
end

-- LOW SWEATING - MAIN
function lesssweatytrait()	
	local player = getPlayer();
	local currentWetness = player:getBodyDamage():getWetness();
	local climateManager = getClimateManager();
	local currRainIntensity = climateManager:getRainIntensity();
 	if player:HasTrait("LessSweaty") and currentWetness > 0 and not player:isAsleep() then
		-- If Inside House or Vehicle
		if not player:isOutside() or not player:getVehicle() == nil then
			if player:IsRunning() == false and player:isSprinting() == false then
			SODecWetness(player, 100, 0.1);
			elseif player:IsRunning() == true then
			SODecWetness(player, 100, 0.125);
			elseif player:isSprinting() == true then
			SODecWetness(player, 100, 0.15);
			end		
		end
		-- If Outside House or Vehicle	
		if player:isOutside() and player:getVehicle() == nil then
			-- If No Rain			
			if currRainIntensity <= 0.09 then	
				if player:IsRunning() == false and player:isSprinting() == false then	
				SODecWetness(player, 100, 0.1);
				elseif player:IsRunning() == true then
				SODecWetness(player, 100, 0.125);
				elseif player:isSprinting() == true then
				SODecWetness(player, 100, 0.15);
				end		
			end
			-- If Medium Rain	
			if currRainIntensity >= 0.10 and currRainIntensity <= 0.39 then
				if player:IsRunning() == false and player:isSprinting() == false then	
				SODecWetness(player, 100, 0.05);
				elseif player:IsRunning() == true then
				SODecWetness(player, 100, 0.065);
				elseif player:isSprinting() == true then
				SODecWetness(player, 100, 0.08);
				end		
			end
			-- If Heavy Rain			
			if currRainIntensity >= 0.40 then
				if player:IsRunning() == false and player:isSprinting() == false then	
				SODecWetness(player, 100, 0.025);
				elseif player:IsRunning() == true then
				SODecWetness(player, 100, 0.3);
				elseif player:isSprinting() == true then
				SODecWetness(player, 100, 0.35);
				end		
			end
		end
		
	end
end	

-- EXCESSIVE SWEATING TRAIT - MAIN
function highsweatytrait()	
	local player = getPlayer();
	if player:HasTrait("HighSweaty") then 	
		local climateManager = getClimateManager();
		local currRainIntensity = climateManager:getRainIntensity();
		local stats = player:getStats();
		local currpanic = stats:getPanic();	
		-- if panic more than 25			
		if currpanic >= 25 then
			SOAddWetness(player, 25, 0.5);		
		end
		-- if panic more than 50		
		if currpanic >= 50 then
			SOAddWetness(player, 25, 0.5);		
		end		
		-- always 
		if player:IsRunning() == false and player:isSprinting() == false then
		SOAddThirst(player, 10, 0.0001);			
		SOAddWetness(player, 25, 0.25);
		end
		-- if running 		
		if player:IsRunning() == true then
		SOAddThirst(player, 25, 0.0002);		
		SOAddWetness(player, 50, 0.5);
		end
		-- if sprinting 		
		if player:isSprinting() == true then
		SOAddThirst(player, 50, 0.0003);		
		SOAddWetness(player, 100, 1);
		end		
	end
end

-- EXCESSIVE SWEATING TRAIT - ATTACK
function highsweatyattack(player, weapon)	
	local player = getPlayer();
	if player:HasTrait("HighSweaty") and not player:isAsleep() then
		if not weapon:getCategories():contains("Unarmed") then
			if weapon:getCategories():contains("Blunt") or weapon:getCategories():contains("LongBlade") or weapon:getCategories():contains("Spear") or weapon:getCategories():contains("Axe") then
				SOAddThirst(player, 28, 0.0001);			
				SOAddWetness(player, 50, 1)
			end
			if weapon:getCategories():contains("SmallBlunt") then
				SOAddThirst(player, 14, 0.0001);		
				SOAddWetness(player, 50, 0.5)
			end
			if weapon:getCategories():contains("SmallBlade") then
				SOAddThirst(player, 7, 0.0001);			
				SOAddWetness(player, 50, 0.25)
			end
		end	
		if weapon:getCategories():contains("Unarmed") then
			if not player:isAimAtFloor() then
			SOAddThirst(player, 28, 0.0001);			
			SOAddWetness(player, 33, 0.5)
			end
			if player:isAimAtFloor() then
			SOAddThirst(player, 28, 0.0001);			
			SOAddWetness(player, 33, 0.5)
			end				
		end	
	end
end

-- PRONE TO ILLNESS - COLD
function pronetoillnesscold()
	local player = getPlayer();
	local ChanceToCatchACold
	if player:HasTrait("ProneToIllness") and player:isOutside() then
		if player:HasTrait("Outdoorsman") then
			ChanceToCatchACold = 1440000 -- 0.1% per 24 hours with Outdoorsman
			else ChanceToCatchACold = 144000 -- 1.0% per 24 hours
		end
		if ZombRand(ChanceToCatchACold) == 0 and not player:getBodyDamage():isHasACold() then
--			player:Say("cold +");
			local currentColdStrength = player:getBodyDamage():getColdStrength();
			local addColdStrength = 35;
			player:getBodyDamage():setHasACold(true);
			player:getBodyDamage():setColdStrength(currentColdStrength + addColdStrength);
		end
	end
end

-- LIFELONGER LEARNER
function lifelongerlearnertrait()
	local player = getPlayer();
	if player:HasTrait("LifelongLearner") and player:isReading() == true then
		SODecBoredom(player, 100, 1);	
	end
end

-- ENJOY THE RIDE TRAIT - MAIN
function enjoytheridetrait()
	local player = getPlayer();
	if player:HasTrait("EnjoytheRide") then	
	if player:isDriving() == true then
		local vehicle = player:getVehicle();
			if vehicle:getCurrentSpeedKmHour() >= 60 then
			SODecUnhappyness(player, 100, (ZombRand(5)+1));
			SODecBoredom(player, 100, 10);
			SODecStress(player, 100, 0.1);
			end
		end
	end		
end

-- FEAR OF THE DARK TRAIT - MAIN
function fearofthedarktrait() 
 local player = getPlayer();
	local stats = player:getStats();
	local currpanic = stats:getPanic();	
	local vehicle = player:getVehicle();	
	local betaEffect = player:getBetaEffect()
	-- print("betaEffect: " .. betaEffect);	
	if player:HasTrait("FearoftheDark") and not player:isAsleep() and betaEffect <= 0 then
		local gamespeed = UIManager.getSpeedControls():getCurrentGameSpeed();
		local gsmultiplier = 1;
		if gamespeed == 1 then gsmultiplier = 1;
			elseif gamespeed == 2 then gsmultiplier = 5;
			elseif gamespeed == 3 then gsmultiplier = 20;
			elseif gamespeed == 4 then gsmultiplier = 40;
		end		
		if vehicle ~= nil then 
			if vehicle:getHeadlightsOn() then
			-- print("in car with headlight");		
				return
			end		
		-- print("in car");					
		end	
		
		local currsquare = player:getCurrentSquare();
		
		if currsquare == nil then
			return
		end
		
		local lightLevel = currsquare:getLightLevel(player:getPlayerNum());
		
		-- print("lightLevel: " .. lightLevel);			
		
		if lightLevel <= 0.36 then
			if currpanic <= 15 then
				player:getStats():setPanic(currpanic + (0.1 * gsmultiplier));
			end
			if player:HasTrait("Cowardly") then
				if currpanic >= 1 and currpanic <= 40 then
					player:getStats():setPanic(currpanic + (0.1 * gsmultiplier));
					elseif currpanic >= 1 and currpanic <= 20 then
						player:getStats():setPanic(currpanic + (0.05 * gsmultiplier));
				end	
			end
			
			if player:getStats():getPanic() > 99 then
				player:getStats():setPanic(99);
			end	
			if player:getStats():getPanic() < 0 then
				player:getStats():setPanic(0);
			end		
		end
	end
--	print("lightLevel: " .. lightLevel);	
end

-- FEAR OF THE DARK TRAIT - STRESS
function fearofthedarkstress() 
 local player = getPlayer();
	local stats = player:getStats();
	local currstress = stats:getStress();
	local vehicle = player:getVehicle();		
	if player:HasTrait("FearoftheDark") and not player:isAsleep() then
		if vehicle ~= nil then 
			if vehicle:getHeadlightsOn() then
			-- print("in car with headlight");		
				return
			end		
		-- print("in car");					
		end	
		local currsquare = player:getCurrentSquare();
		if currsquare == nil then
			return
		end
		local lightLevel = currsquare:getLightLevel(player:getPlayerNum());
		local lightLevel = currsquare:getLightLevel(player:getPlayerNum());
		if lightLevel <= 0.36 then
			if currstress <= 0.3 then 
				SOAddStress(player, 100, 0.025);	
			end
		end
	end
end

-- BRAWLER TRAIT - MAIN
function brawlerweapontrait(actor, target, weapon)
	local player = getPlayer();
	if player:HasTrait("Brawler") then	
		if actor == player and target:isZombie() == true then
			if weapon:getCategories():contains("Blunt") or weapon:getCategories():contains("LongBlade") or weapon:getCategories():contains("Spear") or weapon:getCategories():contains("Axe") then
				SODecUnhappyness(player, 18, (ZombRand(5)+1));			
			elseif weapon:getCategories():contains("SmallBlunt") then
				SODecUnhappyness(player, 18, (ZombRand(3)+1));			
			elseif weapon:getCategories():contains("SmallBlade") or weapon:getCategories():contains("Unarmed") then			
				SODecUnhappyness(player, 12, (ZombRand(2)+1));
			end
		end
	end
end


-- CHOP TREE EXP
function choptreesexp(player, weapon)
	local player = getPlayer();
	if weapon:getCategories():contains("Axe") then
		local WeaponTreeDamage = player:getPrimaryHandItem():getTreeDamage();
		-- print("WeaponTreeDamage: " .. WeaponTreeDamage);	
			TreeAxeChopXP = 0.0035 * WeaponTreeDamage;
		if player:HasTrait("HeavyAxeMyBeloved") then
			TreeAxeChopXP = TreeAxeChopXP * 2;
		end
		if AxeLvl >= 5 then TreeAxeChopXP = TreeAxeChopXP * 0.37 end
		TreeAxeChopXP = round(TreeAxeChopXP,3) -- round number to 0.000
		player:getXp():AddXP(Perks.Axe, TreeAxeChopXP);
		-- print("TreeAxeChopXP: " .. TreeAxeChopXP);	
	end
end

-- RUNNING FITNESS EXP
function runningfitnessxp()
	local player = getPlayer();
	if SOTOSbvars.AddFitXPWhileRun == true then
		if FitnessLvl <= 9 and player:isPlayerMoving() and player:IsRunning() == true then
			if ZombRand(2) == 0 then
				player:getXp():AddXP(Perks.Fitness, 1);	
				-- print("Fitness XP");				
			end
		end	
	end
end

-- BLADE TOOLS - MAIN
local isMyBTLBtoSBddXP = false
local isMyBTSBtoLBAddXP = false
function bladetoolstrait(player, perk, amount)
	if isMyBTLBtoSBddXP then return end
	if isMyBTSBtoLBAddXP then return end
	local player = getPlayer();
	local modifier = 0.15; -- +15%
	if player:HasTrait("BladeTools") then
		if perk == Perks.LongBlade then
			amount = amount * modifier;		
			isMyBTLBtoSBddXP = true 			
			player:getXp():AddXP(Perks.SmallBlade, amount, false, false, false);
			isMyBTLBtoSBddXP = false
		end
		if perk == Perks.SmallBlade then
			amount = amount * modifier;	
			isMyBTSBtoLBAddXP = true 			
			player:getXp():AddXP(Perks.LongBlade, amount, false, false, false);
			isMyBTSBtoLBAddXP = false
		end		
	end
end

-- WEAK BACK - PAIN
function weakbackpain()
	local player = getPlayer();		
	if player:HasTrait("WeakBack") then
		local Neck = player:getBodyDamage():getBodyPart(BodyPartType.FromString("Neck"));		
		if Neck:getPain() <= 15 and player:getMoodles():getMoodleLevel(MoodleType.HeavyLoad) == 4 then	
			SOAddPain(player, 100, "Neck", (ZombRand(3)+2));	
			elseif Neck:getPain() <= 15 and player:getMoodles():getMoodleLevel(MoodleType.HeavyLoad) == 3 then	
			SOAddPain(player, 100, "Neck", (ZombRand(2)+1));	
		end
	end
end

-- FRAGILE HEALT TRAIT - HEAVY LOAD
function fragilehealthheavyload()
	local player = getPlayer();
	if player == nil then
		return
	end
	if player:HasTrait("FragileHealth") and not player:isAsleep() then
		local HeavyLoadMoodleLevel = player:getMoodles():getMoodleLevel(MoodleType.HeavyLoad);
		if HeavyLoadMoodleLevel >= 3 then
			if player:getBodyDamage():getOverallBodyHealth() >= 49.25 then
				for i = 0, player:getBodyDamage():getBodyParts():size() - 1 do
				local b = player:getBodyDamage():getBodyParts():get(i);
				b:AddDamage(0.25);
				end
			end
		end
	end	
end

-- CALORIES TRAITS - MAIN
function caloriestraits()
	local player = getPlayer();
	if player == nil then
		return
	end
	local currcalories = player:getNutrition():getCalories()
	local weight = player:getNutrition():getWeight()

	-- calories spend PER HOUR x 60
	local CalSleeping	= 0.18
	local CalIdling		= 0.96
	local CalWalking	= 1.73
	local CalRunning	= 7.80
	local CalSprinting	= 10.14
	-- calories modifier
	local CalMod 		= 0.30 -- plus or minus 30% calories when doing actions
	
	-- adjusting calories
	-- callories when sleeping	
	if player:isAsleep() then
		if player:HasTrait("SlowMetabolism") and weight <= 90 then -- Gain weight faster when below 90 weight
			player:getNutrition():setCalories(currcalories + (CalSleeping * CalMod))
		end
		if player:HasTrait("FastMetabolism") and weight >= 70 then -- Losing weight faster when weight over 70
			player:getNutrition():setCalories(currcalories - (CalSleeping * CalMod))
		end		
	end
	-- callories when not sleeping	
	if not player:isAsleep() then
		-- callories when idling	
		if not player:isPlayerMoving() then
			if player:HasTrait("SlowMetabolism") and weight <= 90 then -- Gain weight faster when below 90 weight
				player:getNutrition():setCalories(currcalories + (CalIdling * CalMod))
			end
			if player:HasTrait("FastMetabolism") and weight >= 70 then -- Losing weight faster when weight over 70
				player:getNutrition():setCalories(currcalories - (CalIdling * CalMod))
			end		
		end	

		-- callories when walking		
		if player:isPlayerMoving() and player:IsRunning() == false and player:isSprinting() == false then
			if player:HasTrait("SlowMetabolism") and weight <= 90 then -- Gain weight faster when below 90 weight
				player:getNutrition():setCalories(currcalories + (CalWalking * CalMod))
			end
			if player:HasTrait("FastMetabolism") and weight >= 70 then -- Losing weight faster when weight over 70
				player:getNutrition():setCalories(currcalories - (CalWalking * CalMod))
			end		
		end	

		-- callories when running		
		if player:isPlayerMoving() and player:IsRunning() == true and player:isSprinting() == false then
			if player:HasTrait("SlowMetabolism") and weight <= 90 then -- Gain weight faster when below 90 weight
				player:getNutrition():setCalories(currcalories + (CalRunning * CalMod))
			end
			if player:HasTrait("FastMetabolism") and weight >= 70 then -- Losing weight faster when weight over 70
				player:getNutrition():setCalories(currcalories - (CalRunning * CalMod))
			end		
		end		

		-- callories when sprinting		
		if player:isPlayerMoving() and player:IsRunning() == false and player:isSprinting() == true then
			if player:HasTrait("SlowMetabolism") and weight <= 90 then -- Gain weight faster when below 90 weight
				player:getNutrition():setCalories(currcalories + (CalSprinting * CalMod))
			end
			if player:HasTrait("FastMetabolism") and weight >= 70 then -- Losing weight faster when weight over 70
				player:getNutrition():setCalories(currcalories - (CalSprinting * CalMod))
			end		
		end		
	end
end

-- CALORIES TRAITS - SWING
function caloriestraitsswing(player, weapon)
	local player = getPlayer();
	if player == nil then
		return
	end
	local currcalories = player:getNutrition():getCalories()
	local weight = player:getNutrition():getWeight()

	local calswingcost	 = 2.0
	local calmod		 = 0.3

	if weapon:getSwingAnim() == Heavy then calswingcost = 6.0 end
	
	if player:HasTrait("SlowMetabolism") and weight <= 90 then -- Gain weight faster when below 90 weight
		player:getNutrition():setCalories(currcalories + (calswingcost * calmod))
	end
	if player:HasTrait("FastMetabolism") and weight >= 70 then -- Losing weight faster when weight over 70
		player:getNutrition():setCalories(currcalories - (calswingcost * calmod))
	end		
end

-- CRUELTY - MAIN
local isMyCruelAddXP = false
function crueltytrait(player, perk, amount)
	if isMyCruelAddXP then return end
		local player = getPlayer();
		local modifier = 0.25; -- +25%
		if player:HasTrait("Cruelty") then
			if perk == Perks.Axe 
			or perk == Perks.Blunt
			or perk == Perks.SmallBlunt
			or perk == Perks.LongBlade 
			or perk == Perks.SmallBlade 
			or perk == Perks.Spear
			or perk == Perks.Maintenance
			or perk == Perks.Aiming 
			then
			-- print("Xp amount: " .. amount); 
						if amount > 30 or amount < 0 then return end
			 amount = amount * modifier;
			 isMyCruelAddXP = true 
			 player:getXp():AddXP(perk, amount, false, false, false);
			 isMyCruelAddXP = false
			-- print("Cruel newamount: " .. amount); 
		end
	end
end

-- XP BODY TYPE TRAITS
local isMyBodyTypeFMSTRAddXP = false
local isMyBodyTypeFMFITAddXP = false
local isMyBodyTypeSMSTRAddXP = false
local isMyBodyTypeSMFITAddXP = false
function bodytypetraitsxp(player, perk, amount)
	
	if isMyBodyTypeFMSTRAddXP then return end
	if isMyBodyTypeFMFITAddXP then return end
	if isMyBodyTypeSMSTRAddXP then return end
	if isMyBodyTypeSMFITAddXP then return end

	local player = getPlayer();
	
	if player:HasTrait("FastMetabolism") then
		local modifier = 0.30;
		if perk == Perks.Strength then
			if amount > 30 or amount < 0 then return end
--			print("STR XP: " .. amount); 
			amount = (amount * modifier) * -1;-- -30%		
			isMyBodyTypeFMSTRAddXP = true			
			player:getXp():AddXP(perk, amount, false, false, false);
			isMyBodyTypeFMSTRAddXP = false
--			print("Str removed: " .. amount); 
		end
		if perk == Perks.Fitness then
			if amount > 30 or amount < 0 then return end
--			print("Fit XP: " .. amount); 
			amount = (amount * modifier);-- +30%	
			isMyBodyTypeFMFITAddXP = true					
			player:getXp():AddXP(perk, amount, false, false, false);
			isMyBodyTypeFMFITAddXP = false
--			print("Fit added: " .. amount); 			
		end		
	end	
	if player:HasTrait("SlowMetabolism") then
		local modifier = 0.30;	
		if perk == Perks.Fitness then
			if amount > 30 or amount < 0 then return end
			amount = (amount * modifier) * -1;-- -30%		
			isMyBodyTypeSMFITAddXP = true				
			player:getXp():AddXP(perk, amount, false, false, false);
			isMyBodyTypeSMFITAddXP = false	
		end
		if perk == Perks.Strength then
			if amount > 30 or amount < 0 then return end
			amount = (amount * modifier);-- +30%		
			isMyBodyTypeSMSTRAddXP = true			
			player:getXp():AddXP(perk, amount, false, false, false);
			isMyBodyTypeSMSTRAddXP = false	
		end		
	end	
end

-- DEPRESSIVE TRAIT - XP ALWAYS SHOULD BE LAST!
local isMyDepressiveAddXP = false
function depressivexp(player, perk, amount)
	if isMyDepressiveAddXP then return end
	if player:HasTrait("Depressive") then
		local UnhappyMoodleLevel = player:getMoodles():getMoodleLevel(MoodleType.Unhappy);
		local UnhappyXPMod = 0
		if UnhappyMoodleLevel == 2 then UnhappyXPMod = 0.03;
		elseif UnhappyMoodleLevel == 3 then UnhappyXPMod = 0.06;
		elseif UnhappyMoodleLevel == 4 then UnhappyXPMod = 0.10;
		end	
		if UnhappyMoodleLevel >= 2 then
			if amount > 30 or amount < 0 then return end
--			print("XP: " .. tostring(perk) .. amount); 			
			amount = -(amount * UnhappyXPMod)
			isMyDepressiveAddXP = true	
			player:getXp():AddXP(perk, amount, false, false, false);
			isMyDepressiveAddXP = false
--			print("XP removed: " .. tostring(perk) .. amount); 
		end	
	end
end

-- EVENTS --
-- ON HIT TREE
Events.OnWeaponHitTree.Add(choptreesexp);
-- ON HIT
Events.OnWeaponHitCharacter.Add(brawlerweapontrait);
-- ON SWING
--OnWeaponSwing
Events.OnWeaponSwingHitPoint.Add(tirelesstrait);
Events.OnWeaponSwingHitPoint.Add(sorellegsstomppain);
Events.OnWeaponSwingHitPoint.Add(highsweatyattack);
Events.OnWeaponSwingHitPoint.Add(smokerattack);
Events.OnWeaponSwingHitPoint.Add(caloriestraitsswing);
-- ON PLAYER UPDATE
Events.OnPlayerUpdate.Add(liquidbloodtrait);
Events.OnPlayerUpdate.Add(thickbloodtrait);
Events.OnPlayerUpdate.Add(optimisttrait);
Events.OnPlayerUpdate.Add(fearofthedarktrait);
-- EVERY ONE MINUTE
Events.EveryOneMinute.Add(breathingtechtrait);
Events.EveryOneMinute.Add(ninjawaytrait);
Events.EveryOneMinute.Add(marathonrunnertrait);
Events.EveryOneMinute.Add(runningfitnessxp);
Events.EveryOneMinute.Add(sorelegstrait);
Events.EveryOneMinute.Add(panicattackstrait);
Events.EveryOneMinute.Add(allergictrait);
Events.EveryOneMinute.Add(commdrivertrait);
Events.EveryOneMinute.Add(optimistraitbored);
Events.EveryOneMinute.Add(smokertraitmain);
Events.EveryOneMinute.Add(hikertrait);
Events.EveryOneMinute.Add(lesssweatytrait);
Events.EveryOneMinute.Add(highsweatytrait);
Events.EveryOneMinute.Add(fearofthedarkstress);
Events.EveryOneMinute.Add(enjoytheridetrait);
Events.EveryOneMinute.Add(weakbackpain);
Events.EveryOneMinute.Add(sensitivedigestiontrait);
Events.EveryOneMinute.Add(snorertrait);
Events.EveryOneMinute.Add(pronetoillnesscold);
Events.EveryOneMinute.Add(fragilehealthheavyload);
Events.EveryOneMinute.Add(caloriestraits);
--Events.EveryOneMinute.Add(alcoholbottlesdrinked);
--Events.EveryOneMinute.Add(SOalcoholictrait);
Events.EveryOneMinute.Add(lifelongerlearnertrait);
Events.EveryOneMinute.Add(gravemanjob);
Events.EveryOneMinute.Add(musclestraintraits)
-- EVERY TEN MINUTES
Events.EveryTenMinutes.Add(larkpersontrait);
Events.EveryTenMinutes.Add(owlpersontrait);
Events.EveryTenMinutes.Add(depressivemoodtrait);
Events.EveryTenMinutes.Add(smokeroftenandhunger);
--Events.EveryTenMinutes.Add(SOalcoholictrait2);
--Events.EveryTenMinutes.Add(SOalcoholicAnimshaking);
Events.EveryTenMinutes.Add(chronicmigrainetrait)
-- EVERY HOUR
Events.EveryHours.Add(hoursindepression);
Events.EveryHours.Add(SOcheckWeight);
-- ADD EXP
Events.AddXP.Add(crueltytrait);
Events.AddXP.Add(bladetoolstrait);
Events.AddXP.Add(depressivexp);
Events.AddXP.Add(bodytypetraitsxp);
-- ON GAME START
Events.OnGameStart.Add(SOcheckWeight);
-- ON CREATE PLAYER
Events.OnCreatePlayer.Add(SOcheckWeight);
--

--[[
function debugeveryonemin()
	local player = getPlayer(); 
	local bodydamage = player:getBodyDamage();
	local STEffect = player:getSleepingTabletEffect()
	local PillsTaken = player:getSleepingPillsTaken()
	print("STEffect = " .. STEffect)	
	print("PillsTaken = " .. PillsTaken)	
--	print("Every one min");	
end
Events.EveryOneMinute.Add(debugeveryonemin);]]
	

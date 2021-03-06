---------------------------------------------------
------------ CUSTOM CHANGELOG FUNCTIONS -----------
---------------------------------------------------
local TMW                                   = TMW
local _G, type, error, time     			= _G, type, error, time
local A                         			= _G.Action
local TeamCache								= Action.TeamCache
local EnemyTeam								= Action.EnemyTeam
local FriendlyTeam							= Action.FriendlyTeam
local LoC									= Action.LossOfControl
local Player								= Action.Player 
local MultiUnits							= Action.MultiUnits
local UnitCooldown							= Action.UnitCooldown
local ActiveUnitPlates						= MultiUnits:GetActiveUnitPlates()
local next, pairs, type, print              = next, pairs, type, print
local IsActionInRange, GetActionInfo, PetHasActionBar, GetPetActionsUsable, GetSpellInfo = IsActionInRange, GetActionInfo, PetHasActionBar, GetPetActionsUsable, GetSpellInfo
local UnitIsPlayer, UnitExists, UnitGUID    = UnitIsPlayer, UnitExists, UnitGUID
local PetLib                                = LibStub("PetLibrary")
local Unit                                  = Action.Unit 
local huge                                  = math.huge
local UnitBuff                              = _G.UnitBuff
local UnitIsUnit                            = UnitIsUnit
local StdUi 								= LibStub("StdUi")
-- Lua
local error                                 = error
local setmetatable                          = setmetatable
local stringformat                          = string.format
local tableinsert                           = table.insert
local TR                                    = Action.TasteRotation

-------------------------------------------------------------------------------
-- Profil Loader
-------------------------------------------------------------------------------
-- Load default profils for each class
local currentClass = select(2, UnitClass("player"))
local currentSpec = GetSpecialization()
local currentSpecName = currentSpec and select(2, GetSpecializationInfo(currentSpec)) or "None"

-- Druid
if currentClass == "WARRIOR" then
    Action.Data.DefaultProfile[currentClass] = "[Taste]Action - Warrior"
end

-- Warlock
if currentClass == "WARLOCK" then
    Action.Data.DefaultProfile[currentClass] = "[Taste]Action - Warlock"
end

-- Rogue
if currentClass == "ROGUE" then
    Action.Data.DefaultProfile[currentClass] = "[Taste]Action - Rogue"
end

-- Shaman
if currentClass == "SHAMAN" then
    Action.Data.DefaultProfile[currentClass] = "[Taste]Action - Shaman"
end

-- DeathKnight
if currentClass == "DEATHKNIGHT" then
    Action.Data.DefaultProfile[currentClass] = "[Taste]Action - Death Knight"
end

-- Priest
if currentClass == "PRIEST" then
    Action.Data.DefaultProfile[currentClass] = "[Taste]Action - Priest"
end

-- Paladin
if currentClass == "PALADIN" then
    Action.Data.DefaultProfile[currentClass] = "[Taste]Action - Paladin"
end

-- Mage
if currentClass == "MAGE" then
    Action.Data.DefaultProfile[currentClass] = "[Taste]Action - Mage"
end

-- Hunter
if currentClass == "HUNTER" then
    Action.Data.DefaultProfile[currentClass] = "[Taste]Action - Hunter"
end

-- Demon Hunter
if currentClass == "DEMONHUNTER" then
    Action.Data.DefaultProfile[currentClass] = "[Taste]Action - Demon Hunter"
end

-- Druid
if currentClass == "DRUID" then
    Action.Data.DefaultProfile[currentClass] = "[Taste]Action - Druid"
end



--------------------------------------
--------- POPUP/CHANGELOG API --------
--------------------------------------
-- Return a popup message on player login that show all the latest change for rotations. 
-- Each classes got a ProfileUI button to enable/disable this option. (In case of Streaming)

-- Init popup
TR.Popup = {
    popupname = Action.PlayerSpec,
    message = "",
	button1 = "",
	button2 = "",
	timeout = 0,
	whileDead = true,
	hideOnEscape = true,	
}

-- Popup Creation function.
-- @Return string depending of current player specialization
-- @Usage TR:CreatePopup(PlayerSpec, TR.PlayerSpec.Changelog, "OK", nil, 0, true, true)
function TR:CreatePopup(popupname, message, button1, button2, timeout, whileDead, hideOnEscape)
    local Errormessage = "Error on popup : You did not set any message."
    local Errorbutton = "Cancel"
	--local PlayerSpec = Action.PlayerSpec
	
	if popupname then
	    TR.Popup.popupname = popupname
	else
	    TR.Popup.popupname = 999
	end
	
	if message then 
	    TR.Popup.message = message
	else
	    TR.Popup.message = Errormessage
	end
	
	if button1 then
	    TR.Popup.button1 = button1
	else
	    TR.Popup.button1 = Errorbutton
	end
	
	if button2 then
	    TR.Popup.button2 = button2
	else
	    TR.Popup.button2 = Errorbutton
	end	
	
	if timeout then 
	    TR.Popup.timeout = timeout
	else
	    TR.Popup.timeout = 0
	end
	
	if whileDead then
	    TR.Popup.whileDead = whileDead
	end
	
	if hideOnEscape then
	    TR.Popup.hideOnEscape = hideOnEscape
	end   
	
	return TR.Popup.popupname, TR.Popup.message, TR.Popup.button1, TR.Popup.button2, TR.Popup.timeout, TR.Popup.whileDead, TR.Popup.hideOnEscape
	
end

-- Changelog handler for each specialisation
-- @To do: find a way to improve ingame indentation and presentation
function TR:UpdateChangeLog()
local PlayerSpec = Action.PlayerSpec

--------------------
------ SHAMAN ------
--------------------
	-- Elemental
	if PlayerSpec == 262 then
	    ChangeLog = [[
		Welcome to Taste - Elemental Shaman !
		
List of latest changes :

- New : Blocked Spells Status Frame (see 2nd tab)
- Fixed Elemental Blast behavior
- Reworked DBM opener
- Fixed Healing Surge				

As always, please report on Discord or message me directly if you need anything !
]]  

	end	
	-- Enhancement
	if PlayerSpec == 263 then
	    ChangeLog = [[
		Welcome to Taste - Enhancement Shaman !
		
Prepatch rotations are not optimized and are just a way to play until Shadowlands is out. 

Rotations will stay in an unstable state until Shadowlands release.

Thanks for comprehension.
]]  

	end
	
	-- Restoration
	if PlayerSpec == 264 then
	    ChangeLog = "Welcome to Taste Rotations !\n\nThis spec is currently in developpement.\n\nFollow latests update on Discord."					
	end
	
--------------------
----- PALADIN ------
--------------------	
	-- Retribution
	if PlayerSpec == 70 then
	    ChangeLog = [[
		Welcome to Taste - Retribution Paladin !
		
Prepatch rotations are not optimized and are just a way to play until Shadowlands is out. 

Rotations will stay in an unstable state until Shadowlands release.

Thanks for comprehension.
]]  
					
	end
	
	-- Protection
	if PlayerSpec == 66 then
	    ChangeLog = [[
		Welcome to Taste - Protection Paladin !
		
Prepatch rotations are not optimized and are just a way to play until Shadowlands is out. 

Rotations will stay in an unstable state until Shadowlands release.

Thanks for comprehension.
]]  
					
	end
	
	-- Holy
	if PlayerSpec == 65 then
	    ChangeLog = [[
		Welcome to Taste - Holy Paladin !
	    
		***** TEST BUILD *****	
		
Prepatch rotations are not optimized and are just a way to play until Shadowlands is out. 

Rotations will stay in an unstable state until Shadowlands release.

Thanks for comprehension.
]]  				
	end

--------------------
----- WARLOCK ------
--------------------
	-- Affliction
	if PlayerSpec == 265 then
	    ChangeLog = [[
		Welcome to Taste - Affliction Warlock !
		
Prepatch rotations are not optimized and are just a way to play until Shadowlands is out. 

Rotations will stay in an unstable state until Shadowlands release.

Thanks for comprehension.
]]  
					
	end

	-- Demonology
	if PlayerSpec == 266 then
	    ChangeLog = [[
		Welcome to Taste - Demonology Warlock !
		
Prepatch rotations are not optimized and are just a way to play until Shadowlands is out. 

Rotations will stay in an unstable state until Shadowlands release.

Thanks for comprehension.
]]  
					
	end

	-- Destruction
	if PlayerSpec == 267 then
	    ChangeLog = [[
		Welcome to Taste - Destruction Warlock !
		
Prepatch rotations are not optimized and are just a way to play until Shadowlands is out. 

Rotations will stay in an unstable state until Shadowlands release.

Thanks for comprehension.
]]  
					
	end	
	


--------------------
----- WARRIOR ------
--------------------
	-- Arms
	if PlayerSpec == 71 then
	    ChangeLog = [[
		Welcome to Taste - Arms Warrior !
		
Prepatch rotations are not optimized and are just a way to play until Shadowlands is out. 

Rotations will stay in an unstable state until Shadowlands release.

Thanks for comprehension.
]]  
					
	end

	-- Fury
	if PlayerSpec == 72 then
	    ChangeLog = [[
		Welcome to Taste - Fury Warrior !
		
Prepatch rotations are not optimized and are just a way to play until Shadowlands is out. 

Rotations will stay in an unstable state until Shadowlands release.

Thanks for comprehension.
]]  
					
	end

	-- Protection
	if PlayerSpec == 73 then
	    ChangeLog = [[
		Welcome to Taste - Protection Warrior !
		
Prepatch rotations are not optimized and are just a way to play until Shadowlands is out. 

Rotations will stay in an unstable state until Shadowlands release.

Thanks for comprehension.
]]  
					
	end


--------------------
--- DEATHKNIGHT ----
--------------------
	-- Blood
	if PlayerSpec == 250 then
	    ChangeLog = [[
		Welcome to Taste - Blood Death Knight !
		
Prepatch rotations are not optimized and are just a way to play until Shadowlands is out. 

Rotations will stay in an unstable state until Shadowlands release.

Thanks for comprehension.
]]  
					
	end

	-- Frost
	if PlayerSpec == 251 then
	    ChangeLog = [[
		Welcome to Taste - Frost Death Knight !
		
Prepatch rotations are not optimized and are just a way to play until Shadowlands is out. 

Rotations will stay in an unstable state until Shadowlands release.

Thanks for comprehension.
]]  
					
	end

	-- Unholy
	if PlayerSpec == 252 then
	    ChangeLog = [[
		Welcome to Taste - Unholy Death Knight !
		
Prepatch rotations are not optimized and are just a way to play until Shadowlands is out. 

Rotations will stay in an unstable state until Shadowlands release.

Thanks for comprehension.
]]  
					
	end


--------------------
--- DEMON HUNTER ---
--------------------
	-- Havoc
	if PlayerSpec == 577 then
	    ChangeLog = [[
		Welcome to Taste - Havoc Demon Hunter !
		
Prepatch rotations are not optimized and are just a way to play until Shadowlands is out. 

Rotations will stay in an unstable state until Shadowlands release.

Thanks for comprehension.
]]  
					
	end

	-- Vengeance
	if PlayerSpec == 581 then
	    ChangeLog = [[
		Welcome to Taste - Vengeance Demon Hunter !
		
Prepatch rotations are not optimized and are just a way to play until Shadowlands is out. 

Rotations will stay in an unstable state until Shadowlands release.

Thanks for comprehension.
]]  
					
	end


--------------------
------ ROGUE -------
--------------------
	-- Assassination
	if PlayerSpec == 259 then
	    ChangeLog = [[
		Welcome to Taste - Assassination Rogue !
		
Prepatch rotations are not optimized and are just a way to play until Shadowlands is out. 

Rotations will stay in an unstable state until Shadowlands release.

Thanks for comprehension.
]]  
					
	end

	-- Outlaw
	if PlayerSpec == 260 then
	    ChangeLog = [[
		Welcome to Taste - Outlaw Rogue !
		
Prepatch rotations are not optimized and are just a way to play until Shadowlands is out. 

Rotations will stay in an unstable state until Shadowlands release.

Thanks for comprehension.
]]  
					
	end

	-- Subtlety
	if PlayerSpec == 261 then
	    ChangeLog = [[
		Welcome to Taste - Subtely Rogue !
		
Prepatch rotations are not optimized and are just a way to play until Shadowlands is out. 

Rotations will stay in an unstable state until Shadowlands release.

Thanks for comprehension.
]]
					
	end


--------------------
------ HUNTER ------
--------------------
	-- BeastMastery
	if PlayerSpec == 253 then
	    ChangeLog = [[
		Welcome to Taste - BeastMastery Hunter !

Prepatch rotations are not optimized and are just a way to play until Shadowlands is out. 

Rotations will stay in an unstable state until Shadowlands release.

Thanks for comprehension.
]]  
					
	end

	-- Marksmanship
	if PlayerSpec == 254 then
	    ChangeLog = [[
		Welcome to Taste - Marksmanship Hunter !
				
Prepatch rotations are not optimized and are just a way to play until Shadowlands is out. 

Rotations will stay in an unstable state until Shadowlands release.

Thanks for comprehension.
]]
					
	end

	-- Survival
	if PlayerSpec == 255 then
	    ChangeLog = [[
		Welcome to Taste - Survival Hunter !
				
Prepatch rotations are not optimized and are just a way to play until Shadowlands is out. 

Rotations will stay in an unstable state until Shadowlands release.

Thanks for comprehension.
]]  
					
	end


--------------------
------- MAGE -------
--------------------
	-- Arcane
	if PlayerSpec == 62 then
	    ChangeLog = [[
		Welcome to Taste - Arcane Mage !
		
Prepatch rotations are not optimized and are just a way to play until Shadowlands is out. 

Rotations will stay in an unstable state until Shadowlands release.

Thanks for comprehension.

]]  				
	end

	-- Fire
	if PlayerSpec == 63 then
	    ChangeLog = [[
		Welcome to Taste - Fire Mage !
		
Prepatch rotations are not optimized and are just a way to play until Shadowlands is out. 

Rotations will stay in an unstable state until Shadowlands release.

Thanks for comprehension.

]] 				
	end

	-- MFrost
	if PlayerSpec == 64 then
	    ChangeLog = [[
		Welcome to Taste - Frost Mage !
		
Prepatch rotations are not optimized and are just a way to play until Shadowlands is out. 

Rotations will stay in an unstable state until Shadowlands release.

Thanks for comprehension.

]] 				
	end


--------------------
------ DRUID -------
--------------------
	-- Balance
	if PlayerSpec == 102 then
	    ChangeLog = [[
		Welcome to Taste - Balance Druid !
		
Prepatch rotations are not optimized and are just a way to play until Shadowlands is out. 

Rotations will stay in an unstable state until Shadowlands release.

Thanks for comprehension.
]]  
					
	end

	-- Feral
	if PlayerSpec == 103 then
	    ChangeLog = [[
		Welcome to Taste - Feral Druid !
		
Prepatch rotations are not optimized and are just a way to play until Shadowlands is out. 

Rotations will stay in an unstable state until Shadowlands release.

Thanks for comprehension.
]]  
					
	end

	-- Guardian
	if PlayerSpec == 104 then
	    ChangeLog = [[
		Welcome to Taste - Guardian Druid !
		
List of latest changes :

- New : Blocked Spells Status Frame (see 2nd tab)
- Updated to 8.3 APLs
- Fix on AutoTaunt
- Fixed Arcane Torrent logic

TODO : Rework all defensives logic			

As always, please report on Discord or message me directly if you need anything !
]]  
					
	end

	-- Restoration
	if PlayerSpec == 105 then
	    ChangeLog = [[
		Welcome to Taste - Restoration Druid !
		
Prepatch rotations are not optimized and are just a way to play until Shadowlands is out. 

Rotations will stay in an unstable state until Shadowlands release.

Thanks for comprehension.
]]  
					
	end


--------------------
------- MONK -------
--------------------
	-- Brewmaster
	if PlayerSpec == 268 then
	    ChangeLog = "Welcome to Taste Rotations !\n\nThis spec is currently in developpement.\n\nFollow latests update on Discord."					
	end

	-- Windwalker
	if PlayerSpec == 269 then
	    ChangeLog = "Welcome to Taste Rotations !\n\nThis spec is currently in developpement.\n\nFollow latests update on Discord."				
	end

	-- Mistweaver
	if PlayerSpec == 270 then
	    ChangeLog = "Welcome to Taste Rotations !\n\nThis spec is currently in developpement.\n\nFollow latests update on Discord."				
	end


--------------------
------ PRIEST ------
--------------------
	-- Discipline
	if PlayerSpec == 256 then
	    ChangeLog = "Welcome to Taste Rotations !\n\nThis spec is currently in developpement.\n\nFollow latests update on Discord."				
	end

	-- PHoly
	if PlayerSpec == 257 then
	    ChangeLog = "Welcome to Taste Rotations !\n\nThis spec is currently in developpement.\n\nFollow latests update on Discord."				
	end

	-- Shadow
	if PlayerSpec == 258 then
	    ChangeLog = [[
		Welcome to Taste - Shadow Priest !

Prepatch rotations are not optimized and are just a way to play until Shadowlands is out. 

Rotations will stay in an unstable state until Shadowlands release.

Thanks for comprehension.
]]  
					
	end

	return ChangeLog
end

-- Love Popup
-- This is secret popup :)
StaticPopupDialogs["LOVE_POPUP"] = {
  text = "Hey there ! Thanks for clicking the love button :)\n\nLove is the most important part :)\n\nDon't forget that you can ask me whatever you want on rotations. Feedbacks are really appreciated if you got optimized gear for the current content and see some rotations mistakes !\n\nCreating good profils is long task and take a lot of time as you can imagine. I will always try to do my best to satisfy everyone so do not hesitate to discord me if needed!\n\nHave a good game and thanks for reading !\n\nPS:Don't forget to post logs on discord :)",
  button1 = "Okay :)",
  button2 = "Close",
  OnAccept = function()
      StaticPopup_Hide ("LOVE_POPUP")
  end,
  timeout = 0,
  whileDead = true,
  hideOnEscape = true,
  preferredIndex = 3,  -- avoid some UI taint, see http://www.wowace.com/announcements/how-to-avoid-some-ui-taint/
}

------------------------
-- CHANGELOG CALLBACK --
------------------------ 
TMW:RegisterCallback("TMW_ACTION_IS_INITIALIZED", function()

-- Spec specific Popup
local PlayerSpec = Action.PlayerSpec
local currentChangelog = TR:UpdateChangeLog()
local Errormessage = "Error on popup : You did not set any message."
local profileName = TMW.db:GetCurrentProfile()
local ChangelogOnStartup = A.GetToggle(2, "ChangelogOnStartup")

    -- Dynamic popup creation
    if Action.PlayerSpec and ChangelogOnStartup then
        TR:CreatePopup(Action.PlayerSpec, currentChangelog, "Okay", "Marry Me", 0, true, true)
    else	 
        TR:CreatePopup(999, "Welcome to Taste Rotations !\n\nThis spec is currently in developpement.\n\nFollow latests update on Discord.", "OK", nil, 0, true, true)
    end	
	
	-- Create Popup Frame dynamically 
    StaticPopupDialogs[TR.Popup.popupname] = {
        text = TR.Popup.message, --"Do you want to greet the world today?",
        button1 = TR.Popup.button1, --"Yes", -- On ACCEPT
        button2 = TR.Popup.button2, --"No", -- On CANCEL
        OnAccept = function()
            StaticPopup_Hide (TR.Popup.popupname)
        end,
        OnCancel = function()
            StaticPopup_Show ("LOVE_POPUP")
        end,
        timeout = TR.Popup.timeout,
        whileDead = TR.Popup.whileDead,
        hideOnEscape = TR.Popup.hideOnEscape,
        preferredIndex = 3,  -- avoid some UI taint, see http://www.wowace.com/announcements/how-to-avoid-some-ui-taint/
    }

    -- Check for Taste profils
    if PlayerSpec then
        if profileName:match("Taste") then
            if PlayerSpec and ChangelogOnStartup then
                StaticPopup_Show (PlayerSpec)
	        end
        end
    end
	
end)
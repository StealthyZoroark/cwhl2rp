--[[
	? 2012 CloudSixteen.com do not share, re-distribute or modify
	without permission of its author (kurozael@gmail.com).
--]]

local CLASS = Clockwork.class:New();
	CLASS.color = Color(250, 0, 0, 255);
	CLASS.factions = {FACTION_RED};
	CLASS.isDefault = true;
	CLASS.description = "A red-line soldier who lives in the metros";
	CLASS.defaultPhysDesc = "Wearing SpetSnaz armour";
CLASS_RED = Clockwork.class:Register(CLASS, "Red Line");
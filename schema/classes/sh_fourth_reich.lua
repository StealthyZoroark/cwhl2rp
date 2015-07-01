--[[
	? 2012 CloudSixteen.com do not share, re-distribute or modify
	without permission of its author (kurozael@gmail.com).
--]]

local CLASS = Clockwork.class:New();
	CLASS.color = Color(120, 255, 0, 180);
	CLASS.factions = {FACTION_FOTH};
	CLASS.isDefault = true;
	CLASS.description = "A neo-nazi person who lives in the metro";
	CLASS.defaultPhysDesc = "Wearing SpetSnaz armour";
CLASS_FOTH = Clockwork.class:Register(CLASS, "Fourth Reich");
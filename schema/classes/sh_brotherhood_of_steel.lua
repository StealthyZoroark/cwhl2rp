--[[
	© 2012 CloudSixteen.com do not share, re-distribute or modify
	without permission of its author (kurozael@gmail.com).
--]]

local CLASS = Clockwork.class:New("Ranger");
	CLASS.color = Color(200, 200, 50, 255);
	CLASS.factions = {FACTION_RANGER};
	CLASS.isDefault = true;
	CLASS.wagesName = "Supplies";
	CLASS.description = "A ranger that lives in the Metro station.";
	CLASS.defaultPhysDesc = "Wearing SpetSnaz armour";
CLASS_BROTHERHOOD = Clockwork.class:Register(CLASS, "Ranger");
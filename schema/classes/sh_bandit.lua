--[[
	© 2012 CloudSixteen.com do not share, re-distribute or modify
	without permission of its author (kurozael@gmail.com).
--]]

local CLASS = Clockwork.class:New();
	CLASS.color = Color(165, 155, 95, 255);
	CLASS.factions = {FACTION_CIVILIAN};
	CLASS.isDefault = false;
	CLASS.description = "A bandit of the world's most catastrophic epidemic.";
	CLASS.defaultPhysDesc = "Wearing dirty clothes and a small satchel";
CLASS_BANDIT = Clockwork.class:Register(CLASS, "Bandit");
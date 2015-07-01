--[[
	© 2012 CloudSixteen.com do not share, re-distribute or modify
	without permission of its author (kurozael@gmail.com).
--]]

local CLASS = Clockwork.class:New("Bandit");
	CLASS.color = Color(165, 155, 95, 255);
	CLASS.factions = {FACTION_BANDIT};
	CLASS.isDefault = false;
	CLASS.wagesName = "Theft";
	CLASS.description = "A bandit of the world's most catastrophic epidemic.";
	CLASS.defaultPhysDesc = "Wearing dirty clothes and a small satchel";
CLASS_BANDIT = CLASS:Register();
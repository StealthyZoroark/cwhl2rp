--[[
	? 2012 CloudSixteen.com do not share, re-distribute or modify
	without permission of its author (kurozael@gmail.com).
--]]

local CLASS = Clockwork.class:New("Dark Ones");
	CLASS.color = Color(170, 0, 255, 255);
	CLASS.factions = {FACTION_DARK};
	CLASS.isDefault = true;
	CLASS.wagesName = "Supplies";
	CLASS.description = "A human who was at the surface during the bomb falling";
	CLASS.defaultPhysDesc = "Dark skin | Mutant looking face | Long arms |";
CLASS_DARK = CLASS:Register();
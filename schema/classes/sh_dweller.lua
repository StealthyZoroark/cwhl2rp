--[[
	© 2013 CloudSixteen.com do not share, re-distribute or modify
	without permission of its author (kurozael@gmail.com).
--]]

local CLASS = Clockwork.class:New("Metro Dweller");
	CLASS.color = Color(150, 125, 100, 255);
	CLASS.factions = {FACTION_DWELLER};
	CLASS.isDefault = true;
	CLASS.wagesName = "Supplies";
	CLASS.description = "A regular human citizen enslaved by the Universal Union.";
	CLASS.defaultPhysDesc = "Wearing dirty clothes.";
CLASS_DWELLER = CLASS:Register();
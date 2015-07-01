--[[
	? 2012 CloudSixteen.com do not share, re-distribute or modify
	without permission of its author (kurozael@gmail.com).
--]]

local ITEM = Clockwork.item:New("clothes_base");
	ITEM.cost = 300;
	ITEM.name = "Bandit Clothing";
	ITEM.weight = 1;
	ITEM.replacement = "models/devcon/mrp/act/bandit_vest2.mdl";
	ITEM.description = "Clothing that includes a ski mask, and some combat boots";
Clockwork.item:Register(ITEM);
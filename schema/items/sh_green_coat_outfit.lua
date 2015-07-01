--[[
	? 2012 CloudSixteen.com do not share, re-distribute or modify
	without permission of its author (kurozael@gmail.com).
--]]

local ITEM = Clockwork.item:New("clothes_base");
	ITEM.cost = 300;
	ITEM.name = "Green Coat Outfit";
	ITEM.weight = 1;
	ITEM.replacement = "models/devcon/mrp/act/green_coat.mdl";
	ITEM.description = "Clothing that includes a ski mask, a green coat, and some combat boots";
Clockwork.item:Register(ITEM);
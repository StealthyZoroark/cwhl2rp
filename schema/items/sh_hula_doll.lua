--[[
	� 2012 CloudSixteen.com do not share, re-distribute or modify
	without permission of its author (kurozael@gmail.com).
--]]

local ITEM = Clockwork.item:New("junk_base");
	ITEM.name = "Hula Doll";
	ITEM.worth = 1;
	ITEM.model = "models/props_lab/huladoll.mdl";
	ITEM.weight = 0.1
	ITEM.description = "A Hula Doll, it sways from side to side.";
        ITEM.value = 1;
Clockwork.item:Register(ITEM);
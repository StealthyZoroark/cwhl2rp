--[[
	© 2012 CloudSixteen.com do not share, re-distribute or modify
	without permission of its author (kurozael@gmail.com).
--]]

local FACTION = {};

FACTION.useFullName = true;
FACTION.whitelist = true;
FACTION.material = "newvegas/factions/bos";
FACTION.models = {
	female = {"models/error.mdl"},
	male = {"models/metro2033/nikout/player/ranger2.mdl"}
};

-- Called when a player's model should be assigned for the faction.
function FACTION:GetModel(player, character)
	if (character.gender == GENDER_MALE) then
		return self.models.male[1];
	else
		return self.models.female[1];
	end;
end;

FACTION_RANGER = Clockwork.faction:Register(FACTION, "Ranger");
--[[
	© 2012 CloudSixteen.com do not share, re-distribute or modify
	without permission of its author (kurozael@gmail.com).
--]]

local FACTION = Clockwork.faction:New("Bandit");

FACTION.useFullName = true;
FACTION.whitelist = true;
FACTION.material = "newvegas/factions/bos";
FACTION.models = {
	female = {"models/error.mdl"},
	male = {"models/metro2033/nikout/player/ranger2.mdl"}
};

-- Called when a player's model should be assigned for the faction.
function FACTION:OnTransferred(player, faction, name)
	if (Schema:PlayerIsCombine(player)) then
		if (name) then
			local models = self.models[ string.lower( player:QueryCharacter("gender") ) ];
			
			if (models) then
				player:SetCharacterData("model", models[ math.random(#models) ], true);
				
				Clockwork.player:SetName(player, name, true);
			end;
		else
			return false, "You need to specify a name as the third argument!";
		end;
	end;
end;

FACTION_BANDIT = FACTION:Register();
--[[
	© 2013 CloudSixteen.com do not share, re-distribute or modify
	without permission of its author (kurozael@gmail.com).
--]]

local FACTION = Clockwork.faction:New("Metro Dweller");
FACTION.material = "cwmetro2033/factions/civilian"
FACTION.useFullName = true;
FACTION.models = {
	female = {
		"models/stalkertnb/bandit_female1.mdl",
		"models/stalkertnb/bandit_female2.mdl",
		"models/stalkertnb/bandit_female3.mdl",
		"models/stalkertnb/bandit_female4.mdl",
		"models/stalkertnb/bandit_female5.mdl",
		"models/stalkertnb/bandit_female6.mdl",
		"models/stalkertnb/bandit_female71.mdl",
		"models/stalkertnb/bandit_female8.mdl",
		"models/humans/group34/female_01.mdl",
		"models/humans/group34/female_01.mdl",
		"models/humans/group38/female_04.mdl",
		"models/humans/group40/female_03.mdl",
		"models/humans/group41/female_04.mdl",
		"models/humans/group42/female_06.mdl",
		"models/humans/group43/female_07.mdl",
		"models/humans/group43/female_02.mdl",
	},
	male = {
		"models/stalkertnb/bandit_belowthebelt.mdl",
		"models/stalkertnb/bandit_capt.mdl",
		"models/stalkertnb/bandit_hour.mdl",
		"models/stalkertnb/bandit_jack.mdl",
		"models/stalkertnb/bandit_male1.mdl",
		"models/stalkertnb/bandit_male2.mdl",
		"models/stalkertnb/bandit_male3.mdl",
		"models/stalkertnb/bandit_male4.mdl",
		"models/stalkertnb/bandit_male5.mdl",
		"models/stalkertnb/bandit_nikolai.mdl",
		"models/stalkertnb/bandit_overwatch.mdl",
		"models/humans/group34/male_01.mdl",
		"models/humans/group37/male_02.mdl",
		"models/humans/group38/male_06.mdl",
		"models/humans/group40/male_07.mdl",
		"models/humans/group42/male_05.mdl",
		"models/humans/group42/male_03.mdl",
		"models/humans/group40/male_04.mdl",
		"models/humans/group42/male_08.mdl"
	};
};


-- Called when a player is transferred to the faction.
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

FACTION_DWELLER = FACTION:Register();
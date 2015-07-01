local PLUGIN = PLUGIN;

Clockwork.kernel:IncludePrefixed("sv_plugin.lua")

PLUGIN.weaponDefaultModels = {
	weapon_ar2 = "models/weapons/w_irifle.mdl",
	weapon_bugbait = "models/weapons/w_bugbait.mdl",
	weapon_crossbow = "models/weapons/w_crossbow.mdl",
	weapon_crowbar = "models/weapons/w_crowbar.mdl",
	weapon_frag = "models/items/grenadeammo.mdl",
	weapon_pistol = "models/weapons/w_pistol.mdl",
	weapon_shotgun = "models/weapons/w_shotgun.mdl",
	weapon_slam = "models/weapons/w_slam.mdl",
	weapon_smg1 = "models/weapons/w_smg1.mdl",
	weapon_stunstick = "models/weapons/w_stunbaton.mdl"
}

PLUGIN.defaultAmmoInfo = {
	["weapon_357"] = {"357", nil, true},
	["weapon_ar2"] = {"ar2", "ar2altfire", 30},
	["weapon_rpg"] = {"rpg_round", nil, 3},
	["weapon_smg1"] = {"smg1", "smg1_grenade", true},
	["weapon_slam"] = {"slam", nil, 2},
	["weapon_frag"] = {"grenade", nil, 1},
	["weapon_pistol"] = {"pistol", nil, true},
	["weapon_shotgun"] = {"buckshot", nil, true},
	["weapon_crossbow"] = {"xbowbolt", nil, 4}
};

PLUGIN.qualities = {
	Rubbish = {color = Color(204, 204, 204, 255), multiplierVariation = -0.1},
	Common = {color = Color(255, 255, 255, 255), multiplierVariation = 0},
	Uncommon = {color = Color(38, 196, 38, 255), multiplierVariation = 0.1},
	Rare = {color = Color(87, 87, 231, 255), multiplierVariation = 0.2},
	Extraordinary = {color = Color(140, 2, 205, 255), multiplierVariation = 0.3},
	Unique = {color = Color(240, 148, 10, 255), multiplierVariation = 0.4}
};

function PLUGIN:GetQualityTable(quality) -- Will return nil if non-existant
	local iQuality = tonumber(quality);
	if (type(iQuality) == "number") then
		local key = 1;
		for k, v in pairs (self.qualities) do
			if key == iQuality then
				return {text = k, color = v.color, multiplierVariation = v.multiplierVariation};
			end
			key = key + 1;
		end
	elseif (type(quality) == "string") then
		quality = string.lower(quality)
		for k, v in pairs (self.qualities) do
			if (string.lower(k) == quality) or (string.lower(string.gsub(k, "%s", "")) == string.lower(string.gsub(quality, "%s", ""))) then
				return {text = k, color = v.color, multiplierVariation = v.multiplierVariation};
			end
		end
	end
end



local string = string;
function string.Escape(str)
	local escapedString = "";
	local bEscapeNext = false;
	for i = 1, #str do
		local char = string.sub(str, i, i);

		if (bEscapeNext) then
			if (char == "\\") then
				escapedString = escapedString.."\\"; bEscapeNext = false;
			elseif (char == "a") then
				escapedString = escapedString.."\a"; bEscapeNext = false;
			elseif (char == "b") then
				escapedString = escapedString.."\b"; bEscapeNext = false;
			elseif (char == "f") then
				escapedString = escapedString.."\f"; bEscapeNext = false;
			elseif (char == "n") then
				escapedString = escapedString.."\n"; bEscapeNext = false;
			elseif (char == "r") then
				escapedString = escapedString.."\r"; bEscapeNext = false;
			elseif (char == "t") then
				escapedString = escapedString.."\t"; bEscapeNext = false;
			elseif (char == "v") then
				escapedString = escapedString.."\v"; bEscapeNext = false;
			else
				escapedString = escapedString..char; bEscapeNext = false;
			end
		else
			bEscapeNext = (char == "\\");
			if (!bEscapeNext) then escapedString = escapedString..char; end;
		end
	end

	return escapedString;
end
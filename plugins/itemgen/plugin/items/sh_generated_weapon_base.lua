local PLUGIN = PLUGIN;

local ITEM = Clockwork.item:New("weapon_base");
ITEM.name = "Generated Weapon - DND";
ITEM.cost = 50;
ITEM.model = "models/weapons/w_pistol.mdl";
ITEM.weight = 1;
ITEM.category = "Generated weaponClass";
ITEM.description = "A generated weapon.";
ITEM.defaultQuality = "common";
ITEM.weaponClass = "weapon_pistol";
ITEM.uniqueID = "generated_weapon_base";

ITEM:AddData("model", "models/weapons/w_pistol.mdl", true);
ITEM:AddData("name", "Generated Weapon", true);
ITEM:AddData("description", "Base description.", true);
ITEM:AddData("category", "Generated Weapons", true);
ITEM:AddData("cost", 50, true);
ITEM:AddData("weight", 1, true);
ITEM:AddData("quality", "common", true);
ITEM:AddData("weaponClass", "weapon_pistol", true);

function ITEM:GetAmmoData()
	local weaponClass = self("weaponClass");
	local weaponTable = weapons.GetStored(weaponClass);
	local ammoInfo = {}
	
	if (weaponTable) then
		if (weaponTable.Primary and weaponTable.Primary.Ammo) then
			ammoInfo.primaryAmmoClass = weaponTable.Primary.Ammo;
		end
		
		if (weaponTable.Secondary and weaponTable.Secondary.Ammo) then
			ammoInfo.secondaryAmmoClass = weaponTable.Secondary.Ammo;
		end
		
		if (weaponTable.Primary and weaponTable.Primary.DefaultClip) then
			if (weaponTable.Primary.DefaultClip > 0) then
				if (weaponTable.Primary.ClipSize == -1) then
					ammoInfo.primaryDefaultAmmo = weaponTable.Primary.DefaultClip;
					ammoInfo.hasNoPrimaryClip = true;
				else
					ammoInfo.primaryDefaultAmmo = true;
				end
			end
		end
		
		if (weaponTable.Secondary and weaponTable.Secondary.DefaultClip) then
			if (weaponTable.Secondary.DefaultClip > 0) then
				if (weaponTable.Secondary.ClipSize == -1) then
					ammoInfo.secondaryDefaultAmmo = weaponTable.Secondary.DefaultClip;
					ammoInfo.hasNoSecondaryClip = true;
				else
					ammoInfo.secondaryDefaultAmmo = true;
				end
			end
		end
	elseif (PLUGIN.defaultAmmoInfo[weaponClass]) then
		ammoInfo.primaryAmmoClass = PLUGIN.defaultAmmoInfo[weaponClass][1];
		ammoInfo.secondaryAmmoClass = PLUGIN.defaultAmmoInfo[weaponClass][2];
		ammoInfo.primaryDefaultAmmo = PLUGIN.defaultAmmoInfo[weaponClass][3];
		ammoInfo.secondaryDefaultAmmo = PLUGIN.defaultAmmoInfo[weaponClass][4];
	end

	return ammoInfo;
end

function ITEM:QueryPrimaryAmmoClass()
	return self:GetAmmoData().primaryAmmoClass;
end

function ITEM:QueryPrimaryDefaultAmmo()
	return self:GetAmmoData().primaryDefaultAmmo;
end

function ITEM:QuerySecondaryAmmoClass()
	return self:GetAmmoData().secondaryAmmoClass;
end

function ITEM:QuerySecondaryAmmoClass()
	return self:GetAmmoData().secondaryDefaultAmmo;
end

function ITEM:QueryModel()
	return self:GetData("model")
end

function ITEM:QueryName()
	return self:GetData("name")
end

function ITEM:QueryDescription()
	return self:GetData("description")
end

function ITEM:QueryCategory()
	return self:GetData("category")
end

function ITEM:QueryCost()
	return self:GetData("cost")
end

function ITEM:QueryWeight()
	return self:GetData("weight")
end

function ITEM:QueryQuality()
	local quality = self:GetData("quality");
	local qualityTable = PLUGIN:GetQualityTable(quality);
	if !qualityTable then
		return PLUGIN:GetQualityTable(self.defaultQuality);
	else
		return qualityTable;
	end
end

function ITEM:QueryColor()
	return self("quality").color;
end

function ITEM:QueryWeaponClass()
	return self:GetData("weaponClass");
end


ITEM:AddQueryProxy("model", ITEM.QueryModel);
ITEM:AddQueryProxy("name", ITEM.QueryName);
ITEM:AddQueryProxy("description", ITEM.QueryDescription);
ITEM:AddQueryProxy("category", ITEM.QueryCategory);
ITEM:AddQueryProxy("cost", ITEM.QueryCost);
ITEM:AddQueryProxy("weight", ITEM.QueryWeight);
ITEM:AddQueryProxy("quality", ITEM.QueryQuality);
ITEM:AddQueryProxy("color", ITEM.QueryColor);
ITEM:AddQueryProxy("weaponClass", ITEM.QueryWeaponClass);
ITEM:AddQueryProxy("primaryAmmoClass", ITEM.QueryPrimaryAmmoClass);
ITEM:AddQueryProxy("primaryDefaultAmmo", ITEM.QueryPrimaryDefaultAmmo);
ITEM:AddQueryProxy("secondaryAmmoClass", ITEM.QuerySecondaryAmmoClass);
ITEM:AddQueryProxy("secondaryDefaultAmmo", ITEM.QuerySecondaryDefaultAmmo);

-- Called when a player drops the item.
function ITEM:OnDrop(player, position) end;

if (CLIENT) then
	function ITEM:GetClientSideInfo()
		if (!self:IsInstance()) then
			return;
		end;
		
		local clientSideInfo = "";
		local quality = self("quality");
		local informationColor = Clockwork.option:GetColor("information");
		local color = nil;
		
		if (quality) then
			clientSideInfo = Clockwork.kernel:AddMarkupLine(clientSideInfo, "Quality: ")..Clockwork.kernel:MarkupTextWithColor(quality.text, quality.color);
			color = quality.color;
		end;
		clientSideInfo = Clockwork.kernel:AddMarkupLine(clientSideInfo, "Approximate Worth: ")..Clockwork.kernel:MarkupTextWithColor(self("cost"), color);
		return clientSideInfo;
	end;
end;

ITEM:Register();
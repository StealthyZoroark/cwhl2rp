local PLUGIN = PLUGIN;

local ITEM = Clockwork.item:New("weapon_base");

ITEM.name ="Metal Bat";
ITEM.cost = 25;
ITEM.category = "Melee";
ITEM.model = "models/weapons/w_basball.mdl";
ITEM.weight = 3.5;
ITEM.uniqueID = "weapon_bat";
ITEM.business = false;
ITEM.description = "A metal bat, a very good close quarters blunt weapon."
ITEM.isAttachment = true;
  ITEM.hasFlashlight = false;
        ITEM.loweredOrigin = Vector(3, 0, -4);
        ITEM.loweredAngles = Angle(0, 45, 0);
        ITEM.attachmentBone = "ValveBiped.Bip01_Spine";
        ITEM.attachmentOffsetAngles = Angle(0, 0, 0);
        ITEM.attachmentOffsetVector = Vector(-3.96, 4.95, -2.97);
	
	
	ITEM.isBroken = false
	ITEM.hasFlashlight = false
	ITEM.defaultQuality = "common";
	
	ITEM:AddData("model", ITEM.model, true);
	ITEM:AddData("name", ITEM.name, true);
	ITEM:AddData("description", ITEM.description, true);
	ITEM:AddData("category", ITEM.category, true);
	ITEM:AddData("cost", ITEM.cost, true);
	ITEM:AddData("weight", ITEM.weight, true);
	ITEM:AddData("quality", ITEM.quality, true);
	ITEM:AddData("weaponClass", ITEM.weaponClass, true);
	
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
	self:GetData("name")--return self("condition").text.." "..self:GetData("name")
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
	
function ITEM:OnCustomFunction(player, funcName)
	if (funcName == "Repair") then
		if (player:HasItemByID("weapon_repair_kit")) then
			--Clockwork.player:SetAction(player, "weapon_repairing", 20);
			--timer.Simple(20, function()
			self:SetData("Durability", 100)
			self:SetData("isBroken", false, 0)
			self:SetData("Condition", "Factory New", 0)
			player:TakeItem(player:FindItemByID("weapon_repair_kit"));
			Clockwork.player:Notify(player, "The weapon has been fully repaired.")
			--end)
			Clockwork.player:SetAction(player, "weapon_repairing", false);
		else
			Clockwork.player:Notify(player, "You dont have a item that can repair this weapon.")
		end
	end
		
	if (funcName == "Attach/Detach Flashlight") then
		--print ("custom func has ran")
	local hasFlashlight = self:GetData("hasFlashlight");
		
		if(hasFlashlight) then -- if they have flashlight, they wanna take it off, no need to check if the player has one, infact that would be a bug, gives them a flashlight
			--print("trying to detach")
			self:SetData("hasFlashlight", false)
			ITEM.hasFlashlight = false
			player:GiveItem(Clockwork.item:CreateInstance("flashlight"), true)
			Clockwork.player:Notify(player, "The flashlight has been removed, you now have a flashlight in your inventory.")
		
		elseif(player:HasItemByID("flashlight") and !hasFlashlight) then -- making sure they have a flashlight and theres not already one attached
			--print("trying to attach")
			self:SetData("hasFlashlight", true)
			ITEM.hasFlashlight = true
			player:TakeItem(player:FindItemByID("flashlight"));
			Clockwork.player:Notify(player, "A flashlight has been attached, you may now press F to use it.")
		else
			Clockwork.player:Notify(player, "You don't have a flashlight to attach")
		end
	end
end
		
ITEM:Register();
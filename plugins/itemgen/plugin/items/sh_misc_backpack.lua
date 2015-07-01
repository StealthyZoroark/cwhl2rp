--[[
	� 2013 CloudSixteen.com do not share, re-distribute or modify
	without permission of its author (kurozael@gmail.com).
--]]
local PLUGIN = PLUGIN;
local ITEM = Clockwork.item:New();
ITEM.name = "Backpack";
ITEM.model = "models/props_junk/garbage_bag001a.mdl";
ITEM.weight = 2;
ITEM.category = "Storage";
ITEM.isRareItem = true;
ITEM.description = "Common backpack. Can't hold too much.";
ITEM.addInvSpace = 14;

-- Called when the item's drop entity should be created.
function ITEM:OnCreateDropEntity(player, position)
	return Clockwork.entity:CreateItem(player, Clockwork.item:CreateInstance("boxed_backpack"), position);
end;

-- Called when a player attempts to take the item from storage.
function ITEM:CanTakeStorage(player, storageTable)
	local target = Clockwork.entity:GetPlayer(storageTable.entity);
	
	if (target) then
		local inventoryWeight = Clockwork.inventory:CalculateWeight(
			target:GetInventory()
		);

		if (inventoryWeight > (target:GetMaxWeight() - self("addInvSpace"))) then
			return false;
		end;
	end;
	
	if (player:HasItemByID(self.uniqueID) and table.Count(player:GetItemsByID(self.uniqueID)) >= 1) then
		return false;
	end;
end;

-- Called when a player attempts to pick up the item.
function ITEM:CanPickup(player, quickUse, itemEntity)
	return "boxed_backpack";
end;

-- Called when a player drops the item.
function ITEM:OnDrop(player, position)
	if (player:GetInventoryWeight() > (player:GetMaxWeight() - self("addInvSpace"))) then
		Clockwork.player:Notify(player, "You cannot drop this while you are carrying items in it!");
		
		return false;
	end;
end;

ITEM.defaultQuality = "uncommon";

	ITEM:AddData("quality", ITEM.defaultQuality, true);
	
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
	
	ITEM:AddQueryProxy("quality", ITEM.QueryQuality, true);
	ITEM:AddQueryProxy("color", ITEM.QueryColor, true);
	
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
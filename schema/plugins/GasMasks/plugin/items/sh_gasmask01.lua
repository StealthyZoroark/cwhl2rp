local ITEM = Clockwork.item:New();
ITEM.name = "Gas Mask";
ITEM.model = "models/elec/mrp/equipment/gas_mask_02.mdl";
ITEM.weight = 0.25;
ITEM.batch = 1;
ITEM.business = true;
ITEM.category = "Clothing";
ITEM.description = "A gas mask that keeps you breathing.";
ITEM.isAttachment = true;
ITEM.attachmentBone = "ValveBiped.Bip01_Head1";
ITEM.attachmentOffsetAngles = Angle(90, -93.74, 0);
ITEM.attachmentOffsetVector = Vector(0, -1.12, 0.3);
ITEM.access = "U";
ITEM.cost = 20;

--[[
--Called when a player uses the item.
function ITEM:OnEquip(player)
	print("THIS SHIT IS BEING CALLED IT'S BEING CALLED YES IT IS BEING CALLED.");
	print( player:SteamID() );
	--player:EmitSound("xhosters/a_breath.mp3", 500, 200)
	player:SetSharedVar("wearingRespirator", true);
end;
--]]

-- Called when the attachment offset info should be adjusted.
function ITEM:AdjustAttachmentOffsetInfo(player, entity, info)
	if ( string.find(player:GetModel(), "female") ) then
		info.offsetVector = Vector(0, 0, 0);
	end;
end;

-- A function to get whether the attachment is visible.
function ITEM:GetAttachmentVisible(player, entity)
	if ( player:GetSharedVar("gasmask1") ) then
		return true;
	end;
end;

-- Called when the item's local amount is needed.
function ITEM:GetLocalAmount(amount)
	if ( Clockwork.Client:GetSharedVar("gasmask1") ) then
		return amount - 1;
	else
		return amount;
	end;
end;

-- Called to get whether a player has the item equipped.
function ITEM:HasPlayerEquipped(player, arguments)
	return player:GetSharedVar("gasmask1");
end;

-- Called when a player has unequipped the item.
function ITEM:OnPlayerUnequipped(player, arguments)
	local skullMaskGear = Clockwork.player:GetGear(player, "gasmask1");
	
	if ( player:GetSharedVar("gasmask1") and IsValid(skullMaskGear) ) then
		player:SetCharacterData("gasmask1", nil);
		player:SetSharedVar("gasmask1", false);
		player:SetSharedVar("wearingRespirator", false);
		
		if ( IsValid(gasmask1Gear) ) then
			gasmask1Gear:Remove();
		end;
	end;
	player:RebuildInventory();
end;

-- Called when a player drops the item.
function ITEM:OnDrop(player, position)
	if (player:GetSharedVar("gasmask1") and player:HasItem(self.uniqueID) == 1) then
		Clockwork.player:Notify(player, "You cannot drop this while you are wearing it!");
		
		return false;
	end;
end;

-- Called when a player uses the item.
function ITEM:OnUse(player, itemEntity)
	if ( player:Alive() and !player:IsRagdolled() ) then
		Clockwork.player:CreateGear(player, "gasmask1", self);
		
		player:SetCharacterData("gasmask1", true);
		player:SetSharedVar("gasmask1", true);
		player:SetSharedVar("wearingRespirator", true);
		player:RebuildInventory();
		
		itemEntity:Remove();
		
		if (itemEntity) then
			return true;
		end;
	else
		Clockwork.player:Notify(player, "You don't have permission to do this right now!");
	end;
	
	return false;
end;

ITEM:Register();
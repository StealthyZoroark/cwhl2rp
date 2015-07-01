-- code from weapons just incase you ever need it
--[[	if (player:HasItemByID("flashlight")) then
				self:SetData("hasFlashlight", true)
				ITEM.hasFlashlight = true
				player:TakeItem(player:FindItemByID("flashlight"));
				Clockwork.player:Notify(player, "A flashlight has been attached, you may now press F to use it.")
			else
				Clockwork.player:Notify(player, "You dont have a flashlight to attach.")
			end
		end
		
		if (funcName == "Detach Flashlight") then
		local hasFlashlight = self:GetData("hasFlashlight");
			if (hasFlashlight) then
				self:SetData("hasFlashlight", false)
				ITEM.hasFlashlight = false
				player:GiveItem(Clockwork.item:CreateInstance("flashlight"), true)
				Clockwork.player:Notify(player, "The flashlight has been removed, you now have a flashlight in your inventory.")
			else
				Clockwork.player:Notify(player, "Theres no flashlight on the weapon.")
			end
		end--]]


		
local function GetClientSideInfo(itemTable)
	local durability = itemTable:GetData("Durability");
	local condition = itemTable:GetData("Condition");
	local hasFlashlight = itemTable:GetData("hasFlashlight");
	local isBroken = itemTable:GetData("isBroken");
	local isMeleeWeapon = itemTable:GetData("isMeleeWeapon")
	local isFakeWeapon = itemTable:GetData("isFakeWeapon")
	local clientSideInfo = "";
	local durabilityColor = Color((255 / 100) * (100 - durability), (255 / 100) * durability, 0, 255);
	local colorGreen = Color(0, 255, 0);
	local colorRed = Color(255, 0, 0);
	
	local uniqueID = itemTable("uniqueID")
	
	if (uniqueID != "cw_flashlight" and uniqueID != "weapon_sledge" and uniqueID != "weapon_axe" and uniqueID != "weapon_shovel" and uniqueID != "weapon_katana" and uniqueID != "weapon_bat") then -- flashlights dont have durability or condition
	if (isFakeWeapon == true or isFakeWeapon == nil) then
		clientSideInfo = Clockwork.kernel:AddMarkupLine(
			clientSideInfo, "Condition: " ..condition.. " ("..math.floor(durability).."%)", durabilityColor
		);
	else
		print("fake!")
	end
	
	
	if (isFakeWeapon == true or isFakeWeapon == nil or isMeleeWeapon == true or isMeleeWeapon == nil) then
		if (hasFlashlight) then
			clientSideInfo = Clockwork.kernel:AddMarkupLine(
				clientSideInfo, "Flashlight: Yes", colorGreen
			);
		end
	
		if (!hasFlashlight) then
			clientSideInfo = Clockwork.kernel:AddMarkupLine(
				clientSideInfo, "Flashlight: No", colorRed
			);
		end
	else
		print("either melee or fake")
	end
	
	
	return (clientSideInfo != "" and clientSideInfo);
end;
end

-- Called when a Clockwork item has initialized.
function cwDurableWeapons:ClockworkItemInitialized(itemTable)
	if (Clockwork.item:IsWeapon(itemTable) or isFakeWeapon == true) then
		if (itemTable.GetClientSideInfo) then
			itemTable.OldGetClientSideInfo = itemTable.GetClientSideInfo;
			itemTable.NewGetClientSideInfo = GetClientSideInfo;
			itemTable.GetClientSideInfo = function(itemTable)
				local existingText = itemTable:OldGetClientSideInfo();
				local additionText = itemTable:NewGetClientSideInfo() or "";
				local totalText = (existingText and existingText.."\n" or "")..additionText;
				
				return (totalText != "" and totalText);
			end;
		else
			itemTable.GetClientSideInfo = GetClientSideInfo;
		end;
		
		itemTable:AddData("Durability", 100, true);
		itemTable:AddData("Condition", "Factory New", true);
		itemTable:AddData("hasFlashlight", false, true);
		itemTable:AddData("isBroken", false, true);
	end;
end;

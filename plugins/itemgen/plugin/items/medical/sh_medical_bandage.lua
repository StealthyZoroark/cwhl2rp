local PLUGIN = PLUGIN;
local ITEM = Clockwork.item:New();
ITEM.name = "Bandage";
ITEM.cost = 15;
ITEM.model = "models/stalker/item/medical/bandage.mdl";
ITEM.weight = 1;
ITEM.value = 0.2;
ITEM.access = "v";
ITEM.useText = "Apply";
ITEM.category = "Medical"
ITEM.business = true;
ITEM.useSound = "hgn/stalker/player/pl_bandage.mp3";
ITEM.description = "A old, rough bandage that can be used to stop bleeding.";
ITEM.customFunctions = {"Give"};

ITEM.defaultQuality = "common";

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

-- Called when a player uses the item.
function ITEM:OnUse(player, itemEntity)
	player:SetHealth( math.Clamp( player:Health() + 40, 0, player:GetMaxHealth() ) );
	
	Clockwork.plugin:Call("PlayerHealed", player, player, self);
end;

-- Called when a player drops the item.
function ITEM:OnDrop(player, position) end;

if (SERVER) then
	function ITEM:OnCustomFunction(player, name)
		if (name == "Give") then
			Clockwork.player:RunClockworkCommand(player, "CharHeal", "health_kit");
		end;
	end;
end;

ITEM:Register();
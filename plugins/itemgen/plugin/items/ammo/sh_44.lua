local PLUGIN = PLUGIN;

local ITEM = Clockwork.item:New("ammo_base");
	ITEM.name = ".44 Bullets";
	ITEM.cost = 100;
	ITEM.model = "models/stalker/ammo/magnum.mdl";
	ITEM.weight = .5;
	ITEM.access = "V";
	ITEM.uniqueID = "ammo_44";
	ITEM.business = true;
	ITEM.ammoClass = "gravity";
	ITEM.ammoAmount = 15;
	ITEM.description = "A box of six .44 magnum rounds.";
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
local PLUGIN = PLUGIN;

local ITEM = Clockwork.item:New();
ITEM.name = "Scaulpa";
ITEM.cost = 5;
ITEM.model = "models/Gibs/HGIBS_scapula.mdl";
ITEM.weight = 0.2;
ITEM.access = "k";
ITEM.batch = 1;
ITEM.category = "Junk";
ITEM.business = true;
ITEM.description = "A Scaulpa from a human body.";
ITEM.defaultQuality = "rubbish";

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
-- Called when a player drops the item.
function ITEM:OnDrop(player, position) end;

ITEM:Register();

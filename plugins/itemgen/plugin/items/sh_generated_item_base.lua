local PLUGIN = PLUGIN;

local ITEM = Clockwork.item:New();
ITEM.name = "Generated Item - DND";
ITEM.cost = 50;
ITEM.model = "models/props_junk/garbage_metalcan002a.mdl";
ITEM.weight = 1;
ITEM.category = "Generated Items";
ITEM.description = "A generated item.";
ITEM.defaultQuality = "common";
ITEM.uniqueID = "generated_item_base"

ITEM:AddData("model", "models/props_junk/garbage_metalcan002a.mdl", true);
ITEM:AddData("name", "Generated Item", true);
ITEM:AddData("description", "A generated item.", true);
ITEM:AddData("category", "Generated Items", true);
ITEM:AddData("cost", 50, true);
ITEM:AddData("weight", 1, true);
ITEM:AddData("quality", "common", true);

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
	return self:GetData("cost") * (1 + self("quality").multiplierVariation);
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

ITEM:AddQueryProxy("model", ITEM.QueryModel, true);
ITEM:AddQueryProxy("name", ITEM.QueryName, true);
ITEM:AddQueryProxy("description", ITEM.QueryDescription, true);
ITEM:AddQueryProxy("category", ITEM.QueryCategory, true);
ITEM:AddQueryProxy("cost", ITEM.QueryCost, true);
ITEM:AddQueryProxy("weight", ITEM.QueryWeight, true);
ITEM:AddQueryProxy("quality", ITEM.QueryQuality, true);
ITEM:AddQueryProxy("color", ITEM.QueryColor, true);

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
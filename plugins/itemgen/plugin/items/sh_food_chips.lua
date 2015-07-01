local PLUGIN = PLUGIN;
local ITEM = Clockwork.item:New();

ITEM.name = "Chips";
ITEM.cost = 20;
ITEM.model = "models/fallout 3/chips.mdl";
ITEM.weight = 0.5;
ITEM.access = "1";
ITEM.useText = "Eat";
ITEM.business = true;
ITEM.category = "Consumables";
ITEM.defaultQuality = "common";
ITEM.description = "A fresh bag of chips.";

ITEM:AddData("model", ITEM.model, true);
ITEM:AddData("name", ITEM.name, true);
ITEM:AddData("description", ITEM.description, true);
ITEM:AddData("category", ITEM.category, true);
ITEM:AddData("cost", ITEM.cost, true);
ITEM:AddData("weight", ITEM.weight, true);
ITEM:AddData("quality", ITEM.defaultQuality, true);

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

function ITEM:OnUse(player, itemEntity)
	player:SetHealth( math.Clamp( player:Health() + 10, 0, player:GetMaxHealth() ) );
	
	player:BoostAttribute(self.name, ATB_ENDURANCE, 2, 120);
	player:BoostAttribute(self.name, ATB_ACCURACY, 1, 120);
end;

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

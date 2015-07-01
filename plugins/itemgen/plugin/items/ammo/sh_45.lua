local PLUGIN = PLUGIN;

local ITEM = Clockwork.item:New("ammo_base");
	ITEM.name = ".45 Bullets";
	ITEM.cost = 15;
	ITEM.model = "models/stalker/ammo/45cal.mdl";
	ITEM.weight = .5;
	ITEM.access = "V";
	ITEM.uniqueID = "ammo_45";
	ITEM.category = "Ammunition";
	ITEM.business = true;
	ITEM.ammoClass = "combinecannon";
	ITEM.ammoAmount = 8;
	ITEM.description = "A bullet that packs a punch, the container holds 8 bullets.";
	ITEM.defaultQuality = "uncommon";
	
	ITEM:AddData("quality", ITEM.defaultQuality, true);
	ITEM:AddData("model", ITEM.model, true);
	ITEM:AddData("name", ITEM.name, true);
	ITEM:AddData("description", ITEM.description, true);
	ITEM:AddData("category", ITEM.category, true);
	ITEM:AddData("cost", ITEM.cost, true);
	ITEM:AddData("weight", ITEM.weight, true);
	ITEM:AddData("quality", ITEM.quality, true);
	ITEM:AddData("ammoClass", ITEM.ammoClass, true);
	ITEM:AddData("ammoAmount", ITEM.ammoAmount, true);
	
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

function ITEM:QueryammoClass()
	return self:GetData("ammoClass");
end

function ITEM:QueryammoAmount()
	return self:GetData("ammoAmount");
end
	
	ITEM:AddQueryProxy("quality", ITEM.QueryQuality, true);
	ITEM:AddQueryProxy("color", ITEM.QueryColor, true);
	ITEM:AddQueryProxy("model", ITEM.QueryModel);
ITEM:AddQueryProxy("name", ITEM.QueryName);
ITEM:AddQueryProxy("description", ITEM.QueryDescription);
ITEM:AddQueryProxy("category", ITEM.QueryCategory);
ITEM:AddQueryProxy("cost", ITEM.QueryCost);
ITEM:AddQueryProxy("weight", ITEM.QueryWeight);
ITEM:AddQueryProxy("quality", ITEM.QueryQuality);
ITEM:AddQueryProxy("color", ITEM.QueryColor);
ITEM:AddQueryProxy("ammoClass", ITEM.QueryammoClass);
ITEM:AddQueryProxy("ammoAmount", ITEM.QueryPrimaryammoAmount);

	
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
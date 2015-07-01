local PLUGIN = PLUGIN;

function PLUGIN:GenerateItem(player, model, name, description, category, baseCost, weight, quality, bMakeWeapon)
	local playerValid = false;
	if (player and player:IsPlayer() and player:IsValid()) then
		playerValid = true;
	end

	if (!model or !name or !description or !category) then
		ErrorNoHalt("GenerateItem failed running: Important arguments not filled"); return;
	end

	if ((!util.IsValidModel(model) and !bMakeWeapon)) then
		if (playerValid) then player:Notify("The model you typed doesn't exist on the server!"); else ErrorNoHalt("GenerateItem failed running: Invalid model"); end; return;
	end

	local base = "generated_item_base"; if (bMakeWeapon) then base = "generated_weapon_base"; end;
	local itemTable = Clockwork.item:CreateInstance(base);
	itemTable:SetData("model", model);
	itemTable:SetData("name", name);
	itemTable:SetData("description", description);
	itemTable:SetData("category", category);
	itemTable:SetData("cost", 50);
	itemTable:SetData("weight", 1);

	if (tonumber(baseCost)) then
		itemTable:SetData("cost", tonumber(baseCost));
	else
		if (playerValid) then player:Notify("No (or invalid) base cost was typed. Defaulting base cost to 50."); end;
	end

	if (tonumber(weight)) then
		itemTable:SetData("weight", tonumber(weight));
	else
		if (playerValid) then player:Notify("No (or invalid) weight was typed. Defaulting weight to 1."); end;
	end

	if (quality) then
		if (self:GetQualityTable(quality)) then
			itemTable:SetData("quality", quality);
		else
			if (playerValid) then player:Notify("The quality you typed isn't valid. Defaulting to Common."); end;
		end
	else
		if (playerValid) then player:Notify("No quality was typed. Defaulting quality to Common."); end;
	end

	return itemTable;
end

function PLUGIN:GenerateWeapon(player, weaponClass, model, name, description, category, baseCost, weight, quality, condition)
	local playerValid = false;
	local itemTable = self:GenerateItem(player, model, name, description, category, baseCost, weight, quality, true)
	if (!itemTable) then return; end;

	if (!weaponClass) then
		if (playerValid) then player:Notify("You didn't give a weapon class."); else ErrorNoHalt("GenerateWeapon failed running: No weapon class was given"); end; return;
	else
		local ent = ents.Create(weaponClass);
		if (IsValid(ent)) then
			ent:Remove();
		else
			if (playerValid) then player:Notify("Weapon class '"..weaponClass.."' is invalid."); else ErrorNoHalt("GenerateWeapon failed running: Invalid weapon class - "..weaponClass); end; return;
		end
	end
	itemTable:SetData("weaponClass", weaponClass);

	local weaponModel = self.weaponDefaultModels[weaponClass] or weapons.Get(weaponClass).WorldModel;
	if (string.lower(model) == "auto" and weaponModel) then
		itemTable:SetData("model", weaponModel);
	else
		if (playerValid) then player:Notify("There is no default model for "..weaponClass.."!"); else ErrorNoHalt("GenerateWeapon failed running: No default model for weapon - "..weaponClass); end; return;
	end

	return itemTable;
end
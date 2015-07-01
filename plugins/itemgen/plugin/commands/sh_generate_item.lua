local PLUGIN = PLUGIN;
local Clockwork = Clockwork;

local COMMAND = Clockwork.command:New("GenerateItem");
COMMAND.tip = "Generate a custom item at your position.";
COMMAND.text = "<string Model> <string Name> <string Description> <string Category> [number BaseCost] [number Weight] [number|string Quality]";
COMMAND.flags = bit.bor(CMD_DEFAULT, CMD_FALLENOVER);
COMMAND.arguments = 4;
COMMAND.optionalArguments = 3;
COMMAND.access = "s";

-- Called when the command has been run.
function COMMAND:OnRun(player, arguments)
	local model = arguments[1];
	local name = arguments[2];
	local description = arguments[3];
	local category = arguments[4];
	local baseCost = arguments[5];
	local weight = arguments[6];
	local quality = arguments[7];

	if (description) then description = string.Escape(description); end;

	local itemTable = PLUGIN:GenerateItem(player, model, name, description, category, baseCost, weight, quality);
	if (!itemTable) then
		return;
	end
	
	local trace = player:GetEyeTraceNoCursor();
	local entity = nil;

	if (player:GetShootPos():Distance(trace.HitPos) <= 192) then
		entity = Clockwork.entity:CreateItem(player, itemTable, trace.HitPos);
		if (IsValid(entity)) then
			Clockwork.entity:MakeFlushToGround(entity, trace.HitPos, trace.HitNormal);
		end;
	else
		Clockwork.player:Notify(player, "You cannot spawn this item that far away!");
	end;
end;

COMMAND:Register();
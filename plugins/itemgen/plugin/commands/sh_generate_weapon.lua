local PLUGIN = PLUGIN;
local Clockwork = Clockwork;

local COMMAND = Clockwork.command:New("GenerateWeapon");
COMMAND.tip = "Generate a custom weapon at your position.";
COMMAND.text = "<string WeaponClass> <string Model> <string Name> <string Description> <string Category> [number BaseCost] [number Weight] [number|string Quality] [number|string Condition]";
COMMAND.flags = bit.bor(CMD_DEFAULT, CMD_FALLENOVER);
COMMAND.arguments = 5;
COMMAND.optionalArguments = 4;
COMMAND.access = "s";

-- Called when the command has been run.
function COMMAND:OnRun(player, arguments)
	local weaponClass = arguments[1];
	local model = arguments[2];
	local name = arguments[3];
	local description = arguments[4];
	local category = arguments[5];
	local baseCost = arguments[6];
	local weight = arguments[7];
	local quality = arguments[8];
	local condition = arguments[9];

	if (description) then description = string.Escape(description); end;

	local itemTable = PLUGIN:GenerateWeapon(player, weaponClass, model, name, description, category, baseCost, weight, quality, condition);
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
		Clockwork.player:Notify(player, "You cannot spawn this weapon that far away!");
	end;
end;

COMMAND:Register();
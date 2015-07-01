local PLUGIN = PLUGIN;

local COMMAND = Clockwork.command:New("RadiationAreaRemove");
COMMAND.tip = "Remove an area contaminated by Radiation.";
COMMAND.flags = CMD_DEFAULT;
COMMAND.access = "s";

-- Called when the command has been run.
function COMMAND:OnRun(player, arguments)
	local position = player:GetEyeTraceNoCursor().HitPos;
	local removed = 0;
	
	for k, v in pairs(PLUGIN.radiationZones) do
		if (v.minimum:Distance(position) <= 256
		or v.maximum:Distance(position) <= 256
		or v.position:Distance(position) <= 256) then
			PLUGIN.radiationZones[k] = nil;
			
			removed = removed + 1;
		end;
	end;
	
	if (removed > 0) then
		if (removed == 1) then
			Clockwork.player:Notify(player, "You have removed "..removed.." radiation contaminated area.");
		else
			Clockwork.player:Notify(player, "You have removed "..removed.." radiation contaminated areas.");
		end;
		
		PLUGIN:SaveRadiationAreas();
	else
		Clockwork.player:Notify(player, "There were no radiation contaminated areas near this position.");
	end;
end;

COMMAND:Register();
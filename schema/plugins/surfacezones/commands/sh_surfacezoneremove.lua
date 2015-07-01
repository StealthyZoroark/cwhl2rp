local PLUGIN = PLUGIN;

local COMMAND = Clockwork.command:New("SurfaceZoneRemove");
COMMAND.tip = "Remove a surface zone.";
COMMAND.flags = CMD_DEFAULT;
COMMAND.access = "s";

-- Called when the command has been run.
function COMMAND:OnRun(player, arguments)
	local position = player:GetEyeTraceNoCursor().HitPos;
	local removed = 0;
	
	for k, v in pairs(PLUGIN.surfaceZones) do
		if (v.minimum:Distance(position) <= 256
		or v.maximum:Distance(position) <= 256
		or v.position:Distance(position) <= 256) then
			PLUGIN.surfaceZones[k] = nil;
			
			removed = removed + 1;
		end;
	end;
	
	if (removed > 0) then
		if (removed == 1) then
			Clockwork.player:Notify(player, "You have removed "..removed.." surface zone.");
		else
			Clockwork.player:Notify(player, "You have removed "..removed.." surface zones.");
		end;
		
		PLUGIN:SaveSurfaceZones();
	else
		Clockwork.player:Notify(player, "There were no surface zones near this position.");
	end;
end;

COMMAND:Register();
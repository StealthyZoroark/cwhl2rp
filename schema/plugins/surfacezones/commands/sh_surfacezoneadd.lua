local PLUGIN = PLUGIN;

local COMMAND = Clockwork.command:New("SurfaceZoneAdd");
COMMAND.tip = "Add a surface area that can hurt the player.";
COMMAND.flags = CMD_DEFAULT;
COMMAND.access = "s";

function COMMAND:OnRun(player, arguments)
	local areaPointData = player.areaPointData;
	local trace = player:GetEyeTraceNoCursor();
	
	if (!areaPointData) then
		player.areaPointData = {
			minimum = trace.HitPos
		};

		Clockwork.player:Notify(player, "You have added point A of the surface area, now add point B.");
	else
		areaPointData.maximum = trace.HitPos;
		
		local data = {
			minimum = areaPointData.minimum,
			maximum = areaPointData.maximum
		};
		
		PLUGIN.surfaceZones[#PLUGIN.surfaceZones + 1] = data;
		PLUGIN:SaveSurfaceZones();
		
		Clockwork.player:Notify(player, "You have added a surface zone.");
		
		player.areaPointData = nil;
	end;
end;

COMMAND:Register();
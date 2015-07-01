local PLUGIN = PLUGIN;

local COMMAND = Clockwork.command:New("RadiationAreaAdd");
COMMAND.tip = "Add an area contaiminated by Radiation.";
COMMAND.flags = CMD_DEFAULT;
COMMAND.access = "s";

function COMMAND:OnRun(player, arguments)
	local areaPointData = player.areaPointData;
	local trace = player:GetEyeTraceNoCursor();
	
	if (!areaPointData) then
		player.areaPointData = {
			minimum = trace.HitPos
		};

		Clockwork.player:Notify(player, "You have added the minimum radiation point, now add the maximum radiation point.");
	else
		areaPointData.maximum = trace.HitPos;
		
		local data = {
			minimum = areaPointData.minimum,
			maximum = areaPointData.maximum
		};
		
		PLUGIN.radiationZones[#PLUGIN.radiationZones + 1] = data;
		PLUGIN:SaveRadiationAreas();
		
		Clockwork.player:Notify(player, "You have added a radio-active area.");
		
		player.areaPointData = nil;
	end;
end;

COMMAND:Register();
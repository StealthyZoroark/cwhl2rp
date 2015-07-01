--[[
	Name: sh_info.lua.
	Author: TJjokerR.
--]]

local PLUGIN = PLUGIN;

-- A function to load the area names.
function PLUGIN:LoadRadiationAreas()
	self.radiationZones = Clockwork.kernel:RestoreSchemaData( "plugins/radiationzones/"..game.GetMap() );
end;

-- A function to save the area names.
function PLUGIN:SaveRadiationAreas()
	Clockwork.kernel:SaveSchemaData("plugins/radiationzones/"..game.GetMap(), self.radiationZones);
end;


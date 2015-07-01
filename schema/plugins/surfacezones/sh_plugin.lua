--[[
	Name: sh_auto.lua.
	Author: LauScript.
--]]

local PLUGIN = PLUGIN;

PLUGIN.surfaceZones = {};

Clockwork.kernel:IncludePrefixed("sv_hooks.lua");
Clockwork.kernel:IncludePrefixed("sv_plugin.lua");
Clockwork.kernel:IncludePrefixed("cl_hooks.lua");
Clockwork.kernel:IncludePrefixed("cl_plugin.lua");
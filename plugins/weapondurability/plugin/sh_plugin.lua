PLUGIN:SetGlobalAlias("cwDurableWeapons");

Clockwork.kernel:IncludePrefixed("sv_plugin.lua");
Clockwork.kernel:IncludePrefixed("sv_hooks.lua");
Clockwork.kernel:IncludePrefixed("sh_hooks.lua");
Clockwork.kernel:IncludePrefixed("cl_hooks.lua");

if (CLIENT) then
	Clockwork.config:AddToSystem("Durability Decrease Scale", "durability_decrease_scale", "The higher the number, the quicker weapons will lose durability.", 0, 4, 3);
end;
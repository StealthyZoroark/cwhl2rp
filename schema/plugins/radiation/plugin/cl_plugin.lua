--[[
	Name: cl_auto.lua.
	Author: LauScript.
--]]

local PLUGIN = PLUGIN;

-- Called when screen space effects should be rendered.
function PLUGIN:RenderScreenspaceEffects()
	local radiation = Clockwork.Client:GetSharedVar("radiation");
	
	if(radiation)then
		if(radiation >= 75 and radiation < 85)then
			DrawMotionBlur(0.8, 0.79, 0.05);
		elseif(radiation > 85)then
			DrawMotionBlur(0.1, 0.79, 0.05);
		end;
	end;
end;
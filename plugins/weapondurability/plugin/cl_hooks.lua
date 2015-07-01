local PLUGIN = PLUGIN;

function PLUGIN:GetProgressBarInfo()
	local action, percentage = Clockwork.player:GetAction(Clockwork.Client, true);

	if (!Clockwork.Client:IsRagdolled()) then
		if (action == "weapon_repairing") then
			return {text = "Repairing weapon...", percentage = percentage, flash = percentage < 10};
		end;
		if (action == "weapon_upgrading") then
			return {text = "Upgrading weapon...", percentage = percentage, flash = percentage < 10};
		end;
	end;
end;
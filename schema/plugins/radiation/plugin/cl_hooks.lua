local PLUGIN = PLUGIN;

function PLUGIN:GetPlayerInfoText(playerInfoText)
	local rads = Clockwork.Client:GetSharedVar("radiation");
	if (rads) then
		playerInfoText:Add("RAD", "Radiation Level: "..rads);
	end;
end;

-- Called when the bars are needed.
function PLUGIN:GetBars(bars)
	local radiation = Clockwork.Client:GetSharedVar("radiation");
	
	if (!self.radiation) then
		self.radiation = radiation;
	else
		self.radiation = math.Approach(self.radiation, radiation, 1);
	end;
	
	if (self.radiation > 1) then
		bars:Add("RADIATION", Color(182, 216, 0, 255), "Radiation", self.radiation, 100, self.radiation > 25, 1);
	end;
end;
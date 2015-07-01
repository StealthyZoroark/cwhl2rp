local Clockwork = Clockwork;
local vgui = vgui;

local PANEL = {};

function PANEL:OnCursorEntered()	
	Clockwork.option:PlaySound("metro_hover");
	DLabel.ApplySchemeSettings(self);
end;

vgui.Register("cwMetroButton", PANEL, "cwLabelButton");
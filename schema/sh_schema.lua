--[[
	� 2012 CloudSixteen.com do not share, re-distribute or modify
	without permission of its author (kurozael@gmail.com).
--]]

Clockwork.option:SetKey( "default_date", {month = 8, year = 2033, day = 22} );
Clockwork.option:SetKey( "default_time", {minute = 0, hour = 12, day = 1} );
Clockwork.option:SetKey("description_business", "Buy and sell bullets for other equipment.");
Clockwork.option:SetKey("format_singular_cash", "%a");
Clockwork.option:SetKey("model_shipment", "models/props_junk/cardboard_box003b.mdl");
Clockwork.option:SetKey("name_business", "Business");
Clockwork.option:SetKey("intro_image", "newvegas/Metro2033");
Clockwork.option:SetKey("model_cash", "models/props_lab/box01a.mdl");
Clockwork.option:SetKey("menu_music", "metro2033.mp3");
Clockwork.option:SetKey("format_cash", "%a %n");
Clockwork.option:SetKey("name_cash", "Bullets");
Clockwork.option:SetKey("gradient", "newvegas/bg_gradient");

Clockwork.attribute:FindByID("Stamina").isOnCharScreen = false;

if (CLIENT) then
	Clockwork.option:SetColor("information", Color(250, 170, 0, 255));
	Clockwork.option:SetFont("bar_text", "veg_TargetIDText");
	Clockwork.option:SetFont("main_text", "veg_MainText");
	Clockwork.option:SetFont("hints_text", "veg_IntroTextTiny");
	Clockwork.option:SetFont("large_3d_2d", "veg_Large3D2D");
	Clockwork.option:SetFont("target_id_text", "veg_TargetIDText");
	Clockwork.option:SetFont("cinematic_text", "veg_CinematicText");
	Clockwork.option:SetFont("date_time_text", "veg_IntroTextSmall");
	Clockwork.option:SetFont("menu_text_big", "veg_MenuTextBig");
	Clockwork.option:SetFont("menu_text_huge", "veg_MenuTextHuge");
	Clockwork.option:SetFont("menu_text_tiny", "veg_IntroTextTiny");
	Clockwork.option:SetFont("intro_text_big", "veg_IntroTextBig");
	Clockwork.option:SetFont("menu_text_small", "veg_IntroTextSmall");
	Clockwork.option:SetFont("intro_text_tiny", "veg_IntroTextTiny");
	Clockwork.option:SetFont("intro_text_small", "veg_IntroTextSmall");
	Clockwork.option:SetFont("player_info_text", "veg_PlayerInfoText");
end;

-- A function to modify a physical description.
function Clockwork.kernel:ModifyPhysDesc(description)
	if ( string.find(description, "|") ) then
		description = string.gsub(description, "|", "/");
	end;
	
	if (string.len(description) <= 128) then
		if ( !string.find(string.sub(description, -2), "%p") ) then
			return description..".";
		else
			return description;
		end;
	else
		return string.sub(description, 1, 125).."...";
	end;
end;

Clockwork.kernel:IncludePrefixed("cl_schema.lua");
Clockwork.kernel:IncludePrefixed("cl_hooks.lua");
Clockwork.kernel:IncludePrefixed("sh_hooks.lua");
Clockwork.kernel:IncludePrefixed("sv_schema.lua");
Clockwork.kernel:IncludePrefixed("sv_hooks.lua");

Clockwork.flag:Add("T", "Business", "Access to trade equipment for bullets.");


Clockwork.quiz:SetEnabled(true);
Clockwork.quiz:AddQuestion("Do you understand that roleplaying is slow paced and relaxed?", 1, "Yes.", "No.");
Clockwork.quiz:AddQuestion("Can you type properly, using capital letters and full-stops?", 2, "yes i can", "Yes, I can.");
Clockwork.quiz:AddQuestion("You do know that this is not DarkRP and you will not get a gun instantly?", 1, "Yes.", "No.");
Clockwork.quiz:AddQuestion("You do not need items to roleplay, do you understand?", 1, "Yes.", "No.");
Clockwork.quiz:AddQuestion("What do you think serious roleplaying is about?", 2, "Collecting items and upgrades.", "Developing your character.");
Clockwork.quiz:AddQuestion("What universe is this roleplaying game set in?", 2, "S.T.A.L.K.E.R.", "Metro 2033");
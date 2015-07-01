local ITEM = Clockwork.item:New();
ITEM.name = "Radaway";
ITEM.uniqueID = "radaway";
ITEM.cost = 35;
ITEM.model = "models/props_junk/garbage_plasticbottle002a.mdl";
ITEM.weight = 0.5;
ITEM.useText = "Drink";
ITEM.category = "Medical";
ITEM.access = "v";
ITEM.business = true;
ITEM.description = "A small bottle of a liquid developed before the war.\n'Radaway, removing those Pesky Rads' is written on the side.";

-- Called when a player uses the item.
function ITEM:OnUse(player, itemEntity)
	player:SetCharacterData( "radiation", math.Clamp(player:GetCharacterData("radiation") - 40, 0, 100) );
end;

-- Called when a player drops the item.
function ITEM:OnDrop(player, position) end;

ITEM:Register(ITEM);
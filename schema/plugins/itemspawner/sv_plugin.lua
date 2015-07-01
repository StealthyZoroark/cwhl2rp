local PLUGIN = PLUGIN;

-- A function to load the item spawns.
function PLUGIN:LoadItemSpawns()
	self.itemSpawns = Clockwork.kernel:RestoreSchemaData( "plugins/itemspawns/"..game.GetMap() );
	
	if (!self.itemSpawns) then
		self.itemSpawns = {};
	end;
end;

-- A function to save the item spawns.
function PLUGIN:SaveItemSpawns()
	Clockwork.kernel:SaveSchemaData("plugins/itemspawns/"..game.GetMap(), self.itemSpawns);
end;

-- A function to get a random item spawn.
function PLUGIN:GetRandomItemSpawn()
	local position = PLUGIN.itemSpawns[ math.random(1, #PLUGIN.itemSpawns) ];
	local entities = ents.GetAll();
	local players = _player.GetAll();
	
	-- If a player is too close to the item spawn, it will select a different item spawn.
	for k, v in pairs(players) do
		if (v:HasInitialized() and (v:GetPos():Distance(position) <= 256 and !v:IsNoClipping()) ) then
			return PLUGIN:GetRandomItemSpawn();
		end;
	end;
	
	-- If an item is already at the item spawn, it is deleted and a new item takes its place.
	for k, v in pairs(entities) do
		if (v:GetClass() == "cw_item") then
			if (v:GetPos():Distance(position) <= 50) then
				v:Remove();
			end;
		end;
	end;
	
	return position;
end;

-- A function to get a random item.
function PLUGIN:GetRandomItem()
	local Item = PLUGIN.Items[ math.random(1, #PLUGIN.Items) ];
	local randomNumber = math.random(os.time());
	
	if ( Item.value <= randomNumber ) then
		return Item;
	else
		return PLUGIN:GetRandomItem();
	end;
end;
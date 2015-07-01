local PLUGIN = PLUGIN;

-- Called when Clockwork has loaded all of the entities.
function PLUGIN:ClockworkInitPostEntity()
	PLUGIN.Items = {};
	for k, v in pairs( Clockwork.item:GetAll() ) do
		if (!v.isBaseItem and (v.value != nil) ) then
			PLUGIN.Items[#PLUGIN.Items + 1] = v;
		end;
	end;
	
	PLUGIN:LoadItemSpawns();
end;

-- Called just after data should be saved.
function PLUGIN:PostSaveData()
	PLUGIN:SaveItemSpawns();
end;

-- Called each tick.
function PLUGIN:Tick()
	local curTime = CurTime();
	local maximumSpawns = #PLUGIN.itemSpawns;
	
	if (!self.nextItemSpawn) then
		
		-- This is the amount (in seconds) between random item spawns.
		self.nextItemSpawn = curTime + math.random(3600, 7200);
	end;
	
	if (curTime >= self.nextItemSpawn and #PLUGIN.itemSpawns > 0) then
		self.nextItemSpawn = nil;
		
		local Item = PLUGIN:GetRandomItem();
		local position = PLUGIN:GetRandomItemSpawn();
		Clockwork.entity:CreateItem(nil, Item.uniqueID, position);
	end;
end;
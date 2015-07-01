function cwDurableWeapons:EntityFireBullets(entity, bulletInfo, player, event, data)

	

	if (entity:IsPlayer()) then
		entity = entity:GetActiveWeapon();
	end;
		
		if (entity and entity:IsWeapon()) then
			local itemTable = Clockwork.item:GetByWeapon(entity);
			
			if (itemTable) then
				originalDamage = bulletInfo.Damage;
				durability = itemTable:GetData("Durability");
				condition = itemTable:GetData("Condition");
				hasFlashlight = itemTable:GetData("hasFlashlight");
				drainScale = 100 * Clockwork.config:Get("durability_decrease_scale"):Get();
					
					bulletInfo.Damage = (originalDamage / 100) * durability;
					bulletInfo.Spread = bulletInfo.Spread * (1 + (1 - ((1 / 100) * durability)));
				
					itemTable:SetData("Durability", math.max(durability - (originalDamage / drainScale), 0));
				
				if (durability >= 80) then
					itemTable:SetData("Condition", "Factory New", 0)
				elseif (durability >= 60) then
					itemTable:SetData("Condition", "Minimal Wear", 0)
				elseif (durability >= 40) then
					itemTable:SetData("Condition", "Field Tested", 0)
				elseif (durability >= 1) then
					itemTable:SetData("Condition", "Battle Scarred", 0)
				else
					
					itemTable:SetData("Condition", "Broken", 0)
					itemTable:SetData("isBroken", true, 0)
					
					
					end
				end
				
				if (durability < 1) then
					Clockwork.player:Notify(player, "Your weapon will not shoot while broken!")
					entity:CanPrimaryAttack(false)
					return false
				end
			end;
		end;
		

function cwDurableWeapons:PlayerCanUseItem(player, itemTable, noMessage)

	if (Clockwork.item:IsWeapon(itemTable) and !itemTable:IsFakeWeapon()) then
		local secondaryWeapon;
		local primaryWeapon;
		local sideWeapon;
		local fault;
		
		
		for k, v in ipairs( player:GetWeapons() ) do
			local weaponTable = Clockwork.item:GetByWeapon(v);
			
			if (weaponTable and !weaponTable:IsFakeWeapon()) then
				if (weaponTable("weight") >= 1) then
					if (weaponTable("weight") <= 2) then
						secondaryWeapon = true;
					else
						primaryWeapon = true;
					end;
				else
					sideWeapon = true;
				end;
			end;
		end;
		
		if (itemTable("weight") >= 1) then
			if (itemTable("weight") <= 2) then
				if (secondaryWeapon) then
					fault = "You cannot use another secondary weapon!";
				end;
			elseif (primaryWeapon) then
				fault = "You cannot use another primary weapon!";
			end;
		elseif (sideWeapon) then
			fault = "You cannot use another melee weapon!";
		end;
		
		if(itemTable("isBroken") == true) then
			fault = "You cannot equip a broken weapon!";
		end
		
		
		
		if (fault) then
			if (!noMessage) then
				Clockwork.player:Notify(player, fault);
			end;
			
			return false;
		end;
	end;
end;

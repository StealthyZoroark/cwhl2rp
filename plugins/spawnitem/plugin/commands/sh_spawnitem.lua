local Clockwork = Clockwork;

local COMMAND = Clockwork.command:New("Spawnitem");
COMMAND.tip = "Spawn an item where you are looking.";
COMMAND.text = "<string Item>";
COMMAND.access = "s";
COMMAND.arguments = 1;

-- Called when the command has been run.
function COMMAND:OnRun(player, arguments)
	
	if (Clockwork.player:HasFlags(player, "G")) then
		local itemTable = Clockwork.item:FindByID(arguments[1]);
				
				if (itemTable and !itemTable.isBaseItem) then
					local trace = player:GetEyeTraceNoCursor();
					
					if (player:GetShootPos():Distance(trace.HitPos) <= 192) then
						local itemTable = Clockwork.item:CreateInstance(itemTable("uniqueID"));
						local entity = Clockwork.entity:CreateItem(player, itemTable, trace.HitPos);
						
						if (IsValid(entity)) then
							Clockwork.entity:MakeFlushToGround(entity, trace.HitPos, trace.HitNormal);
						end;
					else
						Clockwork.player:Notify(player, "You cannot drop your weapon that far away!");
					end;
			
			
				else
					Clockwork.player:Notify(player, "This is not a valid item!");
				end;
	else
		Clockwork.player:Notify(player, "I'm sorry, it seems like you cannot be trusted with this command!");
	end;

	
	
	
end;

COMMAND:Register();
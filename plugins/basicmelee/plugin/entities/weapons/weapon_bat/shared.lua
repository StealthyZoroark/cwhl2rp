--[[
	© 2013 CloudSixteen.com do not share, re-distribute or modify
	without permission of its author (kurozael@gmail.com).
--]]

if (SERVER) then
	AddCSLuaFile("shared.lua");
	
	Clockwork.kernel:AddFile("materials/models/weapons/sledge.vmt");
	Clockwork.kernel:AddFile("materials/models/weapons/sledge.vtf");
	
	Clockwork.kernel:AddFile("models/weapons/v_sledgehammer/v_sledgehammer.dx80.vtx");
	Clockwork.kernel:AddFile("models/weapons/v_sledgehammer/v_sledgehammer.dx90.vtx");
	Clockwork.kernel:AddFile("models/weapons/v_sledgehammer/v_sledgehammer.sw.vtx");
	Clockwork.kernel:AddFile("models/weapons/v_sledgehammer/v_sledgehammer.mdl");
	Clockwork.kernel:AddFile("models/weapons/v_stunstick.phy");
	Clockwork.kernel:AddFile("models/weapons/v_sledgehammer/v_sledgehammer.vvd");
end;

if (CLIENT) then
	SWEP.Slot = 0;
	SWEP.SlotPos = 5;
	SWEP.DrawAmmo = false;
	SWEP.PrintName = "Bat";
	SWEP.DrawCrosshair = true;
end

function SWEP:Precache()

    	util.PrecacheSound("weapons/knife/knife_slash1.wav")
    	util.PrecacheSound("weapons/knife/knife_hitwall1.wav")
    	util.PrecacheSound("weapons/knife/knife_deploy1.wav")
    	util.PrecacheSound("weapons/knife/knife_hit1.wav")
    	util.PrecacheSound("weapons/knife/knife_hit2.wav")
    	util.PrecacheSound("weapons/knife/knife_hit3.wav")
    	util.PrecacheSound("weapons/knife/knife_hit4.wav")
end

SWEP.Instructions = "Primary Fire: Swing.";
SWEP.Purpose = "A strong, metal blunt weapon.";
SWEP.Contact = "";
SWEP.Author	= "Starlox";

SWEP.WorldModel = "models/weapons/w_basball.mdl";
SWEP.ViewModel = "models/weapons/v_basball.mdl";
SWEP.HoldType = "melee";

SWEP.AdminSpawnable = true;
SWEP.Spawnable = false;
  
SWEP.Primary.DefaultClip = 0;
SWEP.Primary.Automatic = false;
SWEP.Primary.ClipSize = -1;
SWEP.Primary.Damage = 35;
SWEP.Primary.Delay = 1;
SWEP.Primary.Ammo = "";

SWEP.Secondary.NeverRaised = true;
SWEP.Secondary.DefaultClip = 0;
SWEP.Secondary.Automatic = false;
SWEP.Secondary.ClipSize = -1;
SWEP.Secondary.Delay = 1;
SWEP.Secondary.Ammo	= "";

SWEP.NoIronSightFovChange = true;
SWEP.NoIronSightAttack = true;
SWEP.IronSightPos = Vector(0, 0, 0);
SWEP.IronSightAng = Vector(0, 0, 0);

-- Called when the SWEP is deployed.
function SWEP:Deploy()
	self:SendWeaponAnim(ACT_VM_DRAW);
end;

-- Called when the SWEP is holstered.
function SWEP:Holster(switchingTo)
	self:SendWeaponAnim(ACT_VM_HOLSTER);
	
	return true;
end;

-- Called when the SWEP is initialized.
function SWEP:Initialize()
	self:SetWeaponHoldType(self.HoldType);
end;

-- A function to play the knock sound.
function SWEP:PlayKnockSound()
	if (SERVER) then
		self:CallOnClient("PlayKnockSound", "");
	end;
	
	self:EmitSound("physics/wood/wood_crate_impact_hard2.wav");
end;

-- A function to do the SWEP's hit effects.
function SWEP:DoHitEffects()
	local trace = self.Owner:GetEyeTraceNoCursor();
	
	if (( (trace.Hit or trace.HitWorld) and self.Owner:GetPos():Distance(trace.HitPos) <= 96 )) then
		
		if (IsValid(trace.Entity) and ( trace.Entity:IsPlayer() or trace.Entity:IsNPC() )) then
			self:SendWeaponAnim(ACT_VM_MISSCENTER);
			self:EmitSound("weapons/knife/knife_hit"..math.random(1, 4)..".wav");
		elseif (IsValid(trace.Entity) and Clockwork.entity:GetPlayer(trace.Entity)) then
			self:SendWeaponAnim(ACT_VM_MISSCENTER);
			self:EmitSound("weapons/knife/knife_hit"..math.random(1, 4)..".wav");
		else
			self:SendWeaponAnim(ACT_VM_MISSCENTER);
			self:EmitSound("weapons/knife/knife_hit"..math.random(1, 4)..".wav");
		end;
		
		local effectData = EffectData();
		
		effectData:SetStart(trace.HitPos);
		effectData:SetOrigin(trace.HitPos);
		effectData:SetNormal(trace.HitNormal);
		
		if (IsValid(trace.Entity)) then
			effectData:SetEntity(trace.Entity);
		end;
	else
		self:SendWeaponAnim(ACT_VM_MISSCENTER);
		self:EmitSound("weapons/knife/knife_slash1.wav");
	end;
end;

-- Called when the weapon is lowered.
function SWEP:OnLowered()
	
	if (SERVER) then
		self:CallOnClient("OnLowered", "");
		
	end;
end;

-- Called when the weapon is raised.
function SWEP:OnRaised()
	self:EmitSound("weapons/knife/knife_deploy1.wav");
	
	if (SERVER) then
		self:CallOnClient("OnRaised", "");
		
	end;
end;

-- Called when the world model is drawn.
function SWEP:DrawWorldModel()
	self:DrawModel();
	
	if (Clockwork.player:GetWeaponRaised(self.Owner)) then
		
	end;
end;

-- Called when the view model is drawn.
function SWEP:ViewModelDrawn()
	if (Clockwork.player:GetWeaponRaised(self.Owner)) then
		if (self:IsCarriedByLocalPlayer()) then
			local viewModel = Clockwork.Client:GetViewModel();
			
			if (IsValid(viewModel)) then
				local curTime = CurTime();
				local scale = math.abs(math.sin(curTime) * 4);
				local alpha = math.abs(math.sin(curTime) / 4);
				-- local i;
				
			end;
		end;
	end;
end;

-- A function to do the SWEP's animations.
function SWEP:DoAnimations(idle)
	if (!idle) then
		self.Owner:SetAnimation(PLAYER_ATTACK1);
	end;
end;



-- Called when the player attempts to primary fire.
function SWEP:PrimaryAttack(player)

	self:SetNextPrimaryFire(CurTime() + self.Primary.Delay);
	self:SetNextSecondaryFire(CurTime() + self.Primary.Delay);
	
	self:DoAnimations(); self:DoHitEffects();
	
	if (SERVER) then
		if (self.Owner.LagCompensation) then
			self.Owner:LagCompensation(true);
		end;
		
		local trace = self.Owner:GetEyeTraceNoCursor();
		local bounds = Vector(0, 0, 0);
		local startPosition = self.Owner:GetShootPos();
		local finishPosition = startPosition + (self.Owner:GetAimVector() * 96);
		
		if (self.Owner:GetShootPos():Distance(trace.HitPos) <= 96) then
			if (IsValid(trace.Entity)) then
				local player = Clockwork.entity:GetPlayer(trace.Entity);
				local strength = Clockwork.attributes:Fraction(self.Owner, 100, 3, 1.5); --10=strength
				
				if (trace.Entity:IsPlayer()) then
					local normal = ( trace.Entity:GetPos() - self.Owner:GetPos() ):GetNormal();
					local push = 128 * normal;
					
					trace.Entity:SetVelocity(push);
					
						trace.Entity:TakeDamageInfo( Clockwork.kernel:FakeDamageInfo(self.Primary.Damage, self, self.Owner, trace.HitPos, DMG_CLUB, 2) );
						
				elseif (IsValid( trace.Entity:GetPhysicsObject() )) then
					trace.Entity:GetPhysicsObject():ApplyForceOffset(self.Owner:GetAimVector() * 256, trace.HitPos);
					
					if (!player or player:Health() > 10) then
						if (!player) then
							trace.Entity:TakeDamageInfo( Clockwork.kernel:FakeDamageInfo(self.Primary.Damage, self, self.Owner, trace.HitPos, DMG_CLUB, 2) );
						else
							trace.Entity:TakeDamageInfo( Clockwork.kernel:FakeDamageInfo(self.Primary.Damage, self, self.Owner, trace.HitPos, DMG_CLUB, 2) );
						end;
					end;
					
				end;
			end;
		end;
		
		if (self.Owner.LagCompensation) then
			self.Owner:LagCompensation(false);
		end;
	end;
end;

-- Called when the player attempts to secondary fire.
function SWEP:SecondaryAttack()
end;
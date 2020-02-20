SWEP.PrintName = "Diddeler" -- The name of the weapon
    
SWEP.Author = "chubl."
SWEP.Category = "weapons" --This is required or else your weapon will be placed under "Other"

SWEP.Spawnable= true --Must be true
SWEP.AdminOnly = false

SWEP.Base = "weapon_base"

--Primary Attack
local ShootSound = Sound("Weapon_Pistol.Single")
SWEP.Primary.Damage = 15 --The amount of damage will the weapon do
SWEP.Primary.TakeAmmo = 1 -- How much ammo will be taken per shot
SWEP.Primary.ClipSize = 8  -- How much bullets are in the mag
SWEP.Primary.Ammo = "Pistol" --The ammo type will it use
SWEP.Primary.DefaultClip = 8 -- How much bullets preloaded when spawned
SWEP.Primary.Spread = 0.1 -- The spread when shot
SWEP.Primary.NumberofShots = 1 -- Number of bullets when shot
SWEP.Primary.Automatic = false -- Is it automatic
SWEP.Primary.Recoil = .2 -- The amount of recoil
SWEP.Primary.Delay = 0.035 -- Delay before the next shot
SWEP.Primary.Force = 100

--Secondary Attack (Even if you don't use one)
SWEP.Secondary.ClipSize		= -1
SWEP.Secondary.DefaultClip	= -1
SWEP.Secondary.Automatic	= false
SWEP.Secondary.Ammo		= "none"

SWEP.Slot = 2 --What weapon hotbar it will be placed in
SWEP.SlotPos = 1 --What place the weapon is inside the hotbar
SWEP.DrawCrosshair = true --Does it draw the crosshair
SWEP.DrawAmmo = true
SWEP.Weight = 5 --Priority when the weapon your currently holding drops
SWEP.AutoSwitchTo = false
SWEP.AutoSwitchFrom = false

--Model
SWEP.ViewModelFlip		= false
SWEP.ViewModelFOV		= 90
SWEP.ViewModel			= "models/weapons/c_pistol.mdl"
SWEP.WorldModel			= "models/weapons/w_pistol.mdl"
SWEP.UseHands           = true

SWEP.HoldType = "Pistol" 

SWEP.FiresUnderwater = false

SWEP.ReloadSound = "sound/epicreload.wav"

SWEP.CSMuzzleFlashes = false

--Initializing the code
function SWEP:Initialize()
    util.PrecacheSound(ShootSound) 
    util.PrecacheSound(self.ReloadSound) 
    self:SetWeaponHoldType( self.HoldType )
    end

--Primary Attack Function
function SWEP:PrimaryAttack()
 
    if ( !self:CanPrimaryAttack() ) then return end
     
    local bullet = {} 
    bullet.Num = self.Primary.NumberofShots 
    bullet.Src = self.Owner:GetShootPos() 
    bullet.Dir = self.Owner:GetAimVector() 
    bullet.Spread = Vector( self.Primary.Spread * 0.1 , self.Primary.Spread * 0.1, 0)
    bullet.Tracer = 1
    bullet.Force = self.Primary.Force 
    bullet.Damage = self.Primary.Damage 
    bullet.AmmoType = self.Primary.Ammo 
     
    local rnda = self.Primary.Recoil * -1 
    local rndb = self.Primary.Recoil * math.random(-1, 1) 
     
    self:ShootEffects()
     
    self.Owner:FireBullets( bullet ) 
    self:EmitSound(ShootSound)
    self.Owner:ViewPunch( Angle( rnda,rndb,rnda ) ) 
    self:TakePrimaryAmmo(self.Primary.TakeAmmo) 
     
    self:SetNextPrimaryFire( CurTime() + self.Primary.Delay ) 
    end 

--Secondary Attack Function
function SWEP:SecondaryAttack()

end

--Reloading
function SWEP:Reload()
    self:EmitSound(Sound(self.ReloadSound)) 
            self.Weapon:DefaultReload( ACT_VM_RELOAD );
    end
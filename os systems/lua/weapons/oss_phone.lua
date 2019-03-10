--[[-------------------------------------------------------------------------
It will added later, when I'll have enough time
---------------------------------------------------------------------------]]

--[[SWEP.Author = "DangerKiddy"
SWEP.PrintName = "iPhone X"
SWEP.Contact = ""
SWEP.Purpose = ""
SWEP.Instructions = ""
SWEP.Category = "OSS weapons"

 
SWEP.Spawnable			= true
SWEP.AdminSpawnable		= false
 
SWEP.ViewModel			= "models/dk_props/iphonex/ipx.mdl"
SWEP.WorldModel		= "models/dk_props/iphonex/ipx.mdl"
 
SWEP.Primary.ClipSize		= -1
SWEP.Primary.DefaultClip	= -1
SWEP.Primary.Automatic		= false
SWEP.Primary.Ammo		= "none"
 
SWEP.Secondary.ClipSize	= -1
SWEP.Secondary.DefaultClip	= -1
SWEP.Secondary.Automatic	= false
SWEP.Secondary.Ammo		= "none"


function SWEP:Initialize()
	self:SetHoldType("slam")
end
function SWEP:Reload()
end

function SWEP:Think()	
end

function SWEP:PrimaryAttack()
end
 
function SWEP:SecondaryAttack()
end

function SWEP:GetViewModelPosition( position, angle )
	local owner = self.Owner

	if ( IsValid( owner ) ) then
		if self:GetNWBool("OSSPH_Mode",false) then
			local topos = (position + owner:GetRight()*-.1 + owner:GetAimVector()*10 - owner:GetUp()*1)
			position = topos
		else
			position = position + owner:GetRight()*7 + owner:GetAimVector()*13 - owner:GetUp()*2.8
		end
	end

	angle:RotateAroundAxis( angle:Up(), 0 )
	angle:RotateAroundAxis( angle:Right(), 0 )
	angle:RotateAroundAxis( angle:Forward(), 0 )

	return position, angle
end

if CLIENT then
	local WorldModel = ClientsideModel( SWEP.WorldModel )

	-- Settings...
	WorldModel:SetSkin( 1 )
	WorldModel:SetNoDraw( true )

	function SWEP:DrawWorldModel()
		local _Owner = self:GetOwner()

		if ( IsValid( _Owner ) ) then
			local offsetVec = Vector( 4, -2.5, 0 )
			local offsetAng = Angle( 180, -120, 0 )

			local boneid = _Owner:LookupBone( "ValveBiped.Bip01_R_Hand" )
			if !boneid then return end

			local matrix = _Owner:GetBoneMatrix( boneid )
			if !matrix then return end

			local newPos, newAng = LocalToWorld( offsetVec, offsetAng, matrix:GetTranslation(), matrix:GetAngles() )

			WorldModel:SetPos( newPos )
			WorldModel:SetAngles( newAng )

			WorldModel:SetupBones()
		else
			WorldModel:SetPos( self:GetPos() )
			WorldModel:SetAngles( self:GetAngles() )
		end

		WorldModel:DrawModel()
	end
end]]
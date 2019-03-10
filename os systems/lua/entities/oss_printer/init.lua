
	--[[-------------------------------------------------------------------------
	Heya, if you here to find something, don't do it!
	Better will ask me in steam about that: https://steamcommunity.com/id/DangerKiddy/

	Copyright @ 2019-2026 OSS
	Creator: DangerKiddy ( https://steamcommunity.com/id/DangerKiddy/ )
	---------------------------------------------------------------------------]]

AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )
include('shared.lua')

	function ENT:Initialize()
		self:SetModel( self.Model )
		self:PhysicsInit( SOLID_VPHYSICS )
		self:SetMoveType( MOVETYPE_VPHYSICS )
		self:SetSolid( SOLID_VPHYSICS )
		self:SetUseType(SIMPLE_USE)

		local phys = self:GetPhysicsObject()
		if not IsValid( phys ) then return end
		phys:SetMass(self.Mass or 10)
		phys:EnableMotion( true )
		phys:Wake()
		
		self:DrawShadow(false)
		self:SetNoDraw(false)
	end
	
	function ENT:SpawnFunction( ply, tr, ClassName )

		if ( !tr.Hit ) then return end

		local SpawnPos = tr.HitPos + tr.HitNormal * 1

		local ent = ents.Create( ClassName )
		ent:SetPos( SpawnPos )
		ent:Spawn()


		return ent
	end

function ENT:Print(text, image)
	if self:GetNWBool("OSS_Printing", false) then return end
	if text then
		local time = string.len(text)/10
		self:SetNWBool("OSS_Printing",true)
		timer.Simple(3, function()
			self:SetNWBool("OSS_Printing",false)
			local paper = ents.Create("oss_printedpaper")
			paper:SetPos(self:GetPos()+Vector(0,0,20))
			paper:Spawn()
			paper:SetNWString("OSS_PaperText", text)
		end)
	elseif image then
		local time = string.len(image)/10
		self:SetNWBool("OSS_Printing",true)
		timer.Simple(time, function()
			self:SetNWBool("OSS_Printing",false)
			local paper = ents.Create("oss_printedpaper")
			paper:SetPos(self:GetPos()+Vector(0,0,20))
			paper:Spawn()
			paper:SetNWString("OSS_PaperURL", image)
		end)
	end
end

function ENT:Think()
	if self:GetNWBool("OSS_Printing",false) then
		local effectdata = EffectData()
		effectdata:SetOrigin( self:GetPos() )
		util.Effect( "StunstickImpact", effectdata )
	end
end
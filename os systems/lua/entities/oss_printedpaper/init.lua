
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
	util.AddNetworkString("OSS_Paper_Open")
	function ENT:Use(ply)
		if not ply:IsPlayer() then return end

		net.Start("OSS_Paper_Open")
			net.WriteEntity(self)
		net.Send(ply)
	end
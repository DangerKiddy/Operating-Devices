
	--[[-------------------------------------------------------------------------
	Heya, if you here to find something, don't do it!
	Better will ask me in steam about that: https://steamcommunity.com/id/DangerKiddy/

	Copyright @ 2019-2026 OSS
	Creator: DangerKiddy ( https://steamcommunity.com/id/DangerKiddy/ )
	---------------------------------------------------------------------------]]

AddCSLuaFile()

ENT.Type	= "anim"
ENT.PrintName	= "Keyboard"
ENT.Category	= "OSS Entities"
ENT.Model = "models/props_c17/computer01_keyboard.mdl"

ENT.Spawnable = true
ENT.AdminOnly = false
ENT.OSS_IsKeyboard = true
ENT.ConnectPos = Vector(-3.2, 8.6, 2.4)

if SERVER then
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

		local SpawnPos = tr.HitPos + tr.HitNormal * 15

		local ent = ents.Create( ClassName )
		ent:SetPos( SpawnPos )
		ent:Spawn()

		return ent
	end
elseif CLIENT then
	function ENT:Draw()
		self:DrawModel()
	end
end
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
		self:SetNWBool("OSS_HasKeyboard", true)
	end
	
	function ENT:SpawnFunction( ply, tr, ClassName )

		if ( !tr.Hit ) then return end

		local SpawnPos = tr.HitPos + tr.HitNormal * 1

		local ent = ents.Create( ClassName )
		ent:SetPos( SpawnPos )
		ent:Spawn()


		return ent
	end
function ENT:Touch(ent)
	if ent:GetClass() == "oss_printer" and not self.OSS_HasPrinter and not ent.OSS_ConnectedENT then
		constraint.Rope(self,ent,0,0,Vector(3.409058, 11.653595, 1.217491),Vector(-16.384344, -6.078898, 3.805751),1,140,0,2,"cable/cable2",false)
		self.OSS_HasPrinter = ent
		ent.OSS_ConnectedENT = self
		self:SetNWBool("OSS_HasPrinter", true)
		self:CallOnRemove("OSS_ResetDATA",function() if self.OSS_HasPrinter then self.OSS_HasPrinter.OSS_ConnectedENT = NULL end end)
		ent:CallOnRemove("OSS_ResetDATA2",function() self:SetNWBool("OSS_HasPrinter", false) self.OSS_HasPrinter = false end)
	end
	
end

function ENT:Use(ply)
	if not ply:IsPlayer() then return end
	OSS.OpenDangowsOS(ply, self, self.OS_APP_DataTable, self.OS_INFO_DataTable)
end
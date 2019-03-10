
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

	util.AddNetworkString("OSS_UpdatePCData")

	function ENT:Touch(ent)
		if ent.OSS_IsMonitor and not ent.OSS_Connected and not self.OSS_HasMonitor then
			self.OSS_HasMonitor = true
			constraint.Rope(self,ent,0,0,Vector(-12.994661, 2.543499, 20.294844),ent.ConnectPos,1,140,0,2,"cable/cable2",false)
			ent.OSS_Connected = true
			ent.OSS_ConnectedENT = self
			self.OSS_ConnectedMONENT = ent
			self:CallOnRemove("OSS_ResetDATA",function() self.OSS_ConnectedMONENT.OSS_Connected = false self.OSS_ConnectedMONENT.OSS_ConnectedENT = NULL end)
			ent:CallOnRemove("OSS_ResetDATA2",function() self.OSS_HasMonitor = false self.OSS_ConnectedMONENT = NULL end)
		elseif ent.OSS_IsKeyboard and not ent.OSS_Connected and not self.OSS_HasKeyboard then
			self.OSS_HasKeyboard = true
			constraint.Rope(self,ent,0,0,Vector(-12.994662, 3.065957, 16.138710),ent.ConnectPos,1,140,0,2,"cable/cable2",false)
			ent.OSS_Connected = true
			ent.OSS_ConnectedENT = self
			self.OSS_ConnectedKEYENT = ent
			self:SetNWBool("OSS_HasKeyboard", true)
			self:CallOnRemove("OSS_ResetDATA",function() self.OSS_ConnectedKEYENT.OSS_Connected = false self.OSS_ConnectedKEYENT.OSS_ConnectedENT = NULL end)
			ent:CallOnRemove("OSS_ResetDATA2",function() self.OSS_HasMonitor = false self.OSS_ConnectedKEYENT = NULL self:SetNWBool("OSS_HasKeyboard", false) end)
		elseif ent.OSS_IsGCard then
			self.Card = ent.Card
			ent:Remove()
			net.Start("OSS_UpdatePCData")
				net.WriteEntity(self)
				net.WriteString("GCard")
				net.WriteTable(self.Card)
			net.Broadcast()
		elseif ent.OSS_IsRAM then
			self.RAM = ent.RAM
			ent:Remove()
			net.Start("OSS_UpdatePCData")
				net.WriteEntity(self)
				net.WriteString("RAM")
				net.WriteTable(self.RAM)
			net.Broadcast()
		elseif ent.OSS_IsCore then
			self.Core = ent.Core
			ent:Remove()
			net.Start("OSS_UpdatePCData")
				net.WriteEntity(self)
				net.WriteString("Core")
				net.WriteTable(self.Core)
			net.Broadcast()
		elseif ent:GetClass() == "oss_printer" and not self.OSS_HasPrinter and not ent.OSS_ConnectedENT then
			constraint.Rope(self,ent,0,0,Vector(-12.994662, 3.445280, 14.630802),Vector(-16.384344, -6.078898, 3.805751),1,140,0,2,"cable/cable2",false)
			self.OSS_HasPrinter = ent
			ent.OSS_ConnectedENT = self
			self:SetNWBool("OSS_HasPrinter", true)
			self:CallOnRemove("OSS_ResetDATA",function() self.OSS_HasPrinter.OSS_ConnectedENT = NULL end)
			ent:CallOnRemove("OSS_ResetDATA2",function() self:SetNWBool("OSS_HasPrinter", false) self.OSS_HasPrinter = false end)
		end
	end
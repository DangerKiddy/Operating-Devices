
	--[[-------------------------------------------------------------------------
	Heya, if you here to find something, don't do it!
	Better will ask me in steam about that: https://steamcommunity.com/id/DangerKiddy/

	Copyright @ 2019-2026 OSS
	Creator: DangerKiddy ( https://steamcommunity.com/id/DangerKiddy/ )
	---------------------------------------------------------------------------]]

AddCSLuaFile()

ENT.Type	= "anim"
ENT.PrintName	= "System Block"
ENT.Category	= "OSS Entities"
ENT.Model = "models/props_lab/harddrive02.mdl"

ENT.Spawnable = true
ENT.AdminOnly = false

ENT.Core = OSS.Cores[2]
ENT.RAM = OSS.RAMs[2]
ENT.Memory = OSS.Memory[2]
ENT.Card = OSS.GCard[2]
ENT.IsFirstRun = true
ENT.IsRunned = false
ENT.OS_APP_DataTable = {}
ENT.OS_INFO_DataTable = {}
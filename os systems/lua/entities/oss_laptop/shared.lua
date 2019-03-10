
	--[[-------------------------------------------------------------------------
	Heya, if you here to find something, don't do it!
	Better will ask me in steam about that: https://steamcommunity.com/id/DangerKiddy/

	Copyright @ 2019-2026 OSS
	Creator: DangerKiddy ( https://steamcommunity.com/id/DangerKiddy/ )
	---------------------------------------------------------------------------]]

AddCSLuaFile()

ENT.Type	= "anim"
ENT.PrintName	= "Laptop"
ENT.Category	= "OSS Entities"
ENT.Model = "models/dk_props/oss_models/laptop.mdl"

ENT.Spawnable = true
ENT.AdminOnly = false

ENT.Core = OSS.Cores[4]
ENT.RAM = OSS.RAMs[4]
ENT.Memory = OSS.Memory[1]
ENT.Card = OSS.LaptopGCard[1]
ENT.IsFirstRun = true
ENT.IsRunned = false
ENT.OS_APP_DataTable = {}
ENT.OS_INFO_DataTable = {}
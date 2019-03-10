	--[[-------------------------------------------------------------------------
	Heya, if you here to find something, don't do it!
	Better will ask me in steam about that: https://steamcommunity.com/id/DangerKiddy/

	Copyright @ 2019-2026 OSS
	Creator: DangerKiddy ( https://steamcommunity.com/id/DangerKiddy/ )
	---------------------------------------------------------------------------]]


	util.AddNetworkString("OSS_OpenDangows")
	util.AddNetworkString("OSS_SaveDangowsData")
	util.AddNetworkString("OSS_RemoveDangowsData")
	util.AddNetworkString("OSS_RunPrinter")
	util.AddNetworkString("OSS_UpdatePlyData")
	util.AddNetworkString("OSS_InstallVirus")
	util.AddNetworkString("OSS_DeleteVirus")
	util.AddNetworkString("OSS_SetUpPassword")

	net.Receive("OSS_SetUpPassword",function(len, ply)
		local pswrd = net.ReadString()
		local ent = net.ReadEntity()

		ent:SetNWString("OSS_Password",pswrd)
	end)

	net.Receive("OSS_InstallVirus",function(len, ply)
		local ent = net.ReadEntity()
		local virus = net.ReadInt(32)
		net.Start("OSS_InstallVirus")
			net.WriteEntity(ent)
			net.WriteInt(virus, 32)
		net.Broadcast()
	end)

	net.Receive("OSS_DeleteVirus",function(len, ply)
		local ent = net.ReadEntity()
		local virus = net.ReadInt(32)
		net.Start("OSS_DeleteVirus")
			net.WriteEntity(ent)
			net.WriteInt(virus, 32)
		net.Broadcast()
	end)

	net.Receive("OSS_RunPrinter",function(len, ply)
		local comp = net.ReadEntity()
		local url = net.ReadString()
		local text = net.ReadString()
		if not comp.OSS_HasPrinter then return end
		if url != "NONE" then
			comp.OSS_HasPrinter:Print(nil, url)
		else
			comp.OSS_HasPrinter:Print(text, nil)
		end
	end)

	net.Receive("OSS_SaveDangowsData",function(len, ply)
		local data_APP = net.ReadString()
		local ent = net.ReadEntity()
		local tbldata_OTHER = net.ReadTable()
		if data_APP != "NONE" then
			table.insert(ent.OS_APP_DataTable, data_APP)
		else
			if table.Count(tbldata_OTHER) > 0 then
				if table.Count(ent.OS_INFO_DataTable) > 0 then
					for k, v in pairs(ent.OS_INFO_DataTable) do
						if v.Wallpaper and tbldata_OTHER.Wallpaper then
							v.Wallpaper = tbldata_OTHER.Wallpaper
						end
					end
				else
					table.insert(ent.OS_INFO_DataTable, tbldata_OTHER)
				end
			end
		end
	end)

	net.Receive("OSS_RemoveDangowsData",function(len, ply)
		local data_APP = net.ReadString()
		local ent = net.ReadEntity()
		local tbldata_OTHER = net.ReadTable()
		if data_APP != "NONE" then
			table.RemoveByValue( ent.OS_APP_DataTable, data_APP )
		end
	end)

	function OSS.OpenDangowsOS(ply, ent, OS_APP_DataTable, OS_INFO_DataTable)
		if not ent:GetNWBool("OSS_CanBeused", true) then return end
		net.Start("OSS_OpenDangows")
			net.WriteEntity(ent)
			net.WriteTable(OS_APP_DataTable)
			net.WriteTable(OS_INFO_DataTable)
		net.Send(ply)
		ply:SetNWBool("OSS_IsInOs",true)
		ent:SetNWBool("OSS_CanBeused", false)
	end

	net.Receive("OSS_UpdatePlyData",function(len, ply)
		local ent = net.ReadEntity()
		ply:SetNWBool("OSS_IsInOs",false)
		ent:SetNWBool("OSS_CanBeused", true)
	end)
OSS.Print(0, "Runned SERVER side successfuly")
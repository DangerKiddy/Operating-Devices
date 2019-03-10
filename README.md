# Operating-Devices

SERVER:

OSS.OpenDangowsOS(ply, ent, OS_APP_DataTable, OS_INFO_DataTable)
Opens DangowsOS for player
Args:
		1: Player ply
		2: Entity ent
		3: Table Data of stored apps (Just write here - ent.OS_APP_DataTable)
		4: Table Data of stored other info (Same like with apps - ent.OS_INFO_DataTable)

CLIENT:

OSS.AddCustomSoftware(tbl)
Adds custom software(app) for any OS
Args:
		1: Table tbl - Table of soft data
Example:
		Adds just empty DFrame in apps

		--[[
		n = name
		i = icon
		Weight = Weight of app
		Price = Price of app(nil = free)
		
		ATTENTION!
		If you'll write here any price, it wouldn't be shown in default "freesoftware.com" website, but will be shown on "illegal.com"

		Licensed = Is licensed?("freesoftware.com" shows only licensed soft)

		RAM_Eat = 1 -- How much it will "eat" ram while runned?(Overload)
		Core_Eat = 1 -- How much it will "eat" core while runned?(Overload)
		func = Function for derma, where:
			1: parent = Desktop
			2: key = icon on bottom bar
			3: load on system that adds while runned

		]]
		{n = "My app", i = "icon16/world.png", Weight = 1, Price = nil, Licensed = true, RAM_Eat = 1, Core_Eat = 1, func = function(parent, key, load)
			local sft = vgui.Create( "DFrame", parent )
			sft:SetPos( 100, 100 )
			sft:SetSize( 1200, 600 )
			sft:SetTitle( "Woiwe" )
			sft:SetVisible( true )
			sft:SetDraggable( true )
			sft:ShowCloseButton( true )
			sft:SetSizable(true)
			sft:SetScreenLock(true)
			sft:MakePopup()
			sft.Paint = function(self, w, h)
				draw.RoundedBox( 0, 0, 0, w, h, Color(150,150,150,255) )
			end
			-- for epic super keys sounds
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

			-- enables these buttons
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

			sft.RAM_Eat = 1 -- How much it will "eat" ram while runned?(Overload)
			sft.Core_Eat = 1 -- How much it will "eat" core while runned?(Overload)

			table.insert(parent.OpendApps, sft) --(OPTIONAL) and let's add our app in table of opend apps
			sft.OnClose = function() -- when we close our DFrame
				table.RemoveByValue(parent.OpendApps,sft)
				parent.OverLoad = parent.OverLoad-load -- removes load of our app from system
				parent.BottomBar:RemoveItem(key.GridP) -- i cant' remember what is that, lol
				key:Remove() -- Remove our app from bottom bar
			end

			key.DoClick = function() -- Shows up our app if clicked on icon in bottom bar
				sft:MoveToFront()
				sft:Show()
			end

OSS.Browser.AddPage(url, page, show)
Adds new page to browser
Args:
		1: String url - URL of your page
		2: Function page - Function of your page where:
			Arg#1 = Parent = browser
			Arg#2 = Desktop

		3: Boolean show - Should show in search?

Example:
		-- Default "freesoftware.com" page

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

OSS.OpenSoftWare(tbl, parent)
Opens given software(app)
Args:
		1: Table tbl - info about software
		2: Parent(Desktop)
Example:
		-- Opens browser
		OSS.OpenSoftWare(OSS.DefaultSoftware[2], Parent)

OSS.Dangows.Alert(parent, AlertType, AlertMessage, AlertTittle)
Throws alert(Notofiaction) in the right corner of Dangows OS
Args:
		1: DFrame Desktop
		2: Alert type: 0 - Warning, 1 - Success, 2 - Error
		3: Message in allert
		4(optional): Tittle of alert
Example:
		--Notify player that we successfuly runned app

		hook.Add("OD_OpenedSoftware", "Notifyply", function(parent, tbl, func, load, sft)
			OSS.Dangows.Alert(parent, 1, "App "..tbl.n.." runned!")
		end)	
	
OSS.AddSoftware(grid, tbl, name, nosave, alr)
Adds/Installs given software
Args:
		1: DGrid grid - Grid panel of Desktop (Can be get by parent.DesktopGrid)
		2: Table tbl - Table of soft data
		3: String name - name of soft, used for custom software or default
		4: Boolean nosave - If true, then OD will not save this soft on desktop and add it automatically on desktop
		5: Boolean alr - If true, that will not notify ply, that soft was installed

DangowsOS:
-- Desktop - not global!You can get it in much funcs and in hook "OD_OnDangowsRunned"

Desktop.UsedEntity = entity(computer)
Desktop.OpendApps = All open applications(Table)
Desktop.Memory = Used memory
Desktop.MaxMemory = Max memory of computer
Desktop.OverLoad = OverLoad of device
Dekstop.DesktopGrid = Grid of desktop
Desktop.BottomBar = Bottom bar(DGrid)
Desktop.Wallpaper = Name of file for wallpaper(That stored in "data/oss_files/"))
 
Desktop.UsedEntity.VirusTable = All viruses that have device(Table)
Desktop.UsedEntity:GetNWString("OSS_Password", "NONE") = Returns password of device

Hooks:

OD_OpenedSoftware
Calls when succesfuly runned any soft/app
Args:
		1: parent - Desktop
		2: Table tbl - App/soft info
		3: Function func - Function of app(idk why I decided to add it here)
		4: number load - Overload
		5: DImageButton sft - Button that calls(shows) this app/soft

OD_OnDangowsRunned
Calls when successfuly runned DangowsOS

Args:
		1: DFrame Desktop 

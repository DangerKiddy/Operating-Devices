	--[[-------------------------------------------------------------------------
	Heya, if you here to find something, don't do it!
	Better will ask me in steam about that: https://steamcommunity.com/id/DangerKiddy/

	Copyright @ 2019-2026 OSS
	Creator: DangerKiddy ( https://steamcommunity.com/id/DangerKiddy/ )
	---------------------------------------------------------------------------]]


OSS = OSS or {}
OSS.Dangows = OSS.Dangows or {}
OSS.Currency = "$"

OSS.Cores = {
	{name = "Ontil Core u3", speed = 1.8},
	{name = "Ontil Core u5", speed = 2.5},
	{name = "Ontil Core u7", speed = 3.2},
	{name = "Ontil Core u9", speed = 4.1},
}
OSS.RAMs = {
	{name = "Cristal O1", RAM = 2},
	{name = "Cristal O2", RAM = 4},
	{name = "Cristal O3", RAM = 6},
	{name = "Cristal O4", RAM = 8},
}

OSS.Memory = {
	{name = "Kingdom 100GB", mem = 100},
	{name = "Yromem 300GB", mem = 300},
	{name = "Ontil Memory 600GB", mem = 600},
}

OSS.LaptopGCard = {
	{name = "Nidiva FORCE 100m", mem = 1000, force = 10},
	{name = "Nidiva FORCE 200m", mem = 1100, force = 15},
	{name = "Nidiva FORCE 300m", mem = 1100, force = 20},
	{name = "Nidiva FORCE 400m", mem = 1150, force = 30},
	{name = "Nidiva FORCE 710m", mem = 1110, force = 45},
}

OSS.GCard = {
	{name = "Nidiva FORCE 100", mem = 2000, force = 30},
	{name = "Nidiva FORCE 200", mem = 2100, force = 35},
	{name = "Nidiva FORCE 300", mem = 2100, force = 40},
	{name = "Nidiva FORCE 400", mem = 2150, force = 50},
	{name = "Nidiva FORCE 700", mem = 2110, force = 65},
}

function OSS.Print(stat, txt)
	MsgC((stat == 0 and Color(0,255,0) or stat == 1 and Color(255,187,0) or stat == 2 and Color(255,0,0)), "[OSS] ", color_white, txt.."\n")
end

OSS.Print(0, "Runned SHARED side successfuly")
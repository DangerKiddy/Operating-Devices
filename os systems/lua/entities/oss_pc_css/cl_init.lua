
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

net.Receive("OSS_UpdatePCData",function(len, ply)
	ply = ply || LocalPlayer()
	local self = net.ReadEntity()
	local typ = net.ReadString()
	local tbl = net.ReadTable()
	if typ == "GCard" then
		self.Card = tbl
	elseif typ == "Core" then
		self.Core = tbl
	elseif typ == "RAM" then
		self.RAM = tbl
	end
end)
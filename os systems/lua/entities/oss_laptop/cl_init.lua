
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
	self.CloseParam = self.CloseParam or 1
	if self:GetNWBool("OSS_Shutdown",false) then
		self.CloseParam = Lerp(.1,self.CloseParam, 1)
	else
		self.CloseParam = Lerp(.1,self.CloseParam, 0)
	end
	self:SetPoseParameter("top",self.CloseParam or 1)
end
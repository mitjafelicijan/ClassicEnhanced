local name, ns = ...

ClassicEnhancedDB = {}

ns.Features = {}
ns.Config = {}

local frame = CreateFrame("Frame")
frame:RegisterEvent("PLAYER_ENTERING_WORLD")
frame:SetScript("OnEvent", function(self, event)
	for i = 1, NUM_CHAT_WINDOWS, 1 do
		_G["ChatFrame" .. i .. "EditBox"]:SetAltArrowKeyMode(false)
	end

	hooksecurefunc("FCF_OpenTemporaryWindow", function()
		local cf = FCF_GetCurrentChatFrame():GetName() or nil
		if cf then
			_G[cf .. "EditBox"]:SetAltArrowKeyMode(false)
		end
	end)
end)


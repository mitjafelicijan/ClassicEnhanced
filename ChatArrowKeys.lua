local _, ns = ...

local feature = ns.Register({
  identifier = "ChatArrowKeys",
  description = "Allows arrow keys to be used in chat windows.",
  category = "social",
  frame = nil,
  config = {}
})

feature.frame = CreateFrame("Frame")
feature.frame:RegisterEvent("ADDON_LOADED")

feature.frame:SetScript("OnEvent", function(self, event)
  if not ns.IsEnabled(feature.identifier) then return end
  
  if event == "ADDON_LOADED" then
    for i = 1, NUM_CHAT_WINDOWS, 1 do
      _G["ChatFrame" .. i .. "EditBox"]:SetAltArrowKeyMode(false)
    end

    hooksecurefunc("FCF_OpenTemporaryWindow", function()
      local cf = FCF_GetCurrentChatFrame():GetName() or nil
      if cf then _G[cf .. "EditBox"]:SetAltArrowKeyMode(false) end
    end)

    self:UnregisterEvent("ADDON_LOADED")
  end
end)

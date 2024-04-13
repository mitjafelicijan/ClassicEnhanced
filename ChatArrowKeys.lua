local _, ns = ...

local feature = {
  key = "ChatArrowKeys",
  name = "Allows arrow keys to be used in chat windows.",
  enabled = true,
  frame = nil,
  config = {}
}

tinsert(ns.Features, feature)

if feature.enabled then
  feature.frame = CreateFrame("Frame")
  feature.frame:RegisterEvent("ADDON_LOADED")

  feature.frame:SetScript("OnEvent", function(self, event)
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
end

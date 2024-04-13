local _, ns = ...

local feature = {
  key = "ChatIncreaseHistory",
  name = "Increase chat history length to 4096 lines.",
  enabled = true,
  frame = nil,
  config = {}
}

tinsert(ns.Features, feature)

if feature.enabled then
  feature.frame = CreateFrame("Frame")
  feature.frame:RegisterEvent("ADDON_LOADED")

  feature.frame:SetScript("OnEvent", function(self, event)
    if event == "ADDON_LOADED" then
      -- Process normal chat frames.
      for i = 1, NUM_CHAT_WINDOWS, 1 do
        if (_G["ChatFrame" .. i]:GetMaxLines() ~= 4096) then
          _G["ChatFrame" .. i]:SetMaxLines(4096);
        end
      end

      -- Process temporary chat frames.
      hooksecurefunc("FCF_OpenTemporaryWindow", function()
        local cf = FCF_GetCurrentChatFrame():GetName() or nil
        if cf then
          if (_G[cf]:GetMaxLines() ~= 4096) then
            _G[cf]:SetMaxLines(4096);
          end
        end
      end)

      self:UnregisterEvent("ADDON_LOADED")
    end
  end)
end

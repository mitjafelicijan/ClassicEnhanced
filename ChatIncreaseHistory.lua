local _, ns = ...

local feature = ns.Register({
  identifier = "ChatIncreaseHistory",
  description = "Increase chat history length to 4096 lines.",
  category = "social",
  frame = nil,
  config = {}
})

feature.frame = CreateFrame("Frame")
feature.frame:RegisterEvent("ADDON_LOADED")

feature.frame:SetScript("OnEvent", function(self, event)
  if not ns.IsEnabled(feature.identifier) then return end
  
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

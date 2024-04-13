local _, ns = ...

local feature = {
  key = "HideGryphons",
  name = "Blizzard gryphons will not be shown either side of the main bar.",
  enabled = false,
  frame = nil,
  config = {}
}

tinsert(ns.Features, feature)

if feature.enabled then
  feature.frame = CreateFrame("Frame")
  feature.frame:RegisterEvent("ADDON_LOADED")

  feature.frame:SetScript("OnEvent", function(self, event)
    if event == "ADDON_LOADED" then
      MainMenuBarLeftEndCap:Hide()
      MainMenuBarRightEndCap:Hide()
      self:UnregisterEvent("ADDON_LOADED")
    end
  end)
end

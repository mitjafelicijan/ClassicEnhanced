local _, ns = ...

local feature = ns.Register({
  identifier = "HideGryphons",
  description = "Blizzard gryphons will not be shown either side of the main bar.",
  category = "interface",
  frame = nil,
  config = {}
})

feature.frame = CreateFrame("Frame")
feature.frame:RegisterEvent("ADDON_LOADED")

feature.frame:SetScript("OnEvent", function(self, event)
  if not ns.IsEnabled(feature.identifier) then return end

  if event == "ADDON_LOADED" then
    MainMenuBarLeftEndCap:Hide()
    MainMenuBarRightEndCap:Hide()
    self:UnregisterEvent("ADDON_LOADED")
  end
end)

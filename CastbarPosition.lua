local _, ns = ...

local feature = ns.Register({
  identifier = "CastbarPosition",
  description = "Adjust the position of the casting bar slightly higher from the bottom.",
  category = "interface",
  frame = nil,
  config = {}
})

feature.frame = CreateFrame("Frame")
feature.frame:RegisterEvent("PLAYER_ENTERING_WORLD")
feature.frame:RegisterEvent("UI_SCALE_CHANGED")
feature.frame:RegisterEvent("DISPLAY_SIZE_CHANGED")
feature.frame:RegisterEvent("UNIT_SPELLCAST_SENT")

feature.frame:SetScript("OnEvent", function(self, event)
  if not ns.IsEnabled(feature.identifier) then return end

  CastingBarFrame:SetPoint("BOTTOM", UIParent, "BOTTOM", 0, 270)
end)

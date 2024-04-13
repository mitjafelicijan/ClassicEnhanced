local _, ns = ...

local feature = {
  key = "CastbarPosition",
  name = "Adjust the position of the casting bar slightly higher from the bottom.",
  enabled = true,
  frame = nil,
  config = {}
}

tinsert(ns.Features, feature)

if feature.enabled then
  feature.frame = CreateFrame("Frame")
  feature.frame:RegisterEvent("PLAYER_ENTERING_WORLD")
  feature.frame:RegisterEvent("UI_SCALE_CHANGED")
  feature.frame:RegisterEvent("DISPLAY_SIZE_CHANGED")
  feature.frame:RegisterEvent("UNIT_SPELLCAST_SENT")

  feature.frame:SetScript("OnEvent", function(self, event)
    CastingBarFrame:SetPoint("BOTTOM", UIParent, "BOTTOM", 0, 270)
  end)
end

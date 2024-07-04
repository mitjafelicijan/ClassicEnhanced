local _, ns = ...

local feature = ns.Register({
  identifier = "FishingSound",
  description = "Enhances the environmental sounds when fishing.",
  category = "profession",
  frame = nil,
  config = {}
})

feature.frame = CreateFrame("Frame")
feature.frame:RegisterEvent("PLAYER_ENTERING_WORLD")

feature.frame:SetScript("OnEvent", function(self, event)
  if not ns.IsEnabled(feature.identifier) then
    return
  end

end)

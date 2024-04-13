local _, ns = ...

local feature = ns.Register({
  identifier = "NameplateScaling",
  description = "Nameplates should respect global UI scale.",
  category = "interface",
  frame = nil,
  config = {}
})

feature.frame = CreateFrame("Frame")
feature.frame:RegisterEvent("PLAYER_ENTERING_WORLD")
feature.frame:RegisterEvent("UI_SCALE_CHANGED")
feature.frame:RegisterEvent("CVAR_UPDATE")

feature.frame:SetScript("OnEvent", function(self, event)
  if not ns.IsEnabled(feature.identifier) then
    SetCVar("nameplateGlobalScale", 1.0)
    return
  end
  
  local uiScale = tonumber(GetCVar("uiScale"))
  SetCVar("nameplateGlobalScale", uiScale)
end)

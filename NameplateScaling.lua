local _, ns = ...

local feature = {
  key = "NameplateScaling",
  name = "Nameplates should respect global UI scale.",
  enabled = true,
  frame = nil,
  config = {}
}

tinsert(ns.Features, feature)

if feature.enabled then
  feature.frame = CreateFrame("Frame")
  feature.frame:RegisterEvent("PLAYER_ENTERING_WORLD")
  feature.frame:RegisterEvent("UI_SCALE_CHANGED")
  feature.frame:RegisterEvent("CVAR_UPDATE")

  feature.frame:SetScript("OnEvent", function(self, event)
    local uiScale = tonumber(GetCVar("uiScale"))
    SetCVar("nameplateGlobalScale", uiScale)
  end)
else
  SetCVar("nameplateGlobalScale", 1.0)
end

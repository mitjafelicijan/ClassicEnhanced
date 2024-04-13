local _, ns = ...

local feature = {
  key = "ScreenGlow",
  name = "Disable screen glow which makes the environment less hazy.",
  enabled = true,
  frame = nil,
  config = {}
}

tinsert(ns.Features, feature)

if feature.enabled then
  feature.frame = CreateFrame("Frame")
  feature.frame:RegisterEvent("PLAYER_ENTERING_WORLD")

  feature.frame:SetScript("OnEvent", function(self, event)
    ConsoleExec("ffxGlow 0")
  end)
else
  ConsoleExec("ffxGlow 1")
end

local _, ns = ...

local feature = ns.Register({
  identifier = "ScreenGlow",
  description = "Disable screen glow which makes the environment less hazy.",
  category = "utility",
  frame = nil,
  config = {}
})

feature.frame = CreateFrame("Frame")
feature.frame:RegisterEvent("PLAYER_ENTERING_WORLD")

feature.frame:SetScript("OnEvent", function(self, event)
  if not ns.IsEnabled(feature.identifier) then
    ConsoleExec("ffxGlow 1")
    return
  end

  ConsoleExec("ffxGlow 0")
end)

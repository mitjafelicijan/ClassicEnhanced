local _, ns = ...

local feature = ns.Register({
  identifier = "DruidManaBar",
  description = "Shows druid mana bar when in shapeshifting form.",
  category = "interface",
  frame = nil,
  config = {}
})

feature.frame = CreateFrame("Frame")
feature.frame:RegisterEvent("PLAYER_ENTERING_WORLD")
feature.frame:RegisterEvent("UNIT_DISPLAYPOWER")
feature.frame:RegisterEvent("UNIT_MAXPOWER")
feature.frame:RegisterEvent("UNIT_POWER_UPDATE")

feature.frame:SetScript("OnEvent", function(self, event)
  if not ns.IsEnabled(feature.identifier) then return end

  if event == "PLAYER_ENTERING_WORLD" then
    local _, class = UnitClass("player")
    if class == "DRUID" then
      feature.frame.bar = CreateFrame("StatusBar", nil, PlayerFrame, "TextStatusBar")
      feature.frame.bar:SetStatusBarTexture("Interface\\TargetingFrame\\UI-StatusBar")
      feature.frame.bar:SetSize(104, 10)
      feature.frame.bar:SetPoint("TOPLEFT", PlayerFrame, "TOPLEFT", 114, -66);
      feature.frame.bar:SetStatusBarColor(ns.Config.ManaBarColor.r, ns.Config.ManaBarColor.g, ns.Config.ManaBarColor.b)

      feature.frame.bar.DefaultBackground = feature.frame.bar:CreateTexture(nil, "BACKGROUND")
      feature.frame.bar.DefaultBackground:SetAllPoints(feature.frame.bar)

      feature.frame.bar.DefaultBorder = feature.frame.bar:CreateTexture(nil, "OVERLAY")
      feature.frame.bar.DefaultBorder:SetTexture("Interface\\CharacterFrame\\UI-CharacterFrame-GroupIndicator")
      feature.frame.bar.DefaultBorder:SetTexCoord(0.125, 0.25, 1, 0)
      feature.frame.bar.DefaultBorder:SetHeight(13)
      feature.frame.bar.DefaultBorder:SetPoint("TOPLEFT", 5, 0)
      feature.frame.bar.DefaultBorder:SetPoint("TOPRIGHT", -5, 0)

      feature.frame.bar.DefaultBorderLeft = feature.frame.bar:CreateTexture(nil, "OVERLAY")
      feature.frame.bar.DefaultBorderLeft:SetTexture("Interface\\CharacterFrame\\UI-CharacterFrame-GroupIndicator")
      feature.frame.bar.DefaultBorderLeft:SetTexCoord(0, 0.125, 1, 0)
      feature.frame.bar.DefaultBorderLeft:SetSize(13, 13)
      feature.frame.bar.DefaultBorderLeft:SetPoint("TOPLEFT", -8, 0)

      feature.frame.bar.DefaultBorderRight = feature.frame.bar:CreateTexture(nil, "OVERLAY")
      feature.frame.bar.DefaultBorderRight:SetTexture("Interface\\CharacterFrame\\UI-CharacterFrame-GroupIndicator")
      feature.frame.bar.DefaultBorderRight:SetTexCoord(0.125, 0, 1, 0)
      feature.frame.bar.DefaultBorderRight:SetSize(13, 13)
      feature.frame.bar.DefaultBorderRight:SetPoint("TOPRIGHT", 8, 0)

      feature.frame.bar:SetMinMaxValues(0, UnitPowerMax("player", 0))
      feature.frame.bar:SetValue(UnitPower("player", 0))

      -- Hide by default.
      feature.frame.bar:Hide()

      -- Hide the additional bar if not in shapeshifting form on load.
      local form = GetShapeshiftForm()
      if form == 1 or form == 3 then feature.frame.bar:Show() end
    end
  else
    -- Toggles additional mana bar only in shapeshifting form.
    local form = GetShapeshiftForm()
    if feature.frame and feature.frame.bar then
      feature.frame.bar:SetValue(UnitPower("player", 0))
      if form == 1 or form == 3 then feature.frame.bar:Show() else feature.frame.bar:Hide() end
    end
  end
end)

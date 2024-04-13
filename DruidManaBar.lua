local _, ns = ...

local feature = {
  key = "DruidManaBar",
  name = "Shows druid mana bar when in shapeshifting form.",
  enabled = true,
  frame = nil,
  config = {}
}

tinsert(ns.Features, feature)

if feature.enabled then
  feature.frame = CreateFrame("Frame")
  feature.frame:RegisterEvent("ADDON_LOADED")
  feature.frame:RegisterEvent("UNIT_DISPLAYPOWER")
  feature.frame:RegisterEvent("UNIT_MAXPOWER")
  feature.frame:RegisterEvent("UNIT_POWER_UPDATE")

  feature.frame.bar = nil

  feature.frame:SetScript("OnEvent", function(self, event)
    local _, class = UnitClass("player")
    if class == "DRUID" then
      if event == "ADDON_LOADED" and not feature.frame.bar then
        feature.frame.bar = CreateFrame("StatusBar", nil, PlayerFrame, "TextStatusBar")
        feature.frame.bar:SetStatusBarTexture("Interface\\TargetingFrame\\UI-StatusBar")
        feature.frame.bar:SetSize(104, 10)
        feature.frame.bar:SetPoint("BOTTOMLEFT", 114, 23)
        feature.frame.bar:SetStatusBarColor(ns.Config.ManaBarColor.r, ns.Config.ManaBarColor.g, ns.Config.ManaBarColor.b)

        feature.frame.bar.DefaultBackground = feature.frame.bar:CreateTexture(nil, "BACKGROUND")
        feature.frame.bar.DefaultBackground:SetAllPoints(feature.frame.bar)

        feature.frame.bar.DefaultBorder = feature.frame.bar:CreateTexture(nil, "OVERLAY")
        feature.frame.bar.DefaultBorder:SetTexture("Interface\\CharacterFrame\\UI-CharacterFrame-GroupIndicator")
        feature.frame.bar.DefaultBorder:SetTexCoord(0.125, 0.25, 1, 0)
        feature.frame.bar.DefaultBorder:SetHeight(12)
        feature.frame.bar.DefaultBorder:SetPoint("TOPLEFT", 4, 0)
        feature.frame.bar.DefaultBorder:SetPoint("TOPRIGHT", -4, 0)

        feature.frame.bar.DefaultBorderLeft = feature.frame.bar:CreateTexture(nil, "OVERLAY")
        feature.frame.bar.DefaultBorderLeft:SetTexture("Interface\\CharacterFrame\\UI-CharacterFrame-GroupIndicator")
        feature.frame.bar.DefaultBorderLeft:SetTexCoord(0, 0.125, 1, 0)
        feature.frame.bar.DefaultBorderLeft:SetSize(12, 12)
        feature.frame.bar.DefaultBorderLeft:SetPoint("TOPLEFT", -8, 0)

        feature.frame.bar.DefaultBorderRight = feature.frame.bar:CreateTexture(nil, "OVERLAY")
        feature.frame.bar.DefaultBorderRight:SetTexture("Interface\\CharacterFrame\\UI-CharacterFrame-GroupIndicator")
        feature.frame.bar.DefaultBorderRight:SetTexCoord(0.125, 0, 1, 0)
        feature.frame.bar.DefaultBorderRight:SetSize(12, 12)
        feature.frame.bar.DefaultBorderRight:SetPoint("TOPRIGHT", 8, 0)

        feature.frame.bar:SetMinMaxValues(0, UnitPowerMax("player", 0))
      else
        feature.frame.bar:SetValue(UnitPower("player", 0))
      end

      -- Toggles additional mana bar only in shapeshifting form.
      local form = GetShapeshiftForm()
      if feature.frame.bar then
        if form == 0 then feature.frame.bar:Hide() else feature.frame.bar:Show() end
      end
    end
  end)
end
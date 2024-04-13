local _, ns = ...

local feature = {
  key = "QuestLog",
  name = "Increases the height of quest log selection list.",
  enabled = true,
  frame = nil,
  config = {
    reshaped = false,
    additionalQuests = 6
  }
}

tinsert(ns.Features, feature)

if feature.enabled then
  feature.frame = CreateFrame("Frame")
  feature.frame:RegisterEvent("ADDON_LOADED")

  feature.frame:SetScript("OnEvent", function(self, event)

    if not feature.config.reshaped then
      QuestLogListScrollFrame:SetHeight(184)
      QuestLogListScrollFrame:SetWidth(301)

      -- Create additional quest rows
      local oldQuestsDisplayed = QUESTS_DISPLAYED
      _G.QUESTS_DISPLAYED = _G.QUESTS_DISPLAYED + feature.config.additionalQuests
      for i = oldQuestsDisplayed + 1, QUESTS_DISPLAYED do
        local button = CreateFrame("Button", "QuestLogTitle" .. i, QuestLogFrame, "QuestLogTitleButtonTemplate")
        button:SetID(i)
        button:Hide()
        button:ClearAllPoints()
        button:SetPoint("TOPLEFT", _G["QuestLogTitle" .. (i-1)], "BOTTOMLEFT", 0, 1)
      end

      -- Hide all the textures.
      local regions = { QuestLogFrame:GetRegions() }
      for i=1, #regions do
        regions[i]:Hide()
      end

      -- Show the icon again.
      regions[2]:Show()

      -- Adds a new texture of quest log frame instead of the original one.
      local texture = QuestLogFrame:CreateTexture(nil, "ARTWORK")
      texture:SetAllPoints(true)
      texture:SetTexture("Interface\\AddOns\\ClassicEnhanced\\UI\\QuestLog")
      texture:SetTexCoord(0.0, 0.75, 0.0, 1.0)

      QuestLogDetailScrollFrame:ClearAllPoints()
      QuestLogDetailScrollFrame:SetPoint("TOPLEFT", QuestLogFrame, "TOPLEFT", 20, -265)
      QuestLogDetailScrollFrame:SetWidth(300)
      QuestLogDetailScrollFrame:SetHeight(170)

      feature.config.reshaped = true
    end
  end)
end

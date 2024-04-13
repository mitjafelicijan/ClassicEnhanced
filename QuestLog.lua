local _, ns = ...

local feature = ns.Register({
  identifier = "QuestLog",
  description = "Increases the height and number of Quest Log selection list.",
  category = "interface",
  frame = nil,
  config = {
    additionalQuests = 6
  }
})

feature.frame = CreateFrame("Frame")
feature.frame:RegisterEvent("ADDON_LOADED")

feature.frame:SetScript("OnEvent", function(self, event)
  if not ns.IsEnabled(feature.identifier) then return end
  
  if event == "ADDON_LOADED" then
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

    -- Show quest level in quest log detail frame.
    hooksecurefunc("QuestLog_UpdateQuestDetails", function()
      local quest = GetQuestLogSelection()
      if quest then
        local title, level, suggestedGroup = GetQuestLogTitle(quest)
        if title and level then
          if suggestedGroup then
            if suggestedGroup == LFG_TYPE_DUNGEON then level = level .. "D"
            elseif suggestedGroup == RAID then level = level .. "R"
            elseif suggestedGroup == ELITE then level = level .. "+"
            elseif suggestedGroup == GROUP then level = level .. "+"
            elseif suggestedGroup == PVP then level = level .. "P"
            end
          end
          QuestLogQuestTitle:SetText("[" .. level .. "] " .. title)
        end
      end
    end)

    self:UnregisterEvent("ADDON_LOADED")
  end
end)

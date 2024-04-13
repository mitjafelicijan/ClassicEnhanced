local _, ns = ...

local feature = {
  key = "GearDurability",
  name = "Calculates equiped gear durability and displays it on character panel.",
  enabled = true,
  frame = nil,
  config = {}
}

tinsert(ns.Features, feature)

if feature.enabled then
  feature.frame = CreateFrame("Frame")
  feature.frame:RegisterEvent("ADDON_LOADED")

  local function calculateDurability()
    local totalCurrentDurability = 0
    local totalMaxDurability = 0

    -- Iterate over each equipment slot.
    for slot = 1, 19 do
    local current, max = GetInventoryItemDurability(slot)
      if current and max then
        totalCurrentDurability = totalCurrentDurability + current
        totalMaxDurability = totalMaxDurability + max
      end
    end

    -- Calculate the durability percentage.
    local durabilityPercentage = 0
    if totalMaxDurability > 0 then
      durabilityPercentage = (totalCurrentDurability / totalMaxDurability) * 100
    end

    return durabilityPercentage
  end

  feature.frame:SetScript("OnEvent", function(self, event)
    if event == "ADDON_LOADED" then
      feature.frame.durabilityText = PaperDollFrame:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
  		feature.frame.durabilityText:SetPoint("TOPLEFT", 28, -410)
    end
  end)

  CharacterFrame:HookScript("OnShow", function()
    if feature.frame.durabilityText then
      feature.frame.durabilityText:SetText("Durability: " .. string.format("%.0f%%", calculateDurability()))
    end
  end)
end

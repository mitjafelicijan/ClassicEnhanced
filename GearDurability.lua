local _, ns = ...

local feature = ns.Register({
  identifier = "GearDurability",
  description = "Calculates equiped gear durability and displays it on character panel.",
  category = "interface",
  frame = nil,
  config = {}
})

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
  if not ns.IsEnabled(feature.identifier) then return end

  if event == "ADDON_LOADED" then
    xOffset = 28
    yOffset = -410
    
    local version, build, date, tocversion = GetBuildInfo()

    -- Cata client.
    if tonumber(build) > 50000 then
      xOffset = 22
      yOffset = -400
    end
    feature.frame.durabilityText = PaperDollFrame:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    feature.frame.durabilityText:SetPoint("TOPLEFT", xOffset, yOffset)
    
    CharacterFrame:HookScript("OnShow", function()
      if feature.frame.durabilityText then
        feature.frame.durabilityText:SetText("Durability: " .. string.format("%.0f%%", calculateDurability()))
      end
    end)
    
    self:UnregisterEvent("ADDON_LOADED")
  end
end)


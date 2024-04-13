local _, ns = ...

local feature = {
  key = "ItemLevel",
  name = "Displays item levels in bags and on equiped gear.",
  enabled = true,
  frame = nil,
  config = {
    qualityColors = {
      [0] = {r = 0.5, g = 0.5, b = 0.5},  -- Poor (Gray)
      [1] = {r = 1.0, g = 1.0, b = 1.0},  -- Common (White)
      [2] = {r = 0.1, g = 1.0, b = 0.1},  -- Uncommon (Green)
      [3] = {r = 0.0, g = 0.4, b = 1.0},  -- Rare (Blue)
      [4] = {r = 1.0, g = 0.1, b = 1.0},  -- Epic (Purple)
      [5] = {r = 1.0, g = 0.5, b = 0.0},  -- Legendary (Orange)
      [6] = {r = 0.9, g = 0.8, b = 0.5},  -- Artifact (Yellow)
      [7] = {r = 0.0, g = 1.0, b = 1.0},  -- Heirloom (Light Blue)
      [8] = {r = 0.0, g = 1.0, b = 0.0},  -- WoW Token (Green)
    },
    slots = {
      "HeadSlot", "NeckSlot", "ShoulderSlot", "BackSlot", "ChestSlot", "ShirtSlot",
      "TabardSlot", "WristSlot", "HandsSlot", "WaistSlot", "LegsSlot", "FeetSlot",
      "Finger0Slot", "Finger1Slot", "Trinket0Slot", "Trinket1Slot", "MainHandSlot",
      "SecondaryHandSlot", "RangedSlot"
    }
  }
}

tinsert(ns.Features, feature)

if feature.enabled then
  feature.frame = CreateFrame("Frame")
  feature.frame:RegisterEvent("PLAYER_ENTERING_WORLD")
  feature.frame:RegisterEvent("BAG_UPDATE")
  feature.frame:RegisterEvent("ITEM_UNLOCKED")
  feature.frame:RegisterEvent("UNIT_INVENTORY_CHANGED")

  feature.frame:SetScript("OnEvent", function(self, event)
    -- Clear all existing labels from equiped bags.
    for bagID = 0, NUM_BAG_SLOTS do
      local numSlots = C_Container.GetContainerNumSlots(bagID)
      for slotIndex = 1, numSlots do
        local slotFrameName = "ContainerFrame" .. (bagID + 1) .. "Item" .. (numSlots - slotIndex) + 1 .. "ItemLevelLabel"
        local label = _G[slotFrameName]
        if label then
          label:SetParent(nil)
          _G[slotFrameName] = nil
        end
      end
    end

    -- Loop of equiped bags.
    for bagID = 0, NUM_BAG_SLOTS do
      local numSlots = C_Container.GetContainerNumSlots(bagID)
      for slotIndex = 1, numSlots do
        local item = C_Container.GetContainerItemInfo(bagID, slotIndex)
        if item then
          local frameID = "ContainerFrame" .. (bagID + 1) .. "Item" .. (numSlots - slotIndex) + 1
          local itemName, _, itemQuality, itemLevel, _, itemType, _, _, _, _, _, classID = GetItemInfo(item.itemID)
          local color = feature.config.qualityColors[itemQuality] or {r = 1.0, g = 1.0, b = 1.0} -- Default to white

          if itemLevel and (itemLevel > 1 and (classID == 2 or classID == 4)) then
            local slotFrame = _G[frameID]
            local slotFrameName = frameID .. "ItemLevelLabel"
            local label = slotFrame:CreateFontString(slotFrameName, "OVERLAY", "NumberFontNormal")
            label:SetText(itemLevel)
            label:SetPoint("TOPLEFT", 2, -2)
            label:SetTextColor(color.r, color.g, color.b)
            label:SetShadowColor(0, 0, 0, 1)
          end
        end
      end
    end

    -- Clear all labels from character and loop over equiped gear.
    if event == "UNIT_INVENTORY_CHANGED" or event == "PLAYER_ENTERING_WORLD" then
      for _, slotName in ipairs(feature.config.slots) do
        local slotFrameName = "Character" .. slotName .. "ItemLevelLabel"
        local label = _G[slotFrameName]
        if label then
          label:SetParent(nil)
          _G[slotFrameName] = nil
        end
      end

      for _, slotName in ipairs(feature.config.slots) do
        local slotID = GetInventorySlotInfo(slotName)
        local itemID = GetInventoryItemID("player", slotID)

        if itemID then
          local itemName, _, itemQuality, itemLevel, _, itemType, _, _, _, _, _, classID = GetItemInfo(itemID)
          local color = feature.config.qualityColors[itemQuality] or {r = 1.0, g = 1.0, b = 1.0} -- Default to white

          if itemLevel and (itemLevel > 1 and (classID == 2 or classID == 4)) then
            local slotFrame = _G["Character" .. slotName]
            local slotFrameName = "Character" .. slotName .. "ItemLevelLabel"
            local label = slotFrame:CreateFontString(slotFrameName, "OVERLAY", "NumberFontNormal")
            label:SetText(itemLevel)
            label:SetPoint("TOPLEFT", 2, -2)
            label:SetTextColor(color.r, color.g, color.b)
            label:SetShadowColor(0, 0, 0, 1)
          end
        end
      end
    end
  end)
end

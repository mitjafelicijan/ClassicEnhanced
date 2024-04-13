local _, ns = ...

local feature = {
  key = "VendorPrice",
  name = "Show vendor price of items in various tooltips.",
  enabled = true,
  frame = nil,
  config = {}
}

tinsert(ns.Features, feature)

if feature.enabled then
  feature.frame = CreateFrame("Frame")
  feature.frame:RegisterEvent("ADDON_LOADED")

  feature.frame:SetScript("OnEvent", function(self, event)
    if event == "ADDON_LOADED" then
      local function ShowSellPrice(tooltip, tooltipObject)
        if tooltip.shownMoneyFrames then return end
        
        tooltipObject = tooltipObject or GameTooltip
        
        -- Get container.
        local container = GetMouseFocus()
        if not container then return end
        
        -- Get item.
        local itemName, itemlink = tooltipObject:GetItem()
        if not itemlink then return end
        
        local _, ilink, _, _, _, _, _, _, _, _, sellPrice, classID = GetItemInfo(itemlink)
        if sellPrice and sellPrice > 0 then
          local count = container and type(container.count) == "number" and container.count or 1
          if sellPrice and count > 0 then
            if classID and classID == 11 then count = 1 end -- Fix for quiver/ammo pouch so ammo is not included
            if sellPrice == 4000 and ilink and string.find(ilink, "item:210781:") then
              SetTooltipMoney(tooltip, 2481 * count, "STATIC", SELL_PRICE .. ":")
            else
              SetTooltipMoney(tooltip, sellPrice * count, "STATIC", SELL_PRICE .. ":")
            end
          end
        end
        
        -- Refresh chat tooltips.
        if tooltipObject == ItemRefTooltip then ItemRefTooltip:Show() end
      end

      -- Show vendor price when tooltips are shown.
      GameTooltip:HookScript("OnTooltipSetItem", ShowSellPrice)
      hooksecurefunc(GameTooltip, "SetHyperlink", function(tip) ShowSellPrice(tip, GameTooltip) end)
      hooksecurefunc(ItemRefTooltip, "SetHyperlink", function(tip) ShowSellPrice(tip, ItemRefTooltip) end)

      self:UnregisterEvent("ADDON_LOADED")
    end
  end)
end

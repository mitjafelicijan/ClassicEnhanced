local _, ns = ...

local config = {
  yOffset = -20, -- Starting offset.
  title = "Classic Enhanced",
  categories = {
    interface = { label = "Interface", items = {} },
    utility = { label = "Utilities", items = {} },
    social = { label = "Social & Chat", items = {} },
    automation = { label = "Automation", items = {} },
  }
}

local frame = CreateFrame("FRAME")
frame:RegisterEvent("ADDON_LOADED")

frame:SetScript("OnEvent", function(self, event)
	if event == "ADDON_LOADED" then
    local panel = CreateFrame("Frame", nil, InterfaceOptionsFramePanelContainer)
    panel:SetPoint("TOPLEFT", InterfaceOptionsFramePanelContainer, "TOPLEFT", 4, -4)
    panel:SetPoint("BOTTOMRIGHT", InterfaceOptionsFramePanelContainer, "BOTTOMRIGHT", -4, 4)
    panel.name = config.title

    panel.scrollFrame = CreateFrame("ScrollFrame", nil, panel, "UIPanelScrollFrameTemplate")
    panel.scrollFrame:SetPoint("TOPLEFT", panel, "TOPLEFT", 4, -10)
    panel.scrollFrame:SetPoint("BOTTOMRIGHT", panel, "BOTTOMRIGHT", -34, 10)

    local child = CreateFrame("Frame", nil, panel.scrollFrame)
    child:SetSize(SettingsPanel.Container:GetWidth(), SettingsPanel.Container:GetHeight() - 30)
    panel.scrollFrame:SetScrollChild(child)

    -- Move features to categories.
    for _, item in ipairs(ns.Features) do
      tinsert(config.categories[item.category].items, item)
    end
    
    -- Render categories and options.
    for name, data in pairs(config.categories) do
      config.yOffset = config.yOffset + 30
      local title = child:CreateFontString(nil, "OVERLAY", "GameFontHighlightLarge")
      title:SetPoint("TOPLEFT", 20, -config.yOffset)
      title:SetText(data.label)
      config.yOffset = config.yOffset + 30

      for _, item in ipairs(data.items) do
        local checkbox = CreateFrame("CheckButton", nil, child, "UICheckButtonTemplate")
        checkbox:SetPoint("TOPLEFT", 40, -config.yOffset)
        checkbox:SetSize(30, 30)

        if ClassicEnhancedDB[item.identifier] ~= nil then
          checkbox:SetChecked(ClassicEnhancedDB[item.identifier])
        end
        
        local label = checkbox:CreateFontString(nil, "OVERLAY", "GameFontNormal")
        label:SetPoint("LEFT", checkbox, "RIGHT", 5, 1)
        label:SetText(item.description)

        checkbox:SetScript("OnClick", function(self)
          local checked = self:GetChecked()
          if checked then
            ClassicEnhancedDB[item.identifier] = true
          else
            ClassicEnhancedDB[item.identifier] = false
          end
        end)

        config.yOffset = config.yOffset + 30
      end
    end

    local apply = CreateFrame("Button", nil, panel, "UIPanelButtonTemplate")
    apply:SetPoint("BOTTOMRIGHT", -100, -31)
    apply:SetSize(120, 22)
    apply:SetText("Apply changes")
    apply:SetScript("OnClick", function(self)
      ReloadUI()
    end)

    InterfaceOptions_AddCategory(panel)

    self:UnregisterEvent("ADDON_LOADED")
  end
end)

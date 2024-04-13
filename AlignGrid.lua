local _, ns = ...

local feature = ns.Register({
  identifier = "AlignGrid",
  description = "Draws an align grid on a screen if Ctrl+Alt+Shift is being pressed.",
  category = "utility",
  frame = nil,
  config = {}
})

feature.frame = CreateFrame("Frame")
feature.frame:RegisterEvent("ADDON_LOADED")
feature.frame:RegisterEvent("MODIFIER_STATE_CHANGED")

feature.frame:SetScript("OnEvent", function(self, event)
  if not ns.IsEnabled(feature.identifier) then return end

  if event == "ADDON_LOADED" then
    feature.frame.grid = CreateFrame("Frame")
    feature.frame.grid:Hide()
    feature.frame.grid:SetAllPoints(UIParent)

    local w, h = GetScreenWidth() * UIParent:GetEffectiveScale(), GetScreenHeight() * UIParent:GetEffectiveScale()
    local ratio = w / h
    local sqsize = w / 20
    local wline = floor(sqsize - (sqsize % 2))
    local hline = floor(sqsize / ratio - ((sqsize / ratio) % 2))

    -- Plot vertical lines.
    for i = 0, wline do
      local t = feature.frame.grid:CreateTexture(nil, "BACKGROUND")
      if i == wline / 2 then t:SetColorTexture(1, 1, 0, 0.7) else t:SetColorTexture(0, 0, 0, 0.7) end
      t:SetPoint("TOPLEFT", feature.frame.grid, "TOPLEFT", i * w / wline - 1, 0)
      t:SetPoint("BOTTOMRIGHT", feature.frame.grid, "BOTTOMLEFT", i * w / wline + 1, 0)
    end

    -- Plot horizontal lines.
    for i = 0, hline do
      local t = feature.frame.grid:CreateTexture(nil, "BACKGROUND")
      if i == hline / 2 then	t:SetColorTexture(1, 1, 0, 0.7) else t:SetColorTexture(0, 0, 0, 0.7) end
      t:SetPoint("TOPLEFT", feature.frame.grid, "TOPLEFT", 0, -i * h / hline + 1)
      t:SetPoint("BOTTOMRIGHT", feature.frame.grid, "TOPRIGHT", 0, -i * h / hline - 1)
    end
  end

  if IsControlKeyDown() and IsShiftKeyDown() and IsAltKeyDown() then
    feature.frame.grid:Show()
  else
    feature.frame.grid:Hide()
  end

  self:UnregisterEvent("ADDON_LOADED")
end)

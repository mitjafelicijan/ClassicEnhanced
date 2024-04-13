local _, ns = ...

local feature = ns.Register({
  identifier = "BagSearch",
  description = "Adds ability to search your equiped bags and bank bags.",
  category = "interface",
  frame = nil,
  config = {}
})

feature.frame = CreateFrame("Frame")
feature.frame:RegisterEvent("ADDON_LOADED")

feature.frame:SetScript("OnEvent", function(self, event)
  if not ns.IsEnabled(feature.identifier) then return end

  if event == "ADDON_LOADED" then
    local BagItemSearchBox = CreateFrame("EditBox", "BagItemSearchBox", ContainerFrame1, "BagSearchBoxTemplate")
    BagItemSearchBox:SetSize(110, 18)
    BagItemSearchBox:SetMaxLetters(15)

    local BankItemSearchBox = CreateFrame("EditBox", "BankItemSearchBox", BankFrame, "BagSearchBoxTemplate")
    BankItemSearchBox:SetSize(120, 14)
    BankItemSearchBox:SetMaxLetters(15)
    BankItemSearchBox:SetPoint("TOPRIGHT", -60, -40)

    hooksecurefunc("ContainerFrame_Update", function(self)
      if self:GetID() == 0 then
        BagItemSearchBox:SetParent(self)
        BagItemSearchBox:SetPoint("TOPLEFT", self, "TOPLEFT", 54, -29)
        BagItemSearchBox.anchorBag = self
        BagItemSearchBox:Show()
      elseif BagItemSearchBox.anchorBag == self then
        BagItemSearchBox:ClearAllPoints()
        BagItemSearchBox:Hide()
        BagItemSearchBox.anchorBag = nil
      end
    end)

    self:UnregisterEvent("ADDON_LOADED")
  end
end)

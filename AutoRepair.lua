local _, ns = ...

local feature = ns.Register({
  identifier = "AutoRepair",
  description = "Automatically initiates gear repairs upon interacting with a merchant.",
  category = "automation",
  frame = nil,
  config = {}
})

feature.frame = CreateFrame("Frame")
feature.frame:RegisterEvent("ADDON_LOADED")
feature.frame:RegisterEvent("MERCHANT_SHOW")

feature.frame:SetScript("OnEvent", function(self, event)
  if not ns.IsEnabled(feature.identifier) then return end

  if IsShiftKeyDown() then return end
  if CanMerchantRepair() then
    local RepairCost, CanRepair = GetRepairAllCost()
    if RepairCost > 0 and GetMoney() >= RepairCost then
      RepairAllItems()
      print("Gear has been repaired.", string.format("(%s)", GetCoinText(RepairCost)))
    end
  end
end)
